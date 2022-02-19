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
# LINE COLOUR
line=$(cat /etc/line)
# TEXT COLOUR BELOW
below=$(cat /etc/below)
# BACKGROUND TEXT COLOUR
back_text=$(cat /etc/back)
# NUMBER COLOUR
number=$(cat /etc/number)
# TEXT ON BOX COLOUR
box=$(cat /etc/box)
# TOTAL ACC TROJAN
total1=$(grep -c -E "^### " "/usr/local/etc/xray/trojan.json")
# TOTAL ACC TROJAN GRPC
total2=$(grep -c -E "^### " "/usr/local/etc/xray/trojangrpc.json")
clear
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- ifconfig.me/ip);
clear
echo -e ""
echo -e "   \e[$line════════════════════════════════════════\e[m"
echo -e "   \e[$back_text          \e[30m═[\e[$box TROJAN TCP TLS\e[30m ]═          \e[m"
echo -e "   \e[$line════════════════════════════════════════\e[m"
echo -e "   \e[$number (•1)\e[m \e[$below Create Trojan TCP TLS Account\e[m"
echo -e "   \e[$number (•2)\e[m \e[$below Deleting Trojan TCP TLS Account\e[m"
echo -e "   \e[$number (•3)\e[m \e[$below Renew Xray Trojan TCP TLS Account\e[m"
echo -e "   \e[$number (•4)\e[m \e[$below Show Config Trojan TCP TLS Account\e[m"
echo -e "   \e[$number (•5)\e[m \e[$below Check User Login Trojan TCP TLS\e[m"
echo -e ""
echo -e "    \e[$number    >> Total :\e[m \e[$below ${total1} Client\e[m"
echo -e "   \e[$line════════════════════════════════════════\e[m"
echo -e "   \e[$back_text         \e[30m═[\e[$box TROJAN GRPC TLS\e[30m ]═          \e[m"
echo -e "   \e[$line════════════════════════════════════════\e[m"
echo -e "   \e[$number (•6)\e[m \e[$below Create Trojan GRPC TLS Account\e[m"
echo -e "   \e[$number (•7)\e[m \e[$below Deleting Trojan GRPC TLS Account\e[m"
echo -e "   \e[$number (•8)\e[m \e[$below Renew Xray Trojan GRPC TLS Account\e[m"
echo -e "   \e[$number (•9)\e[m \e[$below Show Config Trojan GRPC TLS Account\e[m"
echo -e "   \e[$number (10)\e[m \e[$below Check User Login Trojan GRPC TLS\e[m"
echo -e ""
echo -e "    \e[$number    >> Total :\e[m \e[$below ${total2} Client\e[m"
echo -e "   \e[$line════════════════════════════════════════\e[m"
echo -e "   \e[$back_text \e[$box x)   MENU                             \e[m"
echo -e "   \e[$line════════════════════════════════════════\e[m"
echo -e "\e[$line"
read -p "      Please Input Number  [1-10 or x] :  "  xtr
echo -e ""
case $xtr in
1)
add-xtr
;;
2)
del-xtr
;;
3)
renew-xtr
;;
4)
show-xtr
;;
5)
cek-xtr
;;
6)
add-trgr
;;
7)
del-trgr
;;
8)
renew-trgr
;;
9)
show-trgr
;;
10)
cek-trgr
;;
x)
menu
;;
*)
echo "Please enter an correct number"
sleep 1
trojaan
;;
esac
