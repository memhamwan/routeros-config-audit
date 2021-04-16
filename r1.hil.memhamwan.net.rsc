# RouterOS 6.48.1
# software id = BX80-PIQ0
#
# model = 2011UiAS
# serial number = 4449020BB6DA
/interface bridge
add admin-mac=D4:CA:6D:0B:58:95 auto-mac=no comment=defconf fast-forward=no \
    name=bridge
/interface ethernet
set [ find default-name=ether1 ] speed=100Mbps
set [ find default-name=ether2 ] name=ether2-master speed=100Mbps
set [ find default-name=ether3 ] speed=100Mbps
set [ find default-name=ether4 ] speed=100Mbps
set [ find default-name=ether5 ] speed=100Mbps
set [ find default-name=ether6 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full name=\
    ether6-master
set [ find default-name=ether7 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full
set [ find default-name=ether8 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full
set [ find default-name=ether9 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full
set [ find default-name=ether10 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full
/interface vrrp
add authentication=ah interface=ether1 name=vrrp1 version=2
/interface list
add exclude=dynamic name=discover
add name=mactel
add name=mac-winbox
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=HamWAN
/ip pool
add name=default-dhcp ranges=192.168.88.10-192.168.88.254
/port
set 1 baud-rate=9600 name=usb2
/interface ppp-client
add apn=internet default-route-distance=0 name=ppp-out1 port=usb2
/routing ospf instance
set [ find default=yes ] distribute-default=if-installed-as-type-1 in-filter=\
    AMPR-default out-filter=AMPR-default redistribute-connected=as-type-1 \
    redistribute-other-ospf=as-type-1 router-id=44.34.128.103
/snmp community
set [ find default=yes ] addresses=44.34.128.0/21
/interface bridge port
add bridge=bridge comment=defconf interface=ether1
add bridge=bridge comment=defconf interface=ether6-master
add bridge=bridge comment=defconf hw=no interface=sfp1
add bridge=bridge interface=ether2-master
add bridge=bridge interface=ether3
add bridge=bridge interface=ether4
add bridge=bridge interface=ether5
add bridge=bridge interface=ether7
add bridge=bridge interface=ether8
add bridge=bridge interface=ether9
add bridge=bridge interface=ether10
/ip neighbor discovery-settings
set discover-interface-list=all
/interface list member
add interface=sfp1 list=discover
add interface=ether2-master list=discover
add interface=ether3 list=discover
add interface=ether4 list=discover
add interface=ether5 list=discover
add interface=ether6-master list=discover
add interface=ether7 list=discover
add interface=ether8 list=discover
add interface=ether9 list=discover
add interface=ether10 list=discover
add interface=bridge list=discover
add interface=vrrp1 list=discover
add interface=ppp-out1 list=discover
add interface=bridge list=mactel
add interface=bridge list=mac-winbox
/ip address
add address=44.34.128.103/28 interface=ether1 network=44.34.128.96
add address=44.34.128.102 interface=vrrp1 network=44.34.128.102
/ip dns
set servers=44.34.128.190
/ip firewall mangle
add action=change-mss chain=output new-mss=1378 passthrough=yes protocol=tcp \
    tcp-flags=syn tcp-mss=!0-1378
add action=change-mss chain=forward new-mss=1378 passthrough=yes protocol=tcp \
    tcp-flags=syn tcp-mss=!0-1378
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
add authentication=md5 network-type=broadcast
/routing ospf network
add area=backbone network=44.34.128.96/28
/snmp
set enabled=yes
/system clock
set time-zone-name=America/Chicago
/system identity
set name=r1.hil
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