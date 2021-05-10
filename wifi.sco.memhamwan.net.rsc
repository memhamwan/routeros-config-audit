# RouterOS 6.48.1
# software id = Q2AC-305B
#
# model = RB912R-2nD
# serial number = AFFB0A2BECC3
/interface lte
set [ find ] name=lte1
/interface bridge
add admin-mac=74:4D:28:58:7F:CD auto-mac=no comment=defconf name=bridge
/interface wireless
set [ find default-name=wlan1 ] antenna-gain=0 band=2ghz-b/g/n channel-width=\
    20/40mhz-Ce country="united states3" disabled=no distance=indoors \
    frequency=auto mode=ap-bridge ssid=HamWAN station-roaming=enabled \
    wireless-protocol=802.11
/interface ethernet
set [ find default-name=ether1 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full
/interface list
add comment=defconf name=WAN
add comment=defconf name=LAN
/interface lte apn
set [ find default=yes ] apn=h2g2 name="Google Fi"
/interface wireless security-profiles
set [ find default=yes ] authentication-types=wpa-psk,wpa2-psk group-ciphers=\
    tkip supplicant-identity=MikroTik unicast-ciphers=tkip
/ip pool
add name=default-dhcp ranges=192.168.87.10-192.168.87.254
/ip dhcp-server
add address-pool=default-dhcp disabled=no interface=wlan1 name=defconf
/snmp community
set [ find default=yes ] addresses=44.0.0.0/8
/user group
set full policy="local,telnet,ssh,ftp,reboot,read,write,policy,test,winbox,pas\
    sword,web,sniff,sensitive,api,romon,dude,tikapp"
/interface bridge port
add bridge=bridge comment=defconf interface=ether1
/ip neighbor discovery-settings
set discover-interface-list=none
/interface list member
add comment=defconf interface=bridge list=LAN
add comment=defconf interface=lte1 list=WAN
/interface wireless cap
set caps-man-addresses=192.168.88.1 interfaces=wlan1
/ip address
add address=192.168.87.1/24 interface=bridge network=192.168.87.0
add address=44.34.128.43/28 interface=bridge network=44.34.128.32
/ip dhcp-server network
add address=192.168.87.0/24 comment=defconf gateway=192.168.87.1
/ip dns
set allow-remote-requests=yes servers=8.8.8.8,8.8.4.4
/ip dns static
add address=192.168.88.1 name=router.lan
/ip firewall nat
add action=masquerade chain=srcnat comment="defconf: masquerade" \
    ipsec-policy=out,none out-interface=bridge out-interface-list=WAN
/ip firewall service-port
set ftp disabled=yes
/ip route
add distance=1 gateway=44.34.128.39
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www disabled=yes
set ssh port=222
set api disabled=yes
set winbox disabled=yes
set api-ssl disabled=yes
/ip ssh
set forwarding-enabled=remote strong-crypto=yes
/snmp
set enabled=yes
/system clock
set time-zone-autodetect=no time-zone-name=America/Chicago
/system gps
set coordinate-format=dms enabled=yes port=serial0 set-system-time=yes
/system identity
set name=wifi.sco.memhamwan.net
/system ntp client
set enabled=yes server-dns-names=ntp.memhamwan.net
/system scheduler
add interval=10m name=schedule1 on-event=script1 policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=may/29/2019 start-time=02:46:20
/system script
add dont-require-permissions=no name=script1 owner=turnrye policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="#\
    \_credit to hhspiny\
    \n#\
    \n# Variables\
    \n# Username and password are long cryptic ones Google Domains generates f\
    or your dynDomain,\
    \n# IT IS NOT your regular Google account Username and Password\
    \n# \
    \n:local GoogleDNSUsername \"DbZWnRuF9mObFHBA\"\
    \n:local GoogleDNSPassword \"nt2woIRum0sHaTag\"\
    \n:local hostName \"lte.mcneil.turnrye.com\"\
    \n:local currentIP \"\"\
    \n:local setResults \"\"\
    \n:local previousIP \"\"\
    \n\
    \n# get the current IP address from a dhcp-client identified by a preset C\
    OMMENT FILL THIS IN BELOW\
    \n:set currentIP [/ip address get [find interface=lte1] address]\
    \n# Strip netmask\
    \n:for i from=( [:len \$currentIP] - 1) to=0 step=-1 do={ \
    \n:if ( [:pick \$currentIP \$i] = \"/\") do={ \
    \n:set currentIP [:pick \$currentIP 0 \$i]\
    \n} \
    \n}\
    \n\
    \n# comment OUT line below for DEBUGGING your GET IP ADDRESS command\
    \n#:log info (\"currentIP_to_SEND_to_google_DEBUGGING: \$currentIP\")\
    \n\
    \n:set previousIP [:resolve \"\$hostName\"]\
    \n\
    \n:if (\$currentIP != \$previousIP) do={\
    \n:do {\
    \n/tool fetch url=\"https://\$GoogleDNSUsername:\$GoogleDNSPassword@domain\
    s.google.com/nic/update\?hostname=\$hostName&myip=\$currentIP\" mode=https\
    \_dst-path=GoogleDNS.txt\
    \n:set setResults [/file get GoogleDNS.txt contents];\
    \n:log info (\"GoogleDNS said this: \$setResults\")\
    \n} on-error={ \
    \n:log error (\"GoogleDNS: script failed to set new IP address\") \
    \n}\
    \n}"
/tool bandwidth-server
set authenticate=no enabled=no
/tool mac-server
set allowed-interface-list=none
/tool mac-server mac-winbox
set allowed-interface-list=none
/tool mac-server ping
set enabled=no
/tool romon
set enabled=yes