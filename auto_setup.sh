#!/bin/bash

# Run as root user. 
# Caution. 
# In ubuntu, trojan run by nobody. 
# In Debian buster, trojan runs by root.
apt -y update
apt -y upgrade
apt -y install trojan


## please enter your domain name. 
echo -e "Please input your domain name, then press enter to confirm."
read domain

apt -y install gnutls-bin gnutls-doc wget

mkdir self_signed
cd self_signed/
wget https://raw.githubusercontent.com/iamid0/centos/master/ca.tmpl
wget https://raw.githubusercontent.com/iamid0/centos/master/server.tmpl

#sed -i 's/OK/baidu.com/g' *tmpl
sed -i "s/OK/${domain}/g" *tmpl

certtool --generate-privkey --outfile ca-key.pem
certtool --generate-self-signed --load-privkey ca-key.pem --template ca.tmpl --outfile ca-cert.pem
certtool --generate-privkey --outfile server-key.pem
certtool --generate-certificate --load-privkey server-key.pem --load-ca-certificate ca-cert.pem --load-ca-privkey ca-key.pem --template server.tmpl --outfile server-cert.pem

cp server*pem /etc/trojan/
cd /etc/trojan/

cp config.json config.json.original
sed -i 's/\/path\/to\/certificate.crt/\/etc\/trojan\/server-cert.pem/g' config.json
sed -i 's/\/path\/to\/private.key/\/etc\/trojan\/server-key.pem/g' config.json

## generate radom password. 
pass1=`head /dev/urandom | tr -dc A-Za-z0-9 | head -c 16 ; echo ''`
pass2=`head /dev/urandom | tr -dc A-Za-z0-9 | head -c 16 ; echo ''`

sed -i "s/password1/${pass1}/g" config.json
sed -i "s/password2/${pass2}/g" config.json

## in ubuntu, trojan runs by nobody， 
## change the user to root
sed -i 's/User=nobody/User=root/g' /lib/systemd/system/trojan.service


systemctl daemon-reload
systemctl enable trojan
systemctl stop trojan
systemctl start trojan

### enable bbr
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p

echo "BBR enabled." 

echo "Your server address is:"
echo "${domain}"
echo "The password is:"
echo "${pass1}"
echo "Or, "
echo "${pass2}"
echo "Bye."
