# RouterOS 6.48.1
# software id = 28VE-05E2
#
# model = 960PGS
# serial number = A513092A5168
/interface bridge
add admin-mac=B8:69:F4:86:60:9B auto-mac=no comment=defconf name=bridge
/interface ethernet
set [ find default-name=ether1 ] speed=100Mbps
set [ find default-name=ether2 ] name=ether2-master speed=100Mbps
set [ find default-name=ether3 ] speed=100Mbps
set [ find default-name=ether4 ] speed=100Mbps
set [ find default-name=ether5 ] speed=100Mbps
set [ find default-name=sfp1 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full
/interface vrrp
add authentication=ah interface=bridge name=vrrp1 version=2
/interface list
add comment=defconf name=WAN
add comment=defconf name=LAN
add exclude=dynamic name=discover
add name=mactel
add name=mac-winbox
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=default-dhcp ranges=192.168.88.10-192.168.88.254
/routing ospf instance
set [ find default=yes ] in-filter=AMPR-default out-filter=AMPR-default \
    redistribute-bgp=as-type-1 redistribute-connected=as-type-1 \
    redistribute-other-ospf=as-type-1 redistribute-static=as-type-1 \
    router-id=44.34.128.162
/snmp community
set [ find default=yes ] addresses=44.0.0.0/8
/user group
set full policy="local,telnet,ssh,ftp,reboot,read,write,policy,test,winbox,pas\
    sword,web,sniff,sensitive,api,romon,dude,tikapp"
/interface bridge port
add bridge=bridge comment=defconf interface=ether2-master
add bridge=bridge comment=defconf hw=no interface=sfp1
add bridge=bridge hw=no interface=ether1
add bridge=bridge interface=ether3
add bridge=bridge interface=ether4
add bridge=bridge interface=ether5
/ip neighbor discovery-settings
set discover-interface-list=none
/interface list member
add comment=defconf interface=bridge list=LAN
add comment=defconf interface=ether1 list=WAN
add interface=ether2-master list=discover
add interface=ether3 list=discover
add interface=ether4 list=discover
add interface=ether5 list=discover
add interface=sfp1 list=discover
add interface=bridge list=discover
add interface=bridge list=mactel
add interface=bridge list=mac-winbox
/ip address
add address=44.34.128.162/27 interface=bridge network=44.34.128.160
/ip dhcp-server network
add address=192.168.88.0/24 comment=defconf gateway=192.168.88.1
/ip dns
set servers=44.34.128.190
/ip dns static
add address=192.168.88.1 name=router.lan
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
add authentication=md5 interface=bridge network-type=broadcast
/routing ospf network
add area=backbone network=44.34.128.160/27
/snmp
set enabled=yes
/system clock
set time-zone-name=America/Los_Angeles
/system identity
set name=r2.leb.memhamwan.net
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