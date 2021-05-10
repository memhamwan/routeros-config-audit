# RouterOS 6.48.2
# software id = 98ZK-FWVX
#
# model = RouterBOARD 750P r2
# serial number = 5D590571E7B1
/interface bridge
add fast-forward=no name=switch-bridge
/interface ethernet
set [ find default-name=ether1 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full name=\
    ether1-gateway
set [ find default-name=ether2 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full comment=\
    "44.34.129.121 camera" name=ether2-master-local poe-out=forced-on
set [ find default-name=ether3 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full name=\
    ether3-slave-local poe-out=forced-on
set [ find default-name=ether4 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full name=\
    ether4-slave-local poe-out=forced-on
set [ find default-name=ether5 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full comment=\
    cam2.crw name=ether5-slave-local poe-out=forced-on
/interface vrrp
add authentication=ah interface=switch-bridge name=vrrp1 version=2
/interface list
add exclude=dynamic name=discover
add name=mactel
add name=mac-winbox
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/routing ospf instance
set [ find default=yes ] distribute-default=if-installed-as-type-1 in-filter=\
    AMPR-default out-filter=AMPR-default redistribute-connected=as-type-1 \
    redistribute-other-ospf=as-type-1 router-id=44.34.129.117
/snmp community
set [ find default=yes ] addresses=44.0.0.0/8
/system logging action
set 3 remote=44.34.128.171
add bsd-syslog=yes name=centrallogging remote=44.34.128.171 syslog-facility=\
    syslog target=remote
/interface bridge port
add bridge=switch-bridge interface=all
/ip neighbor discovery-settings
set discover-interface-list=none
/interface ethernet poe settings
set ether1-poe-in-long-cable=yes
/interface list member
add list=discover
add interface=ether3-slave-local list=discover
add interface=ether4-slave-local list=discover
add interface=ether5-slave-local list=discover
add list=discover
add interface=vrrp1 list=discover
add interface=switch-bridge list=discover
add list=mactel
add interface=ether3-slave-local list=mactel
add list=mac-winbox
add interface=ether4-slave-local list=mactel
add interface=ether3-slave-local list=mac-winbox
add interface=ether5-slave-local list=mactel
add interface=ether4-slave-local list=mac-winbox
add interface=ether5-slave-local list=mac-winbox
/ip address
add address=44.34.129.117/28 interface=switch-bridge network=44.34.129.112
add address=44.34.129.113 interface=vrrp1 network=44.34.129.113
add address=44.34.129.145/28 interface=switch-bridge network=44.34.129.144
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
/ip smb shares
set [ find default=yes ] directory=/pub
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
add area=backbone network=44.34.129.144/28
/snmp
set contact="#HamWAN on irc.freenode.org" enabled=yes
/system clock
set time-zone-autodetect=no time-zone-name=America/Chicago
/system identity
set name=r2.crw.memhamwan.net
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