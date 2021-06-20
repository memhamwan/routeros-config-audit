# RouterOS 6.48.3
# software id = DKLM-2VLX
#
# model = RouterBOARD DynaDish G-5HacD r3
# serial number = 705E07ADDBA3
/interface bridge
add admin-mac=64:D1:54:70:E1:CB auto-mac=no comment=defconf name=bridge
/interface ethernet
set [ find default-name=ether1 ] speed=100Mbps
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
add authentication-types=wpa-psk,wpa2-psk eap-methods="" \
    management-protection=allowed mode=dynamic-keys name=hamwan \
    supplicant-identity=""
/interface wireless
set [ find default-name=wlan1 ] adaptive-noise-immunity=ap-and-client-mode \
    antenna-gain=0 band=5ghz-onlyac compression=yes disabled=no frequency=\
    5825 installation=any mac-address=4C:5E:0C:D8:F7:7F mode=station-bridge \
    mtu=1600 nv2-cell-radius=10 radio-name=azo.leb.memhamwan.net scan-list=\
    5825 security-profile=hamwan ssid=HamWAN-azo-leb station-roaming=enabled \
    tdma-period-size=4 wireless-protocol=nv2
/routing ospf instance
set [ find default=yes ] distribute-default=if-installed-as-type-1 in-filter=\
    AMPR-default out-filter=AMPR-default redistribute-bgp=as-type-1 \
    redistribute-connected=as-type-1 redistribute-other-ospf=as-type-1 \
    router-id=44.34.131.142
/snmp community
set [ find default=yes ] addresses=44.0.0.0/8
/user group
set full policy="local,telnet,ssh,ftp,reboot,read,write,policy,test,winbox,pas\
    sword,web,sniff,sensitive,api,romon,dude,tikapp"
/interface bridge port
add bridge=bridge comment=defconf interface=wlan1
/ip neighbor discovery-settings
set discover-interface-list=none
/ip address
add address=44.34.128.184/27 interface=ether1 network=44.34.128.160
add address=44.34.131.142 interface=bridge network=44.34.131.143
/ip dns
set servers=44.34.128.190
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
/routing filter
add action=accept chain=AMPR-default prefix=44.0.0.0/8 prefix-length=8-32
add action=accept chain=AMPR-default prefix=0.0.0.0/0
add action=reject chain=AMPR-default
/routing ospf interface
add authentication=md5 interface=ether1 network-type=broadcast
add authentication=md5 interface=bridge network-type=point-to-point
/routing ospf network
add area=backbone network=44.34.128.160/27
add area=backbone network=44.34.131.143/32
/snmp
set enabled=yes
/system clock
set time-zone-autodetect=no time-zone-name=America/Chicago
/system identity
set name=azo.leb.memhamwan.net
/system logging
set 3 disabled=yes
add action=echo disabled=yes topics=wireless
add disabled=yes topics=wireless,debug
/system ntp client
set enabled=yes primary-ntp=44.34.128.181 server-dns-names=ntp.memhamwan.net
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