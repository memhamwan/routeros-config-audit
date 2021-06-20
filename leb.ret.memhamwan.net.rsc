# RouterOS 6.48.3
# software id = SCJG-GLK5
#
# model = RBLHGG-5HPacD2HPnD
# serial number = C3700BAEBBEB
/interface bridge
add admin-mac=C4:AD:34:9B:3C:59 auto-mac=no comment=defconf name=bridge
add name=bridge1
/interface wireless
set [ find default-name=wlan1 ] band=2ghz-onlyn country="united states3" \
    disabled=no frequency=auto installation=outdoor ssid=MikroTik
set [ find default-name=wlan2 ] adaptive-noise-immunity=ap-and-client-mode \
    antenna-gain=0 band=5ghz-onlyac country="united states3" disabled=no \
    frequency=5805 installation=outdoor mode=station-bridge nv2-cell-radius=\
    10 radio-name=leb.ret.memhamwan.net scan-list=5805 ssid=HamWAN-ret-leb \
    station-roaming=enabled tdma-period-size=4
/interface wireless security-profiles
set [ find default=yes ] authentication-types=wpa2-psk mode=dynamic-keys \
    supplicant-identity=MikroTik
/routing ospf instance
set [ find default=yes ] distribute-default=if-installed-as-type-1 in-filter=\
    AMPR-default out-filter=hamwan-out redistribute-bgp=as-type-1 \
    redistribute-connected=as-type-1 redistribute-other-ospf=as-type-1 \
    redistribute-static=as-type-1 router-id=54.34.131.146
/snmp community
set [ find default=yes ] addresses=44.0.0.0/8
/interface bridge port
add bridge=bridge1 comment=defconf interface=ether1
add bridge=bridge1 comment=defconf interface=sfp1
add bridge=bridge comment=defconf interface=wlan1
add bridge=bridge comment=defconf interface=wlan2
/ip neighbor discovery-settings
set discover-interface-list=none
/ip address
add address=44.34.131.146 interface=bridge network=44.34.131.147
add address=44.34.129.161/28 interface=bridge1 network=44.34.129.160
/ip dhcp-client
add interface=bridge1
add disabled=no interface=bridge1
/ip dns
set servers=44.34.128.190
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www disabled=yes
set ssh port=222
set api disabled=yes
set winbox disabled=yes
set api-ssl disabled=yes
/ip ssh
set strong-crypto=yes
/routing filter
add action=accept chain=AMPR-default prefix=44.0.0.0/8 prefix-length=8-32
add action=accept chain=AMPR-default prefix=0.0.0.0/0
add action=accept chain=hamwan-out prefix=44.0.0.0/8 prefix-length=8-32
add action=accept chain=hamwan-out prefix=0.0.0.0/0
add action=reject chain=hamwan-out
/routing ospf interface
add authentication=md5 interface=bridge network-type=point-to-point
add authentication=md5 interface=bridge1 network-type=broadcast
/routing ospf network
add area=backbone network=44.34.131.147/32
add area=backbone network=44.34.129.160/28
add area=backbone network=44.34.128.208/28
/snmp
set enabled=yes
/system clock
set time-zone-autodetect=no time-zone-name=America/Chicago
/system identity
set name=leb.ret.memhamwan.net
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