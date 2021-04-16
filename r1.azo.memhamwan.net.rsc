# RouterOS 6.48.1
# software id = A10G-KLEK
#
# model = OmniTIK UPA-5HnD
# serial number = 4C9C044AA6C8
/interface bridge
add admin-mac=4C:5E:0C:6D:7A:75 auto-mac=no comment=\
    "created from master port" name=bridge2 protocol-mode=none
/interface ethernet
set [ find default-name=ether1 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full comment=dsl \
    name=ether1-gateway
set [ find default-name=ether2 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full comment=\
    ptpleb.azo name=ether2-master-local
set [ find default-name=ether3 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full comment=\
    omn2.azo name=ether3-slave-local poe-priority=99
set [ find default-name=ether4 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full comment=\
    cam1.azo name=ether4-slave-local poe-out=forced-on poe-priority=99
set [ find default-name=ether5 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full comment=\
    weather.azo name=ether5-slave-local poe-out=forced-on poe-priority=99
/interface wireless
set [ find default-name=wlan1 ] band=5ghz-onlyn channel-width=5mhz country=\
    no_country_set disabled=no frequency=5855 frequency-mode=superchannel \
    ht-supported-mcs="mcs-0,mcs-1,mcs-2,mcs-3,mcs-4,mcs-5,mcs-6,mcs-7,mcs-8,mc\
    s-9,mcs-10,mcs-11,mcs-12,mcs-13,mcs-14,mcs-15" mode=ap-bridge mtu=2290 \
    nv2-cell-radius=100 radio-name=r1.azo scan-list=5855 ssid=HamWAN \
    station-roaming=enabled tdma-period-size=4 wireless-protocol=nv2
/interface vrrp
add authentication=ah interface=ether1-gateway name=vrrp1 version=2
/interface list
add exclude=dynamic name=discover
add name=mactel
add name=mac-winbox
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/port
set 0 baud-rate=4800 name=usb1 parity=odd
/routing ospf instance
set [ find default=yes ] distribute-default=if-installed-as-type-1 in-filter=\
    AMPR-default out-filter=AMPR-default redistribute-connected=as-type-1 \
    redistribute-other-ospf=as-type-1 router-id=44.34.129.66
/snmp community
set [ find default=yes ] addresses=44.0.0.0/8
/system logging action
set 3 remote=44.34.128.171
add bsd-syslog=yes name=centrallogging remote=44.34.128.171 syslog-facility=\
    syslog target=remote
/interface bridge port
add bridge=bridge2 hw=no interface=ether1-gateway
add bridge=bridge2 interface=ether3-slave-local
add bridge=bridge2 interface=ether4-slave-local
add bridge=bridge2 interface=ether5-slave-local
add bridge=bridge2 interface=ether2-master-local
/ip neighbor discovery-settings
set discover-interface-list=none
/interface ethernet poe settings
set ether1-poe-in-long-cable=yes
/interface list member
add interface=bridge2 list=discover
add interface=ether3-slave-local list=discover
add interface=ether4-slave-local list=discover
add interface=ether5-slave-local list=discover
add interface=wlan1 list=discover
add list=discover
add interface=vrrp1 list=discover
add interface=bridge2 list=mactel
add interface=ether3-slave-local list=mactel
add interface=bridge2 list=mac-winbox
add interface=ether4-slave-local list=mactel
add interface=ether3-slave-local list=mac-winbox
add interface=ether5-slave-local list=mactel
add interface=ether4-slave-local list=mac-winbox
add interface=ether5-slave-local list=mac-winbox
add interface=wlan1 list=mac-winbox
add interface=wlan1 list=mactel
add list=mac-winbox
add list=mactel
/ip address
add address=44.34.129.66/28 interface=bridge2 network=44.34.129.64
add address=44.34.129.65 interface=vrrp1 network=44.34.129.65
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
add authentication=md5 interface=bridge2 network-type=broadcast
/routing ospf network
add area=backbone network=44.34.129.64/28
/snmp
set contact="#HamWAN on irc.freenode.org" enabled=yes
/system clock
set time-zone-name=America/Chicago
/system identity
set name=r1.azo.memhamwan.net
/system logging
set 3 action=memory
add action=remote topics=critical,error,info,warning
add topics=critical,error,info,warning
/system ntp client
set enabled=yes primary-ntp=44.34.128.181 secondary-ntp=44.34.133.3
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
/tool sniffer
set filter-interface=ether1-gateway