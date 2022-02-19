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
xtr="$(cat ~/log-install.txt | grep -w "Trojan TCP TLS" | cut -d: -f2|sed 's/ //g')"
xtrgr="$(cat ~/log-install.txt | grep -w "Trojan GRPC TLS" | cut -d: -f2|sed 's/ //g')"
echo -e "\e[0;34m.-----------------------------------------.\e[0m"
echo -e "\e[0;34m|         \e[1;33mCHANGE PORT XRAY TROJAN\e[m         \e[0;34m|\e[0m"
echo -e "\e[0;34m'-----------------------------------------'\e[0m"
echo -e " \e[1;31m>>\e[0m\e[0;32mChange Port For Trojan:\e[0m"
echo -e "  [1]  Change Port Xray Trojan TCP TLS $xtr"
echo -e "  [2]  Change Port Xray Trojan GRPC TLS $xtrgr"
echo -e "========================================"
echo -e "  [x]  Back To Menu Change Port"
echo -e "  [y]  Go To Main Menu"
echo -e ""
read -p "   Select From Options [1-2 or x & y] :  " prot
echo -e ""
case $prot in
1)
read -p "New Port Xray Trojan TCP TLS: " tr2
if [ -z $tr2 ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $tr2)
if [[ -z $cek ]]; then
sed -i "s/$xtr/$tr2/g" /usr/local/etc/xray/trojan.json
sed -i "s/   - XRAY Trojan TCP TLS     : $xtr/   - XRAY Trojan TCP TLS     : $tr2/g" /root/log-install.txt
iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport $xtr -j ACCEPT
iptables -D INPUT -m state --state NEW -m udp -p udp --dport $xtr -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $tr2 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport $tr2 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save > /dev/null
netfilter-persistent reload > /dev/null
systemctl restart xray@trojan > /dev/null
echo -e "\e[032;1mPort $tr2 modified successfully\e[0m"
else
echo -e "\e[1;31mPort $tr2 is used\e[0m"
fi
;;
2)
read -p "New Port Xray Trojan GRPC TLS: " tr2
if [ -z $tr2 ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $tr2)
if [[ -z $cek ]]; then
sed -i "s/$xtrgr/$tr2/g" /usr/local/etc/xray/trojangrpc.json
sed -i "s/   - XRAY Trojan GRPC TLS    : $xtrgr/   - XRAY Trojan GRPC TLS    : $tr2/g" /root/log-install.txt
iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport $xtrgr -j ACCEPT
iptables -D INPUT -m state --state NEW -m udp -p udp --dport $xtrgr -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $tr2 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport $tr2 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save > /dev/null
netfilter-persistent reload > /dev/null
systemctl restart xray@trojangrpc > /dev/null
echo -e "\e[032;1mPort $tr2 modified successfully\e[0m"
else
echo -e "\e[1;31mPort $tr2 is used\e[0m"
fi
;;
x)
clear
change-port
;;
y)
clear
menu
;;
*)
echo "Please enter an correct number"
;;
esac