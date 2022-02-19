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
tls="$(cat ~/log-install.txt | grep -w "Vmess WS TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vmess WS None TLS" | cut -d: -f2|sed 's/ //g')"
tlsvl="$(cat ~/log-install.txt | grep -w "Vless WS TLS" | cut -d: -f2|sed 's/ //g')"
nonevl="$(cat ~/log-install.txt | grep -w "Vless WS None TLS" | cut -d: -f2|sed 's/ //g')"
xtls="$(cat ~/log-install.txt | grep -w "Vless Xtls DIRECT" | cut -d: -f2|sed 's/ //g')"
vvmess="$(cat ~/log-install.txt | grep -w "Vmess Grpc TLS" | cut -d: -f2|sed 's/ //g')"
vvless="$(cat ~/log-install.txt | grep -w "Vless Grpc TLS" | cut -d: -f2|sed 's/ //g')"
echo -e "\e[0;34m.-----------------------------------------.\e[0m"
echo -e "\e[0;34m|             \e[1;33mCHANGE PORT XRAY\e[m             \e[0;34m|\e[0m"
echo -e "\e[0;34m'-----------------------------------------'\e[0m"
echo -e " \e[1;31m>>\e[0m\e[0;32mChange Port For Xray Vmess WS:\e[0m"
echo -e "  [1]  Change Port Xray Vmess WS TLS $tls"
echo -e "  [2]  Change Port Xray Vmess WS None TLS $none"
echo -e "========================================"
echo -e ""
echo -e " \e[1;31m>>\e[0m\e[0;32mChange Port For Xray Vless WS:\e[0m"
echo -e "  [3]  Change Port Xray Vless WS TLS $tlsvl"
echo -e "  [4]  Change Port Xray Vless WS None TLS $nonevl"
echo -e "========================================"
echo -e ""
echo -e " \e[1;31m>>\e[0m\e[0;32mChange Port For Xray Vless TCP XTLS:\e[0m"
echo -e "  [5]  Change Port Xray Vless Xtls $xtls"
echo -e "========================================"
echo -e "  [x]  Back To Menu Change Port"
echo -e "  [y]  Go To Main Menu"
echo -e ""
read -p "   Select From Options [1-5 or x & y] :  " prot
echo -e ""
case $prot in
1)
read -p "New Port Xray Vmess WS TLS: " tls1
if [ -z $tls1 ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $tls1)
if [[ -z $cek ]]; then
sed -i "s/$tls/$tls1/g" /usr/local/etc/xray/config.json
sed -i "s/   - XRAY Vmess WS TLS       : $tls/   - XRAY Vmess WS TLS       : $tls1/g" /root/log-install.txt
iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport $tls -j ACCEPT
iptables -D INPUT -m state --state NEW -m udp -p udp --dport $tls -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $tls1 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport $tls1 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save > /dev/null
netfilter-persistent reload > /dev/null
systemctl restart xray > /dev/null
echo -e "\e[032;1mPort $tls1 modified successfully\e[0m"
else
echo -e "\e[1;31mPort $tls1 is used\e[0m"
fi
;;
2)
echo "Input Only 2 Character (eg : 69)"
read -p "New Port Xray Vmess WS None TLS: " none1
if [ -z $none1 ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $none1)
if [[ -z $cek ]]; then
sed -i "s/$none/$none1/g" /usr/local/etc/xray/none.json
sed -i "s/   - XRAY Vmess WS None TLS  : $none/   - XRAY Vmess WS None TLS  : $none1/g" /root/log-install.txt
iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport $none -j ACCEPT
iptables -D INPUT -m state --state NEW -m udp -p udp --dport $none -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $none1 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport $none1 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save > /dev/null
netfilter-persistent reload > /dev/null
systemctl restart xray@none > /dev/null
echo -e "\e[032;1mPort $none1 modified successfully\e[0m"
else
echo -e "\e[1;31mPort $none1 is used\e[0m"
fi
;;
3)
read -p "New Port Xray Vless WS TLS: " tls1
if [ -z $tls1 ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $tls1)
if [[ -z $cek ]]; then
sed -i "s/$tlsvl/$tls1/g" /usr/local/etc/xray/vless.json
sed -i "s/   - XRAY Vless WS TLS       : $tlsvl/   - XRAY Vless WS TLS       : $tls1/g" /root/log-install.txt
iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport $tlsvl -j ACCEPT
iptables -D INPUT -m state --state NEW -m udp -p udp --dport $tlsvl -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $tls1 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport $tls1 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save > /dev/null
netfilter-persistent reload > /dev/null
systemctl restart xray@vless > /dev/null
echo -e "\e[032;1mPort $tls1 modified successfully\e[0m"
else
echo -e "\e[1;31mPort $tls1 is used\e[0m"
fi
;;
4)
read -p "New Port Xray Vless WS None TLS: " none1
if [ -z $none1 ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $none1)
if [[ -z $cek ]]; then
sed -i "s/$nonevl/$none1/g" /usr/local/etc/xray/vnone.json
sed -i "s/   - XRAY Vless WS None TLS  : $nonevl/   - XRAY Vless WS None TLS  : $none1/g" /root/log-install.txt
iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport $nonevl -j ACCEPT
iptables -D INPUT -m state --state NEW -m udp -p udp --dport $nonevl -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $none1 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport $none1 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save > /dev/null
netfilter-persistent reload > /dev/null
systemctl restart xray@vnone > /dev/null
echo -e "\e[032;1mPort $none1 modified successfully\e[0m"
else
echo -e "\e[1;31mPort $none1 is used\e[0m"
fi
;;
5)
read -p "New Port Xray Vless TCP XTLS: " xtls1
if [ -z $xtls1 ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $xtls1)
if [[ -z $cek ]]; then
sed -i "s/$xtls/$xtls1/g" /usr/local/etc/xray/xtls.json
sed -i "s/   - XRAY Vless Xtls DIRECT  : $xtls/   - XRAY Vless Xtls DIRECT  : $xtls1/g" /root/log-install.txt
iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport $xtls -j ACCEPT
iptables -D INPUT -m state --state NEW -m udp -p udp --dport $xtls -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $xtls1 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport $xtls1 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save > /dev/null
netfilter-persistent reload > /dev/null
systemctl restart xray@xtls > /dev/null
echo -e "\e[032;1mPort $xtls1 modified successfully\e[0m"
else
echo -e "\e[1;31mPort $xtls1 is used\e[0m"
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
