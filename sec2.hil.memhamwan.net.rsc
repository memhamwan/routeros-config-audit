# RouterOS 6.48.1
# software id = 6322-0242
#
# model = Metal 5SHPn
# serial number = 576C047712C3
/interface wireless
set [ find default-name=wlan1 ] band=5ghz-onlyn channel-width=10mhz country=\
    no_country_set disabled=no frequency=5900 frequency-mode=superchannel \
    ht-supported-mcs="mcs-0,mcs-1,mcs-2,mcs-3,mcs-4,mcs-5,mcs-6,mcs-7,mcs-8,mc\
    s-9,mcs-10,mcs-11,mcs-12,mcs-13,mcs-14,mcs-15" mode=ap-bridge mtu=2290 \
    name=wlan1-gateway nv2-cell-radius=100 radio-name=sec2.hil scan-list=5900 \
    ssid=HamWAN station-roaming=enabled tdma-period-size=4 wireless-protocol=\
    nv2
/interface ethernet
set [ find default-name=ether1 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full name=\
    ether1-local
/interface vrrp
add authentication=ah interface=ether1-local name=vrrp1 version=2
/interface list
add exclude=dynamic name=discover
add name=mactel
add name=mac-winbox
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=HamWAN
/ip ipsec proposal
set [ find default=yes ] enc-algorithms=aes-128-cbc
/ip pool
add name=pool1 ranges=44.34.128.130-44.34.128.142
/ip dhcp-server
add address-pool=pool1 authoritative=after-2sec-delay disabled=no interface=\
    wlan1-gateway lease-time=1h name=dhcp1
/routing ospf instance
set [ find default=yes ] distribute-default=if-installed-as-type-1 in-filter=\
    AMPR-default out-filter=AMPR-default redistribute-connected=as-type-1 \
    redistribute-other-ospf=as-type-1 router-id=44.34.128.100
/snmp community
set [ find default=yes ] addresses=44.34.128.0/21
/system logging action
set 0 memory-lines=1
set 3 remote=44.34.128.21
add bsd-syslog=yes name=centrallogging remote=44.34.128.171 syslog-facility=\
    syslog target=remote
/ip neighbor discovery-settings
set discover-interface-list=all
/interface list member
add interface=ether1-local list=discover
add interface=vrrp1 list=discover
add interface=ether1-local list=mactel
add interface=ether1-local list=mac-winbox
/ip address
add address=44.34.128.100/28 interface=ether1-local network=44.34.128.96
add address=44.34.128.129/28 interface=wlan1-gateway network=44.34.128.128
add address=44.34.128.102 interface=vrrp1 network=44.34.128.102
/ip dhcp-server network
add address=44.34.128.128/28 dns-server=44.34.132.1,44.34.133.1 domain=\
    memhamwan.net gateway=44.34.128.129 netmask=28 ntp-server=\
    44.34.132.3,44.34.133.3
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
/ip socks
set connection-idle-timeout=1m max-connections=255 port=48324
/ip ssh
set forwarding-enabled=remote strong-crypto=yes
/routing filter
add action=accept chain=AMPR-default prefix=44.0.0.0/8 prefix-length=8-32
add action=accept chain=AMPR-default prefix=0.0.0.0/0
add action=reject chain=AMPR-default
/routing ospf interface
add authentication=md5 interface=ether1-local network-type=broadcast
/routing ospf network
add area=backbone network=44.34.128.96/28
add area=backbone network=44.34.128.128/28
/snmp
set contact="#HamWAN on irc.freenode.org" enabled=yes
/system clock
set time-zone-name=America/Los_Angeles
/system identity
set name=sec2.hil
/system leds
set 1 interface=wlan1-gateway
/system logging
set 3 action=remote topics=!debug,!packet,!snmp
add action=remote topics=critical,error,info,warning
add topics=critical,error,info,warning
/system ntp client
set enabled=yes primary-ntp=44.34.128.181 secondary-ntp=44.34.133.3
/system upgrade upgrade-package-source
add address=44.34.128.2 user=admin
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