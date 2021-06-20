# RouterOS 6.48.3
# software id = CIAG-EMEJ
#
# model = 921UAGS-5SHPacT
# serial number = 5AB80495261A
/interface bridge
add fast-forward=no mtu=1500 name=bridge1
/interface ethernet
set [ find default-name=ether1 ] speed=100Mbps
/interface vrrp
add authentication=ah interface=ether1 name=vrrp1 version=2
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
add authentication-types=wpa-psk,wpa2-psk eap-methods="" \
    management-protection=allowed mode=dynamic-keys name=hamwan \
    supplicant-identity=""
/interface wireless
set [ find default-name=wlan1 ] adaptive-noise-immunity=ap-and-client-mode \
    band=5ghz-onlyac compression=yes country="united states3" disabled=no \
    frequency=5745 installation=outdoor mode=bridge mtu=1600 nv2-cell-radius=\
    20 radio-name=leb.hil.memhamwan.net rx-chains=0,1 scan-list=5745 \
    security-profile=hamwan ssid=HamWAN-hil-leb station-roaming=enabled \
    tdma-period-size=4 tx-chains=0,1 wireless-protocol=nv2
/ip ipsec proposal
set [ find default=yes ] enc-algorithms=aes-128-cbc
/routing ospf instance
set [ find default=yes ] distribute-default=if-installed-as-type-1 in-filter=\
    AMPR-default out-filter=AMPR-default redistribute-bgp=as-type-1 \
    redistribute-connected=as-type-1 redistribute-other-ospf=as-type-1 \
    router-id=44.34.131.131
/snmp community
set [ find default=yes ] addresses=44.0.0.0/8
/system logging action
add bsd-syslog=yes name=centrallogging remote=44.34.128.171 syslog-facility=\
    syslog target=remote
/interface bridge port
add bridge=bridge1 interface=wlan1
/ip neighbor discovery-settings
set discover-interface-list=none
/ip address
add address=44.34.128.97/28 interface=ether1 network=44.34.128.96
add address=44.34.128.102 interface=vrrp1 network=44.34.128.102
add address=44.34.131.131 interface=bridge1 network=44.34.131.130
/ip dns
set servers=44.34.128.190
/ip firewall mangle
add action=change-mss chain=forward new-mss=1378 passthrough=yes protocol=tcp \
    tcp-flags=syn tcp-mss=!0-1378
add action=change-mss chain=output new-mss=1378 passthrough=yes protocol=tcp \
    tcp-flags=syn tcp-mss=!0-1378
/ip ipsec policy
set 0 dst-address=0.0.0.0/0 src-address=0.0.0.0/0
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www disabled=yes
set ssh port=222
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
add area=backbone network=44.34.131.130/32
/snmp
set contact="#HamWAN on irc.freenode.org" enabled=yes
/system clock
set time-zone-autodetect=no time-zone-name=America/Chicago
/system identity
set name=leb.hil.memhamwan.net
/system leds
set 1 interface=wlan1
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