# RouterOS 6.48.3
# software id = QQ3B-SRRJ
#
# model = 921UAGS-5SHPacD
# serial number = 6205051FF0B1
/interface bridge
add admin-mac=E4:8D:8C:F0:67:0B auto-mac=no fast-forward=no name=bridge-local
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
    band=5ghz-onlyac compression=yes country="united states3" disabled=no \
    frequency=5745 installation=outdoor mode=station-bridge mtu=1600 \
    nv2-cell-radius=20 radio-name=hil.leb.memhamwan.net rx-chains=0,1 \
    scan-list=5745 security-profile=hamwan ssid=HamWAN-hil-leb \
    station-roaming=enabled tdma-period-size=4 tx-chains=0,1 \
    wireless-protocol=nv2-nstreme-802.11
/ip ipsec proposal
set [ find default=yes ] enc-algorithms=aes-128-cbc
/routing ospf instance
set [ find default=yes ] distribute-default=if-installed-as-type-1 in-filter=\
    AMPR-default out-filter=AMPR-default redistribute-bgp=as-type-1 \
    redistribute-connected=as-type-1 redistribute-other-ospf=as-type-1 \
    redistribute-static=as-type-1 router-id=44.34.129.175
/snmp community
set [ find default=yes ] addresses=44.0.0.0/8
/system logging action
set 0 memory-lines=1
set 1 memory-lines=1 target=memory
set 2 memory-lines=1 target=memory
/interface bridge port
add bridge=bridge-local interface=wlan1
/ip neighbor discovery-settings
set discover-interface-list=none
/ip address
add address=44.34.128.175/27 interface=ether1 network=44.34.128.160
add address=44.34.131.130 interface=bridge-local network=44.34.131.131
/ip dns
set servers=44.34.128.190
/ip firewall mangle
add action=change-mss chain=forward new-mss=1378 passthrough=yes protocol=tcp \
    tcp-flags=syn tcp-mss=!0-1378
add action=change-mss chain=output new-mss=1378 passthrough=yes protocol=tcp \
    tcp-flags=syn tcp-mss=!0-1378
add action=change-mss chain=forward new-mss=1378 passthrough=yes protocol=tcp \
    tcp-flags=syn tcp-mss=!0-1378
add action=change-mss chain=output new-mss=1378 passthrough=yes protocol=tcp \
    tcp-flags=syn tcp-mss=!0-1378
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www address=10.0.0.0/8,172.16.0.0/12,192.168.0.0/16 disabled=yes
set ssh port=222
set api disabled=yes
set winbox disabled=yes
set api-ssl disabled=yes
/ip ssh
set forwarding-enabled=remote strong-crypto=yes
/routing ospf interface
add authentication=md5 interface=ether1 network-type=broadcast
add authentication=md5 interface=bridge-local network-type=point-to-point
/routing ospf network
add area=backbone network=44.34.128.160/27
add area=backbone network=44.34.131.131/32
/snmp
set enabled=yes
/system clock
set time-zone-autodetect=no time-zone-name=America/Chicago
/system identity
set name=hil.leb.memhamwan.net
/system leds
set 1 interface=wlan1
/system logging
set 0 disabled=yes
set 1 disabled=yes
set 2 disabled=yes
set 3 disabled=yes
add action=echo topics=ospf,wireless,error,warning,critical
/system ntp client
set enabled=yes primary-ntp=44.34.128.181 server-dns-names=ntp.memhamwan.net
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
add