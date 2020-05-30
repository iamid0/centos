#!/bin/bash
# ethtool -P eth0
# Permanent address
# ethtool -P eth1

WAN="enp3s0"
LAN="enp4s0"
LANNET="192.168.110.0/24"
export WAN LAN LANNET



ifconfig $WAN down
ifconfig $LAN down

# use default mac address
#ifconfig $WAN hw ether 00:e0:1c:3c:24:62
ifconfig $WAN 59.59.59.59 netmask 255.255.255.0


#ifconfig $LAN hw ether 18:03:73:d9:c0:3f
ifconfig $LAN 192.168.168.168 netmask 255.255.255.0


ifconfig $LAN up
ifconfig $WAN up

route add -net 192.9.0.0 netmask 255.255.0.0 gw 192.168.168.254 dev $LAN
route add default gw 59.59.59.254 dev $WAN

### Setup namesers
rm -fr /etc/resolv.conf
touch /etc/resolv.conf
chmod go+rx /etc/resolv.conf


## new DNS needed.
#echo "nameserver       2001:470:20::2" >> /etc/resolv.conf
echo "nameserver        10.10.10.10" >> /etc/resolv.conf
