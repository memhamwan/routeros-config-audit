# RouterOS 6.48.1
# software id = R2YK-BVVU
#
# model = 921UAGS-5SHPacT
# serial number = 620804E58A8D
/interface bridge
add fast-forward=no mtu=1500 name=bridge1
/interface ethernet
set [ find default-name=ether1 ] speed=100Mbps
/interface vrrp
add authentication=ah interface=ether1 name=vrrp1 version=2
/interface wireless channels
add band=5ghz-onlyn comment="Cell sites radiate this at 0 degrees (north)" \
    frequency=5915 list=HamWAN name=Sector1-10 width=20
add band=5ghz-onlyn comment=\
    "Cell sites radiate this at 120 degrees (south-east)" frequency=5885 \
    list=HamWAN name=Sector2-10 width=20
add band=5ghz-onlyn comment=\
    "Cell sites radiate this at 240 degrees (south-west)" frequency=5855 \
    list=HamWAN name=Sector3-10 width=20
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
add authentication-types=wpa-psk,wpa2-psk eap-methods="" \
    management-protection=allowed mode=dynamic-keys name=hamwan \
    supplicant-identity=""
/interface wireless
set [ find default-name=wlan1 ] adaptive-noise-immunity=ap-and-client-mode \
    antenna-gain=15 band=5ghz-onlyac channel-width=20/40/80mhz-eeeC country=\
    "united states" disabled=no frequency=5825 mode=bridge mtu=1600 \
    nv2-cell-radius=18 radio-name=KM4ECM rx-chains=0,1 security-profile=\
    hamwan ssid=HamWAN-hil-mno station-roaming=enabled tx-chains=0,1 \
    wireless-protocol=nv2
/routing ospf instance
set [ find default=yes ] distribute-default=if-installed-as-type-1 in-filter=\
    AMPR-default out-filter=AMPR-default redistribute-bgp=as-type-1 \
    redistribute-connected=as-type-1 redistribute-other-ospf=as-type-1 \
    router-id=44.34.131.139
/snmp community
set [ find default=yes ] addresses=44.0.0.0/8 name=hamwan
add addresses=44.0.0.0/8 name=public
/system logging action
set 3 remote=44.34.128.171
add bsd-syslog=yes name=centrallogging remote=44.34.128.171 syslog-facility=\
    syslog target=remote
/interface bridge port
add bridge=bridge1 interface=wlan1
/ip neighbor discovery-settings
set discover-interface-list=all
/ip address
add address=44.34.128.110/28 interface=ether1 network=44.34.128.96
add address=44.34.128.102/28 interface=vrrp1 network=44.34.128.96
add address=44.34.131.139 interface=bridge1 network=44.34.131.138
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
set forwarding-enabled=remote strong-crypto=yes
/routing filter
add action=accept chain=AMPR-default prefix=44.0.0.0/8 prefix-length=8-32
add action=accept chain=AMPR-default prefix=0.0.0.0/0
add action=reject chain=AMPR-default
/routing ospf interface
add authentication=md5 interface=ether1 network-type=broadcast
add authentication=md5 interface=bridge1 network-type=point-to-point
/routing ospf network
add area=backbone network=44.34.128.96/28
add area=backbone network=44.34.131.138/32
/snmp
set contact="#HamWAN on irc.freenode.org" enabled=yes src-address=\
    44.34.128.110 trap-version=2
/system clock
set time-zone-name=America/Los_Angeles
/system identity
set name=mno.hil
/system leds
set 1 interface=wlan1
/system logging
add action=centrallogging topics=!debug,!packet,!snmp,!ospf
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