#!/bin/bash
#wget https://github.com/${GitUser}/
GitUser="premium000"
#IZIN SCRIPT
MYIP=$(curl -sS ipv4.icanhazip.com)
# Valid Script
VALIDITY () {
    today=`date -d "0 days" +"%Y-%m-%d"`
    Exp1=$(curl https://raw.githubusercontent.com/${GitUser}/ipxray/main/ipvps.conf | grep $MYIP | awk '{print $4}')
    if [[ $today < $Exp1 ]]; then
    echo -e "\e[32mYOUR SCRIPT ACTIVE..\e[0m"
    else
    echo -e "\e[31mYOUR SCRIPT HAS EXPIRED!\e[0m";
    echo -e "\e[31mPlease renew your ipvps first\e[0m"
    exit 0
fi
}
IZIN=$(curl https://raw.githubusercontent.com/${GitUser}/ipxray/main/ipvps.conf | awk '{print $5}' | grep $MYIP)
if [ $MYIP = $IZIN ]; then
echo -e "\e[32mPermission Accepted...\e[0m"
VALIDITY
else
echo -e "\e[31mPermission Denied!\e[0m";
echo -e "\e[31mPlease buy script first\e[0m"
exit 0
fi
clear
RED='\e[1;31m'
GREEN='\e[0;32m'
BLUE='\e[0;34m'
NC='\e[0m'

#Input Domain
ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn4="$(cat ~/log-install.txt | grep -w "OpenVPN SSL" | cut -d: -f2|sed 's/ //g')"
clear
echo ""
echo -e "${BLUE}=====================================================${NC}"
echo -e "                    Add Domain"
echo -e "${BLUE}=====================================================${NC}"
echo ""
echo "Please Input Your Pointing Domain In Cloudflare "
read -rp "Domain/Host: " -e host
echo "IP=$host" >> /var/lib/premium-script/ipvps.conf
#rm -f /home/homain
echo "$host" > /usr/local/etc/xray/domain
domain=$(cat /usr/local/etc/xray/domain)
echo -e "[${GREEN}Done${NC}]"

#Update Sertificate SSL
echo "Automatical Update Your Sertificate SSL"
sleep 3
echo Starting Update SSL Sertificate
sleep 0.5
source /var/lib/premium-script/ipvps.conf
domain=$IP
systemctl stop xray
systemctl stop xray@vless
systemctl stop xray@xtls
systemctl stop xray@trojan
systemctl stop xray@trojangrpc
# GENERATE CRT
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /usr/local/etc/xray/xray.crt --keypath /usr/local/etc/xray/xray.key --ecc
systemctl start xray
systemctl start xray@vless
systemctl start xray@xtls
systemctl start xray@trojan
systemctl start xray@trojangrpc
#Done
echo -e "[${GREEN}Done${NC}]"
echo "Location Your Domain : /usr/local/etc/xray/domain"
