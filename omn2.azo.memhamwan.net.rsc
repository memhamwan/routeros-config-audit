# RouterOS 6.48.1
# software id = U8QZ-LL36
#
# model = Metal 2SHPn
# serial number = 447502261648
/interface wireless
set [ find default-name=wlan1 ] band=2ghz-b/g/n country=no_country_set \
    frequency=auto frequency-mode=superchannel mode=ap-bridge mtu=2290 name=\
    wlan1-gateway nv2-cell-radius=100 radio-name=omn2.azo ssid=HamWAN \
    station-roaming=enabled tdma-period-size=4 wireless-protocol=802.11
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
set [ find default=yes ] authentication-types=wpa2-psk eap-methods="" mode=\
    dynamic-keys supplicant-identity=MikroTik
/ip ipsec proposal
set [ find default=yes ] enc-algorithms=aes-128-cbc
/routing ospf instance
set [ find default=yes ] distribute-default=if-installed-as-type-1 in-filter=\
    AMPR-default out-filter=AMPR-default redistribute-connected=as-type-1 \
    redistribute-other-ospf=as-type-1 router-id=44.34.129.67
/snmp community
set [ find default=yes ] addresses=44.0.0.0/8
/system logging action
add bsd-syslog=yes name=centrallogging remote=44.34.128.171 syslog-facility=\
    syslog target=remote
/ip neighbor discovery-settings
set discover-interface-list=none
/interface list member
add interface=ether1-local list=discover
add interface=vrrp1 list=discover
add interface=ether1-local list=mactel
add interface=ether1-local list=mac-winbox
/interface wireless cap
set discovery-interfaces=ether1-local interfaces=wlan1-gateway
/ip address
add address=44.34.129.67/28 interface=ether1-local network=44.34.129.64
add address=44.34.129.65 interface=vrrp1 network=44.34.129.65
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
add authentication=md5 interface=ether1-local network-type=broadcast
/routing ospf network
add area=backbone network=44.34.129.64/28
/snmp
set contact="#HamWAN on irc.freenode.org" enabled=yes
/system clock
set time-zone-name=America/Chicago
/system identity
set name=omn2.azo.memhamwan.net
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