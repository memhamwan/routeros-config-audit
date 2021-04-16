# RouterOS 6.48.1
# software id = 3QHR-LE3I
#
# model = Metal 5SHPn
# serial number = 4A08016F4ED5
/interface ethernet
set [ find default-name=ether1 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full name=\
    ether1-local
/interface vrrp
add authentication=ah disabled=yes interface=ether1-local name=vrrp1 version=\
    2
/interface list
add exclude=dynamic name=discover
add name=mactel
add name=mac-winbox
/interface wireless channels
add band=5ghz-onlyn comment="Cell sites radiate this at 0 degrees (north)" \
    frequency=5920 list=HamWAN name=s1-10 width=10
add band=5ghz-onlyn comment=\
    "Cell sites radiate this at 120 degrees (south-east)" frequency=5900 \
    list=HamWAN name=s2-10 width=10
add band=5ghz-onlyn comment=\
    "Cell sites radiate this at 240 degrees (south-west)" frequency=5880 \
    list=HamWAN name=s3-10 width=10
add band=5ghz-onlyn comment="Cell sites radiate this at 0 degrees (north)" \
    frequency=5920 list=HamWAN name=s1-5 width=5
add band=5ghz-onlyn comment=\
    "Cell sites radiate this at 120 degrees (south-east)" frequency=5900 \
    list=HamWAN name=s2-5 width=5
add band=5ghz-onlyn comment=\
    "Cell sites radiate this at 240 degrees (south-west)" frequency=5880 \
    list=HamWAN name=s3-5 width=5
add band=5ghz-onlyn comment="Extra channel" frequency=5865 list=HamWAN name=\
    o1-5 width=5
add band=5ghz-onlyn comment="Extra channel" frequency=5855 list=HamWAN name=\
    o2-5 width=5
add band=5ghz-onlyn comment="Extra channel" frequency=8545 list=HamWAN name=\
    o3-5 width=5
/interface wireless
# in scan-list unsupported channel: o3-5
set [ find default-name=wlan1 ] band=5ghz-onlyn channel-width=10mhz country=\
    no_country_set disabled=no frequency=s3-10 frequency-mode=superchannel \
    ht-supported-mcs="mcs-0,mcs-1,mcs-2,mcs-3,mcs-4,mcs-5,mcs-6,mcs-7,mcs-8,mc\
    s-9,mcs-10,mcs-11,mcs-12,mcs-13,mcs-14,mcs-15" mode=ap-bridge mtu=2290 \
    name=wlan1-gateway nv2-cell-radius=100 radio-name=sec3.sco scan-list=\
    HamWAN ssid=HamWAN station-roaming=enabled tdma-period-size=4 \
    wireless-protocol=nv2
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity="HamWAN Memphis Metro, Inc"
/ip ipsec proposal
set [ find default=yes ] enc-algorithms=aes-128-cbc
/ip pool
add name=default-dhcp ranges=192.168.88.10-192.168.88.254
add name=hamwan ranges=44.34.128.82-44.34.128.94
add name=pool1 ranges=44.34.128.82-44.34.128.94
/ip dhcp-server
add address-pool=pool1 authoritative=after-2sec-delay disabled=no interface=\
    wlan1-gateway lease-time=1h name=dhcp1
/routing ospf instance
set [ find default=yes ] distribute-default=if-installed-as-type-1 in-filter=\
    AMPR-default out-filter=AMPR-default redistribute-bgp=as-type-1 \
    redistribute-connected=as-type-1 redistribute-other-ospf=as-type-1 \
    router-id=44.34.128.36
/snmp community
set [ find default=yes ] addresses=44.34.128.0/21
/system logging action
set 1 disk-file-name=""
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
add address=44.34.128.36/28 interface=ether1-local network=44.34.128.32
add address=44.34.128.81/28 interface=wlan1-gateway network=44.34.128.80
add address=44.34.128.39 interface=vrrp1 network=44.34.128.39
/ip dhcp-server network
add address=44.34.128.80/28 dns-server=44.34.132.1,44.34.133.1 domain=\
    memhamwan.net gateway=44.34.128.81 netmask=28 ntp-server=\
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
set winbox address=73.2.158.140/32,44.0.0.0/8,192.168.0.0/16,10.0.0.0/8 \
    disabled=yes
set api-ssl disabled=yes
/ip socks
set connection-idle-timeout=1m max-connections=255 port=14703
/ip ssh
set forwarding-enabled=remote strong-crypto=yes
/routing filter
add action=accept chain=AMPR-default prefix=44.0.0.0/8 prefix-length=8-32
add action=accept chain=AMPR-default prefix=0.0.0.0/0
add action=reject chain=AMPR-default
/routing ospf interface
add authentication=md5 interface=ether1-local network-type=broadcast
/routing ospf network
add area=backbone network=44.34.128.32/28
add area=backbone network=44.34.128.80/28
/snmp
set contact="#HamWAN on irc.freenode.org" enabled=yes
/system clock
set time-zone-autodetect=no
/system identity
set name=sec3.sco
/system leds
set 1 interface=wlan1-gateway
/system logging
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
/tool romon port
add cost=1 forbid=yes interface=wlan1-gateway