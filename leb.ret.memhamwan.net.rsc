# RouterOS 6.48.1
# software id = XTL4-EMUQ
#
# model = RouterBOARD DynaDish G-5HacD r3
# serial number = A4F40804C0E1
/interface bridge
add name=bridge1
/interface wireless
set [ find default-name=wlan1 ] adaptive-noise-immunity=ap-and-client-mode \
    antenna-gain=0 band=5ghz-onlyac disabled=no frequency=5805 mode=\
    station-bridge nv2-cell-radius=10 radio-name=leb.ret.memhamwan.net \
    scan-list=5805 ssid=HamWAN-ret-leb station-roaming=enabled \
    tdma-period-size=4
/interface ethernet
set [ find default-name=ether1 ] speed=100Mbps
/interface wireless security-profiles
set [ find default=yes ] authentication-types=wpa2-psk mode=dynamic-keys \
    supplicant-identity=MikroTik
/ip ipsec proposal
set [ find default=yes ] enc-algorithms=aes-128-cbc
/routing ospf instance
set [ find default=yes ] distribute-default=if-installed-as-type-1 in-filter=\
    AMPR-default out-filter=hamwan-out redistribute-bgp=as-type-1 \
    redistribute-connected=as-type-1 redistribute-other-ospf=as-type-1 \
    redistribute-static=as-type-1 router-id=44.34.131.146
/snmp community
set [ find default=yes ] addresses=44.0.0.0/8
/system logging action
set 3 remote=44.34.128.165
add bsd-syslog=yes name=centrallogging remote=44.34.128.171 syslog-facility=\
    syslog target=remote
/user group
set full policy="local,telnet,ssh,ftp,reboot,read,write,policy,test,winbox,pas\
    sword,web,sniff,sensitive,api,romon,dude,tikapp"
/interface bridge port
add bridge=bridge1 interface=wlan1
/ip neighbor discovery-settings
set discover-interface-list=none
/ip address
add address=44.34.129.161/28 interface=ether1 network=44.34.129.160
add address=44.34.131.146 interface=bridge1 network=44.34.131.147
/ip dns
set servers=44.34.128.190
/ip ipsec policy
set 0 dst-address=0.0.0.0/0 src-address=0.0.0.0/0
/ip proxy
set cache-path=web-proxy1
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
add action=accept chain=hamwan-out prefix=44.0.0.0/8 prefix-length=8-32
add action=accept chain=hamwan-out prefix=0.0.0.0/0
add action=reject chain=hamwan-out
/routing ospf interface
add authentication=md5 interface=bridge1 network-type=point-to-point
add authentication=md5 interface=ether1 network-type=broadcast
/routing ospf network
add area=backbone network=44.34.131.147/32
add area=backbone network=44.34.129.160/28
add area=backbone network=44.34.128.208/28
/snmp
set contact="#HamWAN on irc.freenode.org" enabled=yes
/system clock
set time-zone-autodetect=no time-zone-name=America/Chicago
/system identity
set name=leb.ret.memhamwan.net
/system logging
add action=centrallogging topics=!debug,!packet,!snmp
add action=remote topics=!debug,!snmp
add action=echo disabled=yes topics=!ssh,!ospf,!ntp,!bgp
add action=echo disabled=yes topics=wireless
/system ntp client
set enabled=yes primary-ntp=132.163.96.5 server-dns-names=ntp.memhamwan.net
/tool bandwidth-server
set authenticate=no enabled=no
/tool graphing interface
add
add
add
/tool graphing queue
add
/tool graphing resource
add
/tool mac-server
set allowed-interface-list=none
/tool mac-server mac-winbox
set allowed-interface-list=none
/tool mac-server ping
set enabled=no
/tool romon
set enabled=yes
/tool sniffer
set filter-interface=*4