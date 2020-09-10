#!/bin/bash
# setup NAT gate service

## LAN, private interface
## LANNET, private network 
## WAN, public interface

## set interface name first. 

LAN="enp4s0"
WAN="enp3s0"

LANNET="192.168.110.0/24"

### Do not edit the following contents. 

export LAN WAN LANNET

### Flush the original rules
/sbin/iptables -F
/sbin/iptables -X
/sbin/iptables -Z
/sbin/iptables -F -t nat
/sbin/iptables -X -t nat
/sbin/iptables -Z -t nat

### load modules
modprobe ip_tables         > /dev/null 2>&1
modprobe iptable_nat       > /dev/null 2>&1
modprobe ip_nat_ftp       > /dev/null 2>&1
modprobe ip_nat_irc       > /dev/null 2>&1
modprobe ipt_mark       > /dev/null 2>&1
modprobe ip_conntrack       > /dev/null 2>&1
modprobe ip_conntrack_ftp   > /dev/null 2>&1
modprobe ip_conntrack_irc   > /dev/null 2>&1
modprobe ipt_MASQUERADE   > /dev/null 2>&1

### enable the client to use VPN service
modprobe ip_nat_pptp > /dev/null 2>&1
modprobe ip_nat_proto_gre  > /dev/null 2>&1
modprobe ip_conntrack_pptp  > /dev/null 2>&1
modprobe ip_nat_ftp  > /dev/null 2>&1


# Set Default Rules
/sbin/iptables -P INPUT	ACCEPT
/sbin/iptables -P OUTPUT  ACCEPT
/sbin/iptables -P FORWARD	ACCEPT
/sbin/iptables -t nat -P PREROUTING  ACCEPT
/sbin/iptables -t nat -P POSTROUTING ACCEPT
/sbin/iptables -t nat -P OUTPUT      ACCEPT


### Accept ping test
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A OUTPUT -p icmp --icmp-type echo-reply -j ACCEPT


### For NAT Gateway
# Starting NAT Server
echo "1" > /proc/sys/net/ipv4/ip_forward

# Stop NAT immediately
#echo "0" > /proc/sys/net/ipv4/ip_forward

# POSTROUTE  NAT Client
/sbin/iptables -t nat -A POSTROUTING -s $LANNET -o $WAN -j MASQUERADE


# the following two lines Enable iptables work in High Efficiency
/sbin/iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

# 5 may be useful for some sites, 
#	configure the MTU value. 
iptables -A FORWARD -p tcp -m tcp --tcp-flags SYN,RST SYN -m tcpmss \
          --mss 1400:1536 -j TCPMSS --clamp-mss-to-pmtu



