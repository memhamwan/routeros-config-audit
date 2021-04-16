# apr/16/2021 11:53:02 by RouterOS 6.48.1
# software id = ZEFX-QKUQ
#
# model = 2011UiAS
# serial number = 69BB05B65BBF
/interface bridge
add admin-mac=E4:8D:8C:7C:F5:C4 auto-mac=no fast-forward=no name=bridge-local
/interface ethernet
set [ find default-name=ether1 ] name=ether1-gateway speed=100Mbps
set [ find default-name=ether2 ] name=ether2-master-local speed=100Mbps
set [ find default-name=ether3 ] name=ether3-slave-local speed=100Mbps
set [ find default-name=ether4 ] name=ether4-slave-local speed=100Mbps
set [ find default-name=ether5 ] name=ether5-slave-local speed=100Mbps
set [ find default-name=ether6 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full name=\
    ether6-master-local
set [ find default-name=ether7 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full name=\
    ether7-slave-local
set [ find default-name=ether8 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full name=\
    ether8-slave-local
set [ find default-name=ether9 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full name=\
    ether9-slave-local
set [ find default-name=ether10 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full name=\
    ether10-slave-local
set [ find default-name=sfp1 ] auto-negotiation=no speed=10Mbps
/interface list
add exclude=dynamic name=discover
add name=mactel
add name=mac-winbox
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=default-dhcp ranges=192.168.88.10-192.168.88.254
/routing ospf instance
set [ find default=yes ] distribute-default=if-installed-as-type-1 in-filter=\
    AMPR-default out-filter=AMPR-default redistribute-connected=as-type-1 \
    redistribute-other-ospf=as-type-1 router-id=44.34.129.74
/snmp community
set [ find default=yes ] addresses=44.0.0.0/8
/interface bridge port
add bridge=bridge-local interface=ether2-master-local
add bridge=bridge-local interface=ether6-master-local
add bridge=bridge-local hw=no interface=sfp1
add bridge=bridge-local interface=ether4-slave-local
add bridge=bridge-local interface=ether3-slave-local
add bridge=bridge-local interface=ether5-slave-local
add bridge=bridge-local interface=ether7-slave-local
add bridge=bridge-local interface=ether8-slave-local
add bridge=bridge-local interface=ether9-slave-local
add bridge=bridge-local interface=ether10-slave-local
add bridge=bridge-local interface=ether1-gateway
/ip neighbor discovery-settings
set discover-interface-list=none
/interface list member
add interface=sfp1 list=discover
add interface=ether2-master-local list=discover
add interface=ether3-slave-local list=discover
add interface=ether4-slave-local list=discover
add interface=ether5-slave-local list=discover
add interface=ether6-master-local list=discover
add interface=ether7-slave-local list=discover
add interface=ether8-slave-local list=discover
add interface=ether9-slave-local list=discover
add interface=ether10-slave-local list=discover
add interface=bridge-local list=discover
add interface=ether2-master-local list=mactel
add interface=ether3-slave-local list=mactel
add interface=ether2-master-local list=mac-winbox
add interface=ether4-slave-local list=mactel
add interface=ether3-slave-local list=mac-winbox
add interface=ether5-slave-local list=mactel
add interface=ether4-slave-local list=mac-winbox
add interface=ether6-master-local list=mactel
add interface=ether5-slave-local list=mac-winbox
add interface=ether7-slave-local list=mactel
add interface=ether6-master-local list=mac-winbox
add interface=ether8-slave-local list=mactel
add interface=ether7-slave-local list=mac-winbox
add interface=ether9-slave-local list=mactel
add interface=ether10-slave-local list=mactel
add interface=sfp1 list=mactel
add interface=ether8-slave-local list=mac-winbox
add interface=bridge-local list=mactel
add interface=ether9-slave-local list=mac-winbox
add interface=ether10-slave-local list=mac-winbox
add interface=sfp1 list=mac-winbox
add interface=bridge-local list=mac-winbox
/ip address
add address=44.34.129.73/28 interface=bridge-local network=44.34.129.64
/ip dns
set servers=8.8.8.8,8.8.4.4
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www disabled=yes
set ssh address=73.2.158.140/32,44.0.0.0/8,192.168.0.0/16,10.0.0.0/8
set api disabled=yes
set winbox address=73.2.158.140/32,44.0.0.0/8,192.168.0.0/16,10.0.0.0/8 \
    disabled=yes
set api-ssl disabled=yes
/ip ssh
set forwarding-enabled=remote strong-crypto=yes
/routing ospf interface
add authentication=md5 network-type=broadcast
/routing ospf network
add area=backbone network=44.34.129.64/28
/snmp
set enabled=yes
/system clock
set time-zone-autodetect=no time-zone-name=America/Chicago
/system identity
set name=r2.azo.memhamwan.net
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