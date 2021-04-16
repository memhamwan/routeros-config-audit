# RouterOS 6.48.1
# software id = 3SYS-XEK6
#
# model = RBLHGG-60ad
# serial number = CF340C91C155
/interface bridge
add admin-mac=48:8F:5A:26:BC:DA auto-mac=no comment=defconf name=bridge
/interface vrrp
add authentication=ah interface=bridge name=vrrp1 version=2
/interface w60g
set [ find ] disabled=no frequency=64800 mode=bridge name=wlan60-1 \
    put-stations-in-bridge=bridge scan-list=64800 ssid=MikroTik-26bcda
/interface w60g station
add mac-address=48:8F:5A:26:BC:DB name=wlan60-station-1 parent=wlan60-1 \
    remote-address=48:8F:5A:26:87:E5
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/routing ospf instance
set [ find default=yes ] in-filter=AMPR-default out-filter=AMPR-default \
    redistribute-bgp=as-type-1 redistribute-connected=as-type-1 \
    redistribute-other-ospf=as-type-1 redistribute-static=as-type-1 \
    router-id=44.34.128.173
/snmp community
set [ find default=yes ] addresses=44.0.0.0/8
/ip neighbor discovery-settings
set discover-interface-list=none
/ip address
add address=44.34.128.173/27 interface=ether1 network=44.34.128.160
add address=44.34.131.156 interface=bridge network=44.34.131.157
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
set strong-crypto=yes
/routing filter
add action=accept chain=AMPR-default prefix=44.0.0.0/8 prefix-length=8-32
add action=accept chain=AMPR-default prefix=0.0.0.0/0
add action=reject chain=AMPR-default
/routing ospf interface
add authentication=md5 interface=bridge network-type=point-to-point
add authentication=md5 interface=ether1 network-type=broadcast
/routing ospf network
add area=backbone network=44.34.128.160/27
add area=backbone network=44.34.131.157/32
/snmp
set enabled=yes
/system clock
set time-zone-name=America/Chicago
/system identity
set name=sco.leb.memhamwan.net
/system ntp client
set enabled=yes primary-ntp=44.34.128.181
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