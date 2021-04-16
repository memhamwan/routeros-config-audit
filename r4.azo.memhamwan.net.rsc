# apr/16/2021 11:53:23 by RouterOS 6.48.2
# software id = 4TZY-TMH7
#
# model = RouterBOARD 750P r2
# serial number = 67D6070586D0
/interface bridge
add admin-mac=64:D1:54:34:75:6E auto-mac=no comment=defconf name=bridge
/interface ethernet
set [ find default-name=ether2 ] poe-out=forced-on
set [ find default-name=ether3 ] poe-out=forced-on
set [ find default-name=ether4 ] poe-out=forced-on
set [ find default-name=ether5 ] poe-out=forced-on
/interface list
add comment=defconf name=WAN
add comment=defconf name=LAN
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/snmp community
set [ find default=yes ] addresses=44.0.0.0/8
/user group
set full policy="local,telnet,ssh,ftp,reboot,read,write,policy,test,winbox,pas\
    sword,web,sniff,sensitive,api,romon,dude,tikapp"
/interface bridge port
add bridge=bridge comment=defconf interface=ether2
add bridge=bridge comment=defconf interface=ether3
add bridge=bridge comment=defconf interface=ether4
add bridge=bridge comment=defconf interface=ether5
add bridge=bridge interface=ether1
/ip neighbor discovery-settings
set discover-interface-list=none
/interface ethernet poe settings
set ether1-poe-in-long-cable=yes
/interface list member
add comment=defconf interface=bridge list=LAN
add comment=defconf interface=ether1 list=WAN
/ip address
add address=44.34.129.75/28 interface=bridge network=44.34.129.64
/ip dhcp-client
add comment=defconf disabled=no interface=bridge
/ip dns
set servers=44.34.128.190
/ip dns static
add address=192.168.88.1 name=router.lan
/ip route
add distance=1 gateway=44.34.129.65
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www disabled=yes
set api disabled=yes
set winbox disabled=yes
set api-ssl disabled=yes
/ip ssh
set forwarding-enabled=remote strong-crypto=yes
/snmp
set enabled=yes
/system clock
set time-zone-autodetect=no time-zone-name=America/Chicago
/system identity
set name=r4.azo.memhamwan.net
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