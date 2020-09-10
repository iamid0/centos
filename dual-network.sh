#!/bin/bash
# ethtool -P eth0
# Permanent address
# ethtool -P eth1

#### Please review these settings first. 
WAN="enp3s0"
LAN="enp4s0"

WAN_IP="59.59.59.59"
LAN_IP="192.168.168.168"

WAN_GateWay_IP="59.59.59.254"
LAN_GateWay_IP="192.168.168.254"

LAN_Range="192.168.168.0"
LAN_Mask="255.255.255.0"

export WAN LAN WAN_IP LAN_IP LAN_Range LAN_Mask

#### Do not edit the following contents. 


ifconfig $WAN down
ifconfig $LAN down

# use default mac address
#ifconfig $WAN hw ether 00:e0:1c:3c:24:62
ifconfig $WAN  $WAN_IP netmask 255.255.255.0


#ifconfig $LAN hw ether 18:03:73:d9:c0:3f
ifconfig $LAN  $LAN_IP netmask 255.255.255.0


ifconfig $LAN up
ifconfig $WAN up

### 192.168.168.0/24 --> -net 192.168.168.0 netmask 255.255.255.0 
### ask your sysadmin Or ISP for details. 
route add -net $LAN_Range netmask $LAN_Mask gw $LAN_GateWay_IP dev $LAN
route add default gw $WAN_GateWay_IP dev $WAN

### Setup namesers
cp /etc/resolv.conf /etc/resolv.conf.bak
rm -fr /etc/resolv.conf
touch /etc/resolv.conf
chmod go+rx /etc/resolv.conf


## new DNS needed.
#echo "nameserver       2001:470:20::2" >> /etc/resolv.conf
echo "nameserver        10.10.10.10" >> /etc/resolv.conf
