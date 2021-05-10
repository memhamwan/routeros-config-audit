# RouterOS 6.48.2
# software id = C1K3-9QMD
#
# model = 921UAGS-5SHPacD
# serial number = 8CEA080C79D3
/interface bridge
add fast-forward=no mtu=1500 name=bridge1
/interface ethernet
set [ find default-name=ether1 ] speed=100Mbps
/interface wireless security-profiles
set [ find default=yes ] authentication-types=wpa2-psk mode=dynamic-keys \
    supplicant-identity=MikroTik
add authentication-types=wpa-psk,wpa2-psk eap-methods="" \
    management-protection=allowed mode=dynamic-keys name=hamwan \
    supplicant-identity=""
/interface wireless
set [ find default-name=wlan1 ] adaptive-noise-immunity=ap-and-client-mode \
    band=5ghz-onlyac disabled=no frequency=5785 hw-retries=15 mtu=1600 \
    nv2-cell-radius=100 radio-name=leb.crw.memhamwan.net rx-chains=0,1 \
    scan-list=5785 security-profile=hamwan ssid=HamWAN-crw-leb \
    station-roaming=enabled tdma-period-size=4 tx-chains=0,1 \
    wireless-protocol=nv2-nstreme-802.11
/routing ospf instance
set [ find default=yes ] distribute-default=if-installed-as-type-1 in-filter=\
    AMPR-default out-filter=AMPR-default redistribute-bgp=as-type-1 \
    redistribute-connected=as-type-1 redistribute-other-ospf=as-type-1 \
    router-id=44.34.131.144
/snmp community
set [ find default=yes ] addresses=44.0.0.0/8
/user group
set full policy="local,telnet,ssh,ftp,reboot,read,write,policy,test,winbox,pas\
    sword,web,sniff,sensitive,api,romon,dude,tikapp"
/interface bridge port
add bridge=bridge1 interface=wlan1
/ip neighbor discovery-settings
set discover-interface-list=none
/ip address
add address=44.34.129.115/28 interface=ether1 network=44.34.129.112
add address=44.34.131.144 interface=bridge1 network=44.34.131.145
/ip dhcp-client
add comment=defconf disabled=no
/ip dns
set servers=44.34.128.190
/ip firewall mangle
add action=change-mss chain=forward new-mss=1378 passthrough=yes protocol=tcp \
    tcp-flags=syn tcp-mss=!0-1378
add action=change-mss chain=output new-mss=1378 passthrough=yes protocol=tcp \
    tcp-flags=syn tcp-mss=!0-1378
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
add area=backbone network=44.34.129.112/28
add area=backbone network=44.34.131.145/32
/snmp
set enabled=yes
/system clock
set time-zone-autodetect=no time-zone-name=America/Chicago
/system identity
set name=leb.crw.memhamwan.net
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