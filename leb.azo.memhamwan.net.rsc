# RouterOS 6.48.1
# software id = 2WD1-QZIG
#
# model = RouterBOARD DynaDish G-5HacD r3
# serial number = 705F0600D11A
/interface bridge
add fast-forward=no mtu=1500 name=bridge1
/interface ethernet
set [ find default-name=ether1 ] name=ether1-local speed=100Mbps
/interface vrrp
add authentication=ah interface=ether1-local name=vrrp1 version=2
/interface list
add exclude=dynamic name=discover
add name=mactel
add name=mac-winbox
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
add authentication-types=wpa-psk,wpa2-psk eap-methods="" \
    management-protection=allowed mode=dynamic-keys name=hamwan \
    supplicant-identity=""
/interface wireless
set [ find default-name=wlan1 ] adaptive-noise-immunity=ap-and-client-mode \
    antenna-gain=0 band=5ghz-onlyac country="united states" disabled=no \
    frequency=5825 installation=any mode=bridge mtu=1600 nv2-cell-radius=10 \
    radio-name=leb.azo.memhamwan.net scan-list=5825 security-profile=hamwan \
    ssid=HamWAN-azo-leb station-roaming=enabled tdma-period-size=4 \
    wireless-protocol=nv2
/ip ipsec proposal
set [ find default=yes ] enc-algorithms=aes-128-cbc
/routing ospf instance
set [ find default=yes ] distribute-default=if-installed-as-type-1 in-filter=\
    AMPR-default out-filter=AMPR-default redistribute-bgp=as-type-1 \
    redistribute-connected=as-type-1 redistribute-other-ospf=as-type-1 \
    router-id=44.34.131.143
/snmp community
set [ find default=yes ] addresses=44.0.0.0/8
/system logging action
set 3 remote=44.34.128.171
add bsd-syslog=yes name=centrallogging remote=44.34.128.171 syslog-facility=\
    syslog target=remote
/interface bridge port
add bridge=bridge1 comment=defconf interface=wlan1
/ip neighbor discovery-settings
set discover-interface-list=none
/interface list member
add interface=ether1-local list=discover
add interface=bridge1 list=discover
add interface=vrrp1 list=discover
add interface=ether1-local list=mactel
add interface=ether1-local list=mac-winbox
/ip address
add address=44.34.129.65 interface=vrrp1 network=44.34.129.65
add address=44.34.131.143 interface=bridge1 network=44.34.131.142
add address=44.34.129.68/28 interface=ether1-local network=44.34.129.64
/ip dns
set servers=44.34.128.190
/ip firewall filter
add action=drop chain=forward dst-address=44.34.129.72 src-address=\
    !44.0.0.0/8
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
add authentication=md5 interface=ether1-local network-type=broadcast
add authentication=md5 interface=bridge1 network-type=point-to-point
/routing ospf network
add area=backbone network=44.34.129.64/28
add area=backbone network=44.34.131.142/32
/snmp
set contact="#HamWAN on irc.freenode.org" enabled=yes
/system clock
set time-zone-autodetect=no time-zone-name=America/Chicago
/system identity
set name=leb.azo.memhamwan.net
/system leds
set 0 interface=wlan1
/system logging
add action=remote topics=critical,error,info,warning
add topics=critical,error,info,warning
/system ntp client
set enabled=yes primary-ntp=44.34.128.181 secondary-ntp=44.34.133.3 \
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