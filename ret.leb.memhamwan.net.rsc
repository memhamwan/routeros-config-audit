# RouterOS 6.48.1
# software id = 25F3-SJT0
#
# model = RouterBOARD DynaDish G-5HacD r3
# serial number = A4F4088867A1
/interface bridge
add admin-mac=CC:2D:E0:90:0E:A4 auto-mac=no comment=defconf name=bridge
/interface wireless
set [ find default-name=wlan1 ] antenna-gain=0 band=5ghz-onlyac disabled=no \
    frequency=5805 mode=bridge nv2-cell-radius=10 radio-name=\
    ret.leb.memhamwan.net scan-list=5805 ssid=HamWAN-ret-leb station-roaming=\
    enabled tdma-period-size=4 wireless-protocol=nv2
/interface ethernet
set [ find default-name=ether1 ] speed=100Mbps
/interface vrrp
add authentication=ah interface=bridge name=vrrp1 version=2
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/routing ospf instance
set [ find default=yes ] in-filter=AMPR-default out-filter=AMPR-default \
    redistribute-bgp=as-type-1 redistribute-connected=as-type-1 \
    redistribute-other-ospf=as-type-1 redistribute-static=as-type-1 \
    router-id=44.34.131.147
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
add address=44.34.128.176/27 interface=ether1 network=44.34.128.160
add address=44.34.131.147 interface=bridge network=44.34.131.146
/ip dns
set servers=44.34.128.190
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www disabled=yes
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
add authentication=md5 interface=bridge network-type=point-to-point
add authentication=md5 interface=ether1 network-type=broadcast
/routing ospf network
add area=backbone network=44.34.128.160/27
add area=backbone network=44.34.131.146/32
/snmp
set enabled=yes
/system clock
set time-zone-autodetect=no time-zone-name=America/Chicago
/system identity
set name=ret.leb.memhamwan.net
/system ntp client
set enabled=yes server-dns-names=ntp.memhamwan.net
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