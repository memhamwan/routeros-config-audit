# RouterOS 6.48.3
# software id = 5UCR-RL1W
#
# model = RouterBOARD cAP 2n
# serial number = 5C1D05AAE004
/interface bridge
add admin-mac=E4:8D:8C:F0:EE:E4 auto-mac=no comment=defconf fast-forward=no \
    name=bridge
/interface wireless
set [ find default-name=wlan1 ] band=2ghz-b/g/n channel-width=20/40mhz-Ce \
    country="united states" disabled=no distance=indoors frequency=auto mode=\
    ap-bridge ssid=HamWAN station-roaming=enabled wireless-protocol=802.11
/interface ethernet
set [ find default-name=ether1 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full
/interface wireless security-profiles
set [ find default=yes ] authentication-types=wpa-psk,wpa2-psk mode=\
    dynamic-keys supplicant-identity=MikroTik
/ip pool
add name=dhcp_pool1 ranges=192.168.0.2-192.168.0.254
add name=dhcp_pool2 ranges=192.168.0.2-192.168.0.254
/ip dhcp-server
add address-pool=dhcp_pool2 authoritative=after-2sec-delay disabled=no \
    interface=wlan1 name=dhcp1
/routing ospf instance
set [ find default=yes ] distribute-default=if-installed-as-type-1 in-filter=\
    AMPR-default out-filter=AMPR-default redistribute-bgp=as-type-1 \
    redistribute-connected=as-type-1 redistribute-other-ospf=as-type-1 \
    router-id=44.34.129.119
/snmp community
set [ find default=yes ] addresses=44.34.128.0/21
/user group
set full policy="local,telnet,ssh,ftp,reboot,read,write,policy,test,winbox,pas\
    sword,web,sniff,sensitive,api,romon,dude,tikapp"
/ip neighbor discovery-settings
set discover-interface-list=all
/ip address
add address=44.34.129.119/28 interface=ether1 network=44.34.129.112
add address=192.168.0.1/24 interface=wlan1 network=192.168.0.0
/ip dhcp-server network
add address=192.168.0.0/24 dns-server=44.34.128.190,8.8.8.8,8.8.4.4 gateway=\
    192.168.0.1
/ip dns
set servers=44.34.128.190
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www disabled=yes
set ssh port=222
set api disabled=yes
set winbox disabled=yes
set api-ssl disabled=yes
/ip smb shares
set [ find default=yes ] directory=/pub
/ip ssh
set forwarding-enabled=remote strong-crypto=yes
/routing filter
add action=accept chain=AMPR-default prefix=44.0.0.0/8 prefix-length=8-32
add action=accept chain=AMPR-default prefix=0.0.0.0/0
add action=reject chain=AMPR-default
/routing ospf interface
add authentication=md5 interface=ether1 network-type=broadcast
/routing ospf network
add area=backbone network=44.34.129.112/28
/snmp
set enabled=yes
/system clock
set time-zone-name=America/Los_Angeles
/system identity
set name=omn2.crw
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