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
# TOTAL ACC CREATE VMESS
total1=$(grep -c -E "^### " "/usr/local/etc/xray/config.json")
# TOTAL ACC CREATE VLESS
total2=$(grep -c -E "^### " "/usr/local/etc/xray/vless.json")
# TOTAL ACC CREATE VLESS XTLS
total3=$(grep -c -E "^### " "/usr/local/etc/xray/xtls.json")
clear
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- ifconfig.me/ip);
echo -e ""
echo -e "   \e[$line══════════════════════════════════════════\e[m"
echo -e "   \e[$back_text   \e[30m═[\e[$box PANEL XRAY VMESS WEBSOCKET TLS\e[30m ]═   \e[m"
echo -e "   \e[$line══════════════════════════════════════════\e[m"
echo -e "    \e[$number (•1)\e[m \e[$below Create Vmess Websocket Account\e[m"
echo -e "    \e[$number (•2)\e[m \e[$below Delete Vmess Websocket Account\e[m"
echo -e "    \e[$number (•3)\e[m \e[$below Renew Vmess Account\e[m"
echo -e "    \e[$number (•4)\e[m \e[$below Show Config Vmess Account\e[m"
echo -e "    \e[$number (•5)\e[m \e[$below Check User Login Vmess\e[m"
echo -e ""
echo -e "    \e[$number    >> Total :\e[m \e[$below ${total1} Client\e[m"
echo -e "   \e[$line══════════════════════════════════════════\e[m"
echo -e "   \e[$back_text   \e[30m═[\e[$box PANEL XRAY VLESS WEBSOCKET TLS\e[30m ]═   \e[m"
echo -e "   \e[$line══════════════════════════════════════════\e[m"
echo -e "    \e[$number (•6)\e[m \e[$below Create Vless Websocket Account\e[m"
echo -e "    \e[$number (•7)\e[m \e[$below Deleting Vless Websocket Account\e[m"
echo -e "    \e[$number (•8)\e[m \e[$below Renew Vless Account\e[m"
echo -e "    \e[$number (•9)\e[m \e[$below Show Config Vless Account\e[m"
echo -e "    \e[$number (10)\e[m \e[$below Check User Login Vless\e[m"
echo -e ""
echo -e "    \e[$number    >> Total :\e[m \e[$below ${total2} Client\e[m"
echo -e "   \e[$line══════════════════════════════════════════\e[m"
echo -e "   \e[$back_text\e[30m═[\e[$box XRAY VLESS TCP XTLS(Direct & Splice)\e[30m ]═\e[m"
echo -e "   \e[$line══════════════════════════════════════════\e[m"
echo -e "    \e[$number (11)\e[m \e[$below Create Xray VLess XTLS Account\e[m"
echo -e "    \e[$number (12)\e[m \e[$below Deleting Xray Vless XTLS Account\e[m"
echo -e "    \e[$number (13)\e[m \e[$below Renew Xray Vless XTLS Account\e[m"
echo -e "    \e[$number (14)\e[m \e[$below Show Config Vless XTLS Account\e[m"
echo -e "    \e[$number (15)\e[m \e[$below Check User Login Xray Vless XTLS\e[m"
echo -e ""
echo -e "    \e[$number    >> Total :\e[m \e[$below ${total3} Client\e[m"
echo -e "   \e[$line══════════════════════════════════════════\e[m"
echo -e "   \e[$back_text  \e[$box x)   MENU                              \e[m"
echo -e "   \e[$line══════════════════════════════════════════\e[m"
echo -e "\e[$line"
read -p "        Please Input Number  [1-15 or x] :  "  xvmess
echo -e ""
case $xvmess in
1)
add-ws
;;
2)
del-ws
;;
3)
renew-ws
;;
4)
show-ws
;;
5)
cek-ws
;;
6)
add-vless
;;
7)
del-vless
;;
8)
renew-vless
;;
9)
show-vless
;;
10)
cek-vless
;;
11)
add-xray
;;
12)
del-xray
;;
13)
renew-xray
;;
14)
show-xray
;;
15)
cek-xray
;;
x)
menu
;;
*)
echo "Please enter an correct number"
sleep 1
xraay
;;
esac