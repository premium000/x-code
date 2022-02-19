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
# Update & Installing Requirement
apt update -y
apt upgrade -y
apt install socat -y
apt install python -y
apt install curl -y
apt install wget -y
apt install sed -y
apt install nano -y
apt install python3 -y

domain=$(cat /root/domain)
apt install iptables iptables-persistent -y
apt install curl socat xz-utils wget apt-transport-https gnupg gnupg2 gnupg1 dnsutils lsb-release -y 
apt install socat cron bash-completion ntpdate -y
ntpdate pool.ntp.org
apt -y install chrony
timedatectl set-ntp true
systemctl enable chronyd && systemctl restart chronyd
systemctl enable chrony && systemctl restart chrony
timedatectl set-timezone Asia/Kuala_Lumpur
chronyc sourcestats -v
chronyc tracking -v
date

# Acc Trojan XRAY TCP TLS
mkdir -p /usr/local/etc/xray/
touch /usr/local/etc/xray/akunxtr.conf
# Acc Trojan XRAY GRPC TLS
mkdir -p /usr/local/etc/xray/
touch /usr/local/etc/xray/akunxtrgrpc.conf
# install xray
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install
# generate certificates
mkdir /root/.acme.sh
curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
chmod +x /root/.acme.sh/acme.sh
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /usr/local/etc/xray/xray.crt --keypath /usr/local/etc/xray/xray.key --ecc
service squid start
uuid=$(cat /proc/sys/kernel/random/uuid)
cat> /usr/local/etc/xray/config.json << END
{
  "log": {
    "access": "/var/log/xray/access.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "info"
  },
  "inbounds": [
    {
      "port": 443,
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "${uuid}",
            "alterId": 2
#tls
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "security": "tls",
        "tlsSettings": {
          "certificates": [
            {
              "certificateFile": "/usr/local/etc/xray/xray.crt",
              "keyFile": "/usr/local/etc/xray/xray.key"
            }
          ]
        },
        "wsSettings": {
          "path": "/premium000",
          "headers": {
            "Host": ""
          }
         },
        "quicSettings": {},
        "sockopt": {
          "mark": 0,
          "tcpFastOpen": true
        }
      },
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      },
      "domain": "$domain"
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "ip": [
          "0.0.0.0/8",
          "10.0.0.0/8",
          "100.64.0.0/10",
          "169.254.0.0/16",
          "172.16.0.0/12",
          "192.0.0.0/24",
          "192.0.2.0/24",
          "192.168.0.0/16",
          "198.18.0.0/15",
          "198.51.100.0/24",
          "203.0.113.0/24",
          "::1/128",
          "fc00::/7",
          "fe80::/10"
        ],
        "outboundTag": "blocked"
      },
      {
        "type": "field",
        "outboundTag": "blocked",
        "protocol": [
          "bittorrent"
        ]
      }
    ]
  }
}
END
cat> /usr/local/etc/xray/none.json << END
{
  "log": {
    "access": "/var/log/xray/access.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "info"
  },
  "inbounds": [
    {
      "port": 80,
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "${uuid}",
            "alterId": 2
#none
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {
          "path": "/premium000",
          "headers": {
            "Host": ""
          }
         },
        "quicSettings": {},
        "sockopt": {
          "mark": 0,
          "tcpFastOpen": true
        }
      },
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      },
      "domain": "$domain"
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "ip": [
          "0.0.0.0/8",
          "10.0.0.0/8",
          "100.64.0.0/10",
          "169.254.0.0/16",
          "172.16.0.0/12",
          "192.0.0.0/24",
          "192.0.2.0/24",
          "192.168.0.0/16",
          "198.18.0.0/15",
          "198.51.100.0/24",
          "203.0.113.0/24",
          "::1/128",
          "fc00::/7",
          "fe80::/10"
        ],
        "outboundTag": "blocked"
      },
      {
        "type": "field",
        "outboundTag": "blocked",
        "protocol": [
          "bittorrent"
        ]
      }
    ]
  }
}
END
cat> /usr/local/etc/xray/vless.json << END
{
  "log": {
    "access": "/var/log/xray/access2.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "info"
  },
  "inbounds": [
    {
      "port": 8443,
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "${uuid}"
#tls
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "security": "tls",
        "tlsSettings": {
          "certificates": [
            {
              "certificateFile": "/usr/local/etc/xray/xray.crt",
              "keyFile": "/usr/local/etc/xray/xray.key"
            }
          ]
        },
        "wsSettings": {
          "path": "/premium000",
          "headers": {
            "Host": ""
          }
         },
        "quicSettings": {},
        "sockopt": {
          "mark": 0,
          "tcpFastOpen": true
        }
      },
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "ip": [
          "0.0.0.0/8",
          "10.0.0.0/8",
          "100.64.0.0/10",
          "169.254.0.0/16",
          "172.16.0.0/12",
          "192.0.0.0/24",
          "192.0.2.0/24",
          "192.168.0.0/16",
          "198.18.0.0/15",
          "198.51.100.0/24",
          "203.0.113.0/24",
          "::1/128",
          "fc00::/7",
          "fe80::/10"
        ],
        "outboundTag": "blocked"
      },
      {
        "type": "field",
        "outboundTag": "blocked",
        "protocol": [
          "bittorrent"
        ]
      }
    ]
  }
}
END
cat> /usr/local/etc/xray/vnone.json << END
{
  "log": {
    "access": "/var/log/xray/access2.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "info"
  },
  "inbounds": [
    {
      "port": 8880,
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "${uuid}"
#none
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {
          "path": "/premium000",
          "headers": {
            "Host": ""
          }
         },
        "quicSettings": {},
        "sockopt": {
          "mark": 0,
          "tcpFastOpen": true
        }
      },
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      },
      "domain": "$domain"
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "ip": [
          "0.0.0.0/8",
          "10.0.0.0/8",
          "100.64.0.0/10",
          "169.254.0.0/16",
          "172.16.0.0/12",
          "192.0.0.0/24",
          "192.0.2.0/24",
          "192.168.0.0/16",
          "198.18.0.0/15",
          "198.51.100.0/24",
          "203.0.113.0/24",
          "::1/128",
          "fc00::/7",
          "fe80::/10"
        ],
        "outboundTag": "blocked"
      },
      {
        "type": "field",
        "outboundTag": "blocked",
        "protocol": [
          "bittorrent"
        ]
      }
    ]
  }
}
END
cat> /usr/local/etc/xray/xtls.json << END
{
    "log": {
	    "access": "/var/log/xray/access3.log",
        "error": "/var/log/xray/error.log",
        "loglevel": "info"
    },
    "inbounds": [
        {
            "port": 9443,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "${uuid}",
                        "flow": "xtls-rprx-direct",
                        "level": 0
#xtls
                  }
                ],
                "decryption": "none",
                "fallbacks": [
                    {
                        "dest": 80
                    }
                ]
            },
            "streamSettings": {
                "network": "tcp",
                "security": "xtls",
                "xtlsSettings": {
                    "alpn": [
                        "http/1.1"
                    ],
                    "certificates": [
                        {
                            "certificateFile": "/usr/local/etc/xray/xray.crt",
                            "keyFile": "/usr/local/etc/xray/xray.key"
                        }
                    ]
                }
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
END
cat> /usr/local/etc/xray/trojan.json << END
{
    "log": {
	    "access": "/var/log/xray/access4.log",
        "error": "/var/log/xray/error.log",
        "loglevel": "info"
    },
	"inbounds": [
        {
            "port": 2087,
            "protocol": "trojan",
            "settings": {
                "clients": [
                    {
					    "id": "$uuid",
						"password": "testmnj"
#tr
                    }
                ]
            },
            "streamSettings": {
                "network": "tcp",
                "security": "tls",
                "tlsSettings": {
                    "alpn": [
                        "http/1.1"
                    ],
                    "certificates": [
                        {
                            "certificateFile": "/usr/local/etc/xray/xray.crt",
                            "keyFile": "/usr/local/etc/xray/xray.key"
                        }
                    ]
                }
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
END
cat> /usr/local/etc/xray/trojangrpc.json << END
{
    "log": {
     "access": "/var/log/xray/access6.log",
        "error": "/var/log/xray/error.log",
        "loglevel": "info"
    },
 "inbounds": [
        {
            "port": 2088,
            "protocol": "trojan",
            "settings": {
                "clients": [
                    {
         "id": "$uuid",
         "password": "love"
#tr
                    }
                ]
            },
          "streamSettings": {
                "network": "gun",
                "security": "tls",
                "tlsSettings": {
                    "serverName": "$domain",
                    "alpn": [
                        "h2"
                    ],
                    "certificates": [
                        {
                            "certificateFile": "/usr/local/etc/xray/xray.crt",
                            "keyFile": "/usr/local/etc/xray/xray.key"
                        }
                    ]
                },
                "grpcSettings": {
                    "serviceName": "GunService"
                }
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom",
            "tag": "direct"
        }
    ]
}
END
# starting xray vmess ws tls core on sytem startup
cat> /etc/systemd/system/xray.service << END
[Unit]
Description=XRay Core Service ( %i )
Documentation=https://v-code.com https://github.com/XTLS/Xray-core
After=network.target nss-lookup.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray -config /usr/local/etc/xray/%i.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target

END

# starting xray vmess ws none tls core on sytem startup
cat> /etc/systemd/system/xray@none.service << END
[Unit]
Description=XRay Core Service ( %i )
Documentation=https://v-code.com https://github.com/XTLS/Xray-core
After=network.target nss-lookup.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray -config /usr/local/etc/xray/%i.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target

END

# starting xray vless ws tls core on sytem startup
cat> /etc/systemd/system/xray@vless.service << END
[Unit]
Description=XRay Core Service ( %i )
Documentation=https://v-code.com https://github.com/XTLS/Xray-core
After=network.target nss-lookup.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray -config /usr/local/etc/xray/%i.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target

END

# starting xray vless ws none tls core on sytem startup
cat> /etc/systemd/system/xray@vnone.service << END
[Unit]
Description=XRay Core Service ( %i )
Documentation=https://v-code.com https://github.com/XTLS/Xray-core
After=network.target nss-lookup.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray -config /usr/local/etc/xray/%i.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target

END

# starting xray xtls-direct core on sytem startup
cat> /etc/systemd/system/xray@xtls.service << END
[Unit]
Description=XRay Core Service ( %i )
Documentation=https://v-code.com https://github.com/XTLS/Xray-core
After=network.target nss-lookup.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray -config /usr/local/etc/xray/%i.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target

END

# starting xray Trojan TCP core on sytem startup
cat> /etc/systemd/system/xray@trojan.service << END
[Unit]
Description=XRay Core Service ( %i )
Documentation=https://v-code.com https://github.com/XTLS/Xray-core
After=network.target nss-lookup.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray -config /usr/local/etc/xray/%i.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target

END

# starting xray Trojan grpc core on sytem startup
cat> /etc/systemd/system/xray@trojangrpc.service << END
[Unit]
Description=XRay Core Service ( %i )
Documentation=https://v-code.com https://github.com/XTLS/Xray-core
After=network.target nss-lookup.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray -config /usr/local/etc/xray/%i.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target

END

iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 8443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 8880 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 9443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 2087 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 2088 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 80 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 8443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 8880 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 9443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 2087 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 2088 -j ACCEPT

iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload
systemctl daemon-reload
# enable xray vmess & vless ws
systemctl enable xray@none.service
systemctl start xray@none.service
systemctl enable xray@vless.service
systemctl start xray@vless.service
systemctl enable xray@vnone.service
systemctl start xray@vnone.service
systemctl restart xray@vless
systemctl restart xray@vnone
systemctl restart xray
systemctl enable xray

# enable xray vless xtls direct & splice
systemctl daemon-reload
systemctl enable xray@xtls.service
systemctl start xray@xtls.service
systemctl restart xray@xtls
systemctl enable xray@xtls
systemctl start xray@xtls

# enable xray trojan tcp tls
systemctl daemon-reload
systemctl enable xray@trojan.service
systemctl start xray@trojan.service
systemctl restart xray@trojan

# enable xray trojan grpc tls
systemctl daemon-reload
systemctl enable xray@trojangrpc.service
systemctl start xray@trojangrpc.service
systemctl restart xray@trojangrpc

# download script
cd /usr/bin
wget -O add-ws "https://raw.githubusercontent.com/${GitUser}/x-code/main/add-user/add-ws.sh"
wget -O add-vless "https://raw.githubusercontent.com/${GitUser}/x-code/main/add-user/add-vless.sh"
wget -O del-ws "https://raw.githubusercontent.com/${GitUser}/x-code/main/delete-user/del-ws.sh"
wget -O del-vless "https://raw.githubusercontent.com/${GitUser}/x-code/main/delete-user/del-vless.sh"
wget -O cek-ws "https://raw.githubusercontent.com/${GitUser}/x-code/main/cek-user/cek-ws.sh"
wget -O cek-vless "https://raw.githubusercontent.com/${GitUser}/x-code/main/cek-user/cek-vless.sh"
wget -O renew-ws "https://raw.githubusercontent.com/${GitUser}/x-code/main/renew-user/renew-ws.sh"
wget -O renew-vless "https://raw.githubusercontent.com/${GitUser}/x-code/main/renew-user/renew-vless.sh"
wget -O port-xray "https://raw.githubusercontent.com/${GitUser}/x-code/main/change-port/port-xray.sh"
wget -O port-xray "https://raw.githubusercontent.com/${GitUser}/x-code/main/change-port/port-xray.sh"
wget -O port-wg "https://raw.githubusercontent.com/${GitUser}/x-code/main/change-port/port-wg.sh"
wget -O port-trojan "https://raw.githubusercontent.com/${GitUser}/x-code/main/change-port/port-trojan.sh"
wget -O certv2ray "https://raw.githubusercontent.com/${GitUser}/x-code/main/cert.sh"
wget -O trojaan "https://raw.githubusercontent.com/${GitUser}/x-code/main/menu/trojaan.sh"
wget -O add-xray "https://raw.githubusercontent.com/${GitUser}/x-code/main/add-user/add-xray.sh"
wget -O del-xray "https://raw.githubusercontent.com/${GitUser}/x-code/main/delete-user/del-xray.sh"
wget -O renew-xray "https://raw.githubusercontent.com/${GitUser}/x-code/main/renew-user/renew-xray.sh"
wget -O cek-xray "https://raw.githubusercontent.com/${GitUser}/x-code/main/cek-user/cek-xray.sh"
wget -O xraay "https://raw.githubusercontent.com/${GitUser}/x-code/main/menu/xraay.sh"
wget -O add-xtr "https://raw.githubusercontent.com/${GitUser}/x-code/main/add-user/add-xtr.sh"
wget -O del-xtr "https://raw.githubusercontent.com/${GitUser}/x-code/main/delete-user/del-xtr.sh"
wget -O renew-xtr "https://raw.githubusercontent.com/${GitUser}/x-code/main/renew-user/renew-xtr.sh"
wget -O cek-xtr "https://raw.githubusercontent.com/${GitUser}/x-code/main/cek-user/cek-xtr.sh"
wget -O add-trgr "https://raw.githubusercontent.com/${GitUser}/x-code/main/add-user/add-trgr.sh"
wget -O del-trgr "https://raw.githubusercontent.com/${GitUser}/x-code/main/delete-user/del-trgr.sh"
wget -O renew-trgr "https://raw.githubusercontent.com/${GitUser}/x-code/main/renew-user/renew-trgr.sh"
wget -O cek-trgr "https://raw.githubusercontent.com/${GitUser}/x-code/main/cek-user/cek-trgr.sh"
wget -O show-ws "https://raw.githubusercontent.com/${GitUser}/x-code/main/show-user/show-ws.sh"
wget -O show-vless "https://raw.githubusercontent.com/${GitUser}/x-code/main/show-user/show-vless.sh"
wget -O show-xray "https://raw.githubusercontent.com/${GitUser}/x-code/main/show-user/show-xray.sh"
wget -O show-trgr "https://raw.githubusercontent.com/${GitUser}/x-code/main/show-user/show-trgr.sh"
wget -O show-xtr "https://raw.githubusercontent.com/${GitUser}/x-code/main/show-user/show-xtr.sh"
chmod +x add-ws
chmod +x add-vless
chmod +x del-ws
chmod +x del-vless
chmod +x cek-ws
chmod +x cek-vless
chmod +x renew-ws
chmod +x renew-vless
chmod +x port-xray
chmod +x port-xray
chmod +x port-wg
chmod +x port-trojan
chmod +x certv2ray
chmod +x trojaan
chmod +x add-xray
chmod +x del-xray
chmod +x renew-xray
chmod +x cek-xray
chmod +x xraay
chmod +x add-xtr
chmod +x del-xtr
chmod +x renew-xtr
chmod +x cek-xtr
chmod +x add-trgr
chmod +x del-trgr
chmod +x renew-trgr
chmod +x cek-trgr
chmod +x show-ws
chmod +x show-vless
chmod +x show-xray 
chmod +x show-trgr
chmod +x show-xtr

cd
rm -f ins-xray.sh
mv /root/domain /usr/local/etc/xray/domain

