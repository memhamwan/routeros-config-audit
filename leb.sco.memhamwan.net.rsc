# RouterOS 6.48.1
# software id = AU1W-6DXD
#
# model = RBLHGG-60ad
# serial number = CF340C0F13FC
/interface bridge
add admin-mac=48:8F:5A:26:87:E4 auto-mac=no comment=defconf name=bridge
/interface vrrp
add authentication=ah interface=ether1 name=vrrp1 version=2
/interface w60g
set [ find ] disabled=no mode=station-bridge name=wlan60-1 ssid=\
    MikroTik-26bcda
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=dhcp_pool0 ranges=10.10.0.2-10.10.0.254
/ip dhcp-server
add address-pool=dhcp_pool0 interface=ether1 name=dhcp1
/routing ospf instance
set [ find default=yes ] in-filter=AMPR-default out-filter=AMPR-default \
    redistribute-bgp=as-type-1 redistribute-connected=as-type-1 \
    redistribute-other-ospf=as-type-1 redistribute-static=as-type-1 \
    router-id=44.34.131.157
/snmp community
set [ find default=yes ] addresses=44.0.0.0/8
/user group
set full policy="local,telnet,ssh,ftp,reboot,read,write,policy,test,winbox,pas\
    sword,web,sniff,sensitive,api,romon,dude,tikapp"
/interface bridge port
add bridge=bridge comment=defconf interface=wlan60-1
/ip neighbor discovery-settings
set discover-interface-list=none
/ip address
add address=44.34.128.40/28 comment=defconf interface=ether1 network=\
    44.34.128.32
add address=44.34.131.157 interface=bridge network=44.34.131.156
add address=44.34.128.39/27 interface=vrrp1 network=44.34.128.32
add address=10.10.0.1/24 disabled=yes interface=ether1 network=10.10.0.0
add address=44.34.129.129/28 interface=ether1 network=44.34.129.128
/ip dhcp-server network
add address=10.10.0.0/24 gateway=10.10.0.1
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
set strong-crypto=yes
/routing filter
add action=accept chain=AMPR-default prefix=44.0.0.0/8 prefix-length=8-32
add action=accept chain=AMPR-default prefix=0.0.0.0/0
add action=reject chain=AMPR-default
/routing ospf interface
add authentication=md5 interface=bridge network-type=point-to-point
add authentication=md5 interface=ether1 network-type=broadcast
/routing ospf network
add area=backbone network=44.34.131.156/32
add area=backbone network=44.34.128.32/28
add area=backbone network=44.34.129.128/28
/snmp
set enabled=yes
/system clock
set time-zone-autodetect=no time-zone-name=America/Chicago
/system identity
set name=leb.sco.memhamwan.net
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