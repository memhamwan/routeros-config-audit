# apr/16/2021 11:52:46 by RouterOS 6.48.1
# software id = 8VX7-3B51
#
# model = CRS326-24G-2S+
# serial number = CD010C2511AC
/interface bridge
add admin-mac=48:8F:5A:E1:D0:FA auto-mac=no comment=defconf name=bridge
/interface vrrp
add authentication=ah interface=bridge name=vrrp1 version=2
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=dhcp_pool0 ranges=10.10.10.2-10.10.10.254
/routing ospf instance
set [ find default=yes ] in-filter=AMPR-default out-filter=AMPR-default \
    redistribute-bgp=as-type-1 redistribute-connected=as-type-1 \
    redistribute-other-ospf=as-type-1 redistribute-static=as-type-1 \
    router-id=44.34.128.33
/snmp community
set [ find default=yes ] addresses=44.0.0.0/8
/user group
set full policy="local,telnet,ssh,ftp,reboot,read,write,policy,test,winbox,pas\
    sword,web,sniff,sensitive,api,romon,dude,tikapp"
/interface bridge port
add bridge=bridge comment=defconf interface=ether1
add bridge=bridge comment=defconf interface=ether2
add bridge=bridge comment=defconf interface=ether3
add bridge=bridge comment=defconf interface=ether4
add bridge=bridge comment=defconf interface=ether5
add bridge=bridge comment=defconf interface=ether6
add bridge=bridge comment=defconf interface=ether7
add bridge=bridge comment=defconf interface=ether8
add bridge=bridge comment=defconf interface=ether9
add bridge=bridge comment=defconf interface=ether10
add bridge=bridge comment=defconf interface=ether11
add bridge=bridge comment=defconf interface=ether12
add bridge=bridge comment=defconf interface=ether13
add bridge=bridge comment=defconf interface=ether14
add bridge=bridge comment=defconf interface=ether15
add bridge=bridge comment=defconf interface=ether16
add bridge=bridge comment=defconf interface=ether17
add bridge=bridge comment=defconf interface=ether18
add bridge=bridge comment=defconf interface=ether19
add bridge=bridge comment=defconf interface=ether20
add bridge=bridge comment=defconf interface=ether21
add bridge=bridge comment=defconf interface=ether22
add bridge=bridge comment=defconf interface=ether23
add bridge=bridge comment=defconf interface=ether24
add bridge=bridge comment=defconf interface=sfp-sfpplus1
add bridge=bridge comment=defconf interface=sfp-sfpplus2
/ip neighbor discovery-settings
set discover-interface-list=none
/ip address
add address=44.34.128.33/28 interface=bridge network=44.34.128.32
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
add authentication=md5 interface=bridge network-type=broadcast
/routing ospf network
add area=backbone network=44.34.128.32/28
/snmp
set enabled=yes
/system clock
set time-zone-autodetect=no time-zone-name=America/Chicago
/system identity
set name=r1.sco.memhamwan.net
/system ntp client
set enabled=yes server-dns-names=ntp.memhamwan.net
/system routerboard settings
set boot-os=router-os
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