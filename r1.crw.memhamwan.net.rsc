# RouterOS 6.48.2
# software id = A94E-7R75
#
# model = RouterBOARD 3011UiAS
# serial number = 780F06E975FF
/interface bridge
add admin-mac=6C:3B:6B:FF:8A:41 auto-mac=no fast-forward=no name=\
    switch-bridge
/interface ethernet
set [ find default-name=ether1 ] speed=100Mbps
set [ find default-name=ether2 ] name=ether2-master speed=100Mbps
set [ find default-name=ether3 ] speed=100Mbps
set [ find default-name=ether4 ] speed=100Mbps
set [ find default-name=ether5 ] speed=100Mbps
set [ find default-name=ether6 ] name=ether6-master speed=100Mbps
set [ find default-name=ether7 ] speed=100Mbps
set [ find default-name=ether8 ] speed=100Mbps
set [ find default-name=ether9 ] speed=100Mbps
set [ find default-name=ether10 ] speed=100Mbps
set [ find default-name=sfp1 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full
/interface vrrp
add authentication=ah interface=switch-bridge name=vrrp1 version=2
/interface list
add exclude=dynamic name=discover
add name=mactel
add name=mac-winbox
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=r1.crw
/ip pool
add name=default-dhcp ranges=192.168.88.10-192.168.88.254
add name=dhcp_pool1 ranges=10.0.56.2-10.0.56.254
/routing ospf instance
set [ find default=yes ] distribute-default=if-installed-as-type-1 in-filter=\
    AMPR-default out-filter=AMPR-default redistribute-connected=as-type-1 \
    redistribute-other-ospf=as-type-1 router-id=44.34.129.116
/snmp community
set [ find default=yes ] addresses=44.0.0.0/8
/system logging action
add bsd-syslog=yes name=centrallogging remote=44.34.128.171 syslog-facility=\
    syslog target=remote
/user group
add name=dude_guest policy="read,winbox,dude,!local,!telnet,!ssh,!ftp,!reboot,\
    !write,!policy,!test,!password,!web,!sniff,!sensitive,!api,!romon,!tikapp"
/interface bridge port
add bridge=switch-bridge interface=ether1
add bridge=switch-bridge interface=ether6-master
add bridge=switch-bridge hw=no interface=sfp1
add bridge=switch-bridge interface=ether2-master
add bridge=switch-bridge interface=ether3
add bridge=switch-bridge interface=ether4
add bridge=switch-bridge interface=ether5
add bridge=switch-bridge interface=ether7
add bridge=switch-bridge interface=ether8
add bridge=switch-bridge interface=ether9
add bridge=switch-bridge interface=ether10
/ip neighbor discovery-settings
set discover-interface-list=none
/interface list member
add interface=ether2-master list=discover
add interface=ether3 list=discover
add interface=ether4 list=discover
add interface=ether5 list=discover
add interface=sfp1 list=discover
add interface=ether6-master list=discover
add interface=ether7 list=discover
add interface=ether8 list=discover
add interface=ether9 list=discover
add interface=ether10 list=discover
add interface=switch-bridge list=discover
add interface=vrrp1 list=discover
add interface=switch-bridge list=mactel
add interface=switch-bridge list=mac-winbox
/ip address
add address=44.34.129.116/28 interface=switch-bridge network=44.34.129.112
add address=44.34.129.113 interface=vrrp1 network=44.34.129.113
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
add authentication=md5 interface=switch-bridge network-type=broadcast
/routing ospf network
add area=backbone network=44.34.129.112/28
/snmp
set contact="#HamWAN on irc.freenode.org" enabled=yes
/system clock
set time-zone-autodetect=no time-zone-name=America/Chicago
/system identity
set name=r1.crw.memhamwan.net
/system logging
add action=remote topics=critical,error,info,warning
add topics=critical,error,info,warning
/system ntp client
set enabled=yes primary-ntp=44.34.132.3 secondary-ntp=44.34.133.3 \
    server-dns-names=ntp.memhamwan.net
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