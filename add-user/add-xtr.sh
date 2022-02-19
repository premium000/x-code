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
# PROVIDED
creditt=$(cat /root/provided)
# TEXT ON BOX COLOUR
box=$(cat /etc/box)
# LINE COLOUR
line=$(cat /etc/line)
# BACKGROUND TEXT COLOUR
back_text=$(cat /etc/back)
clear
uuid=$(cat /proc/sys/kernel/random/uuid)
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /usr/local/etc/xray/domain)
else
domain=$IP
fi
xtr="$(cat ~/log-install.txt | grep -w "Trojan TCP TLS" | cut -d: -f2|sed 's/ //g')"
echo -e   "  \e[$line═══════════════════════════════════════════════════════\e[m"
echo -e   "  \e[$back_text          \e[30m[\e[$box CREATE USER XRAY TROJAN TCP TLS\e[30m ]\e[1m          \e[m"
echo -e   "  \e[$line═══════════════════════════════════════════════════════\e[m"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
		read -rp "   Password: " -e user
		user_EXISTS=$(grep -w $user /usr/local/etc/xray/akunxtr.conf | wc -l)

		if [[ ${user_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done
read -p "   Bug Address (Example: www.google.com) : " address
read -p "   Bug SNI (Example : m.facebook.com) : " sni
read -p "   Expired (days) : " masaaktif
bug_addr=${address}.
bug_addr2=$address
if [[ $address == "" ]]; then
sts=$bug_addr2
else
sts=$bug_addr
fi
harini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#tr$/a\### '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","password": "'""$user""'","email": "'""$user""'"' /usr/local/etc/xray/trojan.json
echo -e "### $user $exp $harini $uuid" >> /usr/local/etc/xray/akunxtr.conf
systemctl restart xray@trojan
trojanlink="trojan://${user}@${sts}${domain}:${xtr}?sni=$sni#${user}"
clear
echo -e ""
echo -e "\e[$line════════[Xray Trojan TCP]════════\e[m"
echo -e "Remarks         : ${user}"
echo -e "Domain          : ${domain}"
echo -e "IP/Host         : ${MYIP}"
echo -e "Port            : ${xtr}"
echo -e "Key             : ${user}"
echo -e "Network         : TCP"
echo -e "AllowInsecure   : True"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Pantang Larang $creditt Shop"
echo -e "‼️Aktiviti Berikut Adalah Dilarang(ID akan di ban tanpa notis & tiada refund)"
echo -e "\e[31m❌ Torrent (p2p, streaming p2p)"
echo -e "\e[31m❌ PS4"
echo -e "\e[31m❌ Porn"
echo -e "\e[31m❌ Ddos Server"
echo -e "\e[31m❌ Mining Bitcoins"
echo -e "\e[31m❌ Abuse Usage"
echo -e "\e[31m❌ Multi-Login ID"
echo -e "\e[31m❌ Sharing Premium Config\e[m"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Trojan   : ${trojanlink}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Created    : $harini"
echo -e "Expired    : $exp"
echo -e "Script By $creditt"
