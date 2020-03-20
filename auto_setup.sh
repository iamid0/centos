# Run as root user. 
# Caution. 
# In ubuntu, trojan run by nobody. 
# In Debian buster, trojan runs by root.

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

cp config.json config.json.original
sed -i 's/\/path\/to\/certificate.crt/\/etc\/trojan\/server-cert.pem/g' config.json
sed -i 's/\/path\/to\/private.key/\/etc\/trojan\/server-key.pem/g' config.json
sed -i 's/password1/default_login1/g' config.json
sed -i 's/password2/default_login2/g' config.json

## in ubuntu, trojan runs by nobody， 
## change the use to root
sed -i 's/User=nobody/User=root/g' /lib/systemd/system/trojan.service


systemctl daemon-reload
systemctl enable trojan
systemctl stop trojan
systemctl start trojan

echo "The password is:"
echo "default_login1"
echo "Or, "
echo "default_login2"
echo "Bye."
