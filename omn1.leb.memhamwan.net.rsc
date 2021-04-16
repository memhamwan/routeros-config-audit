# RouterOS 6.48.1
# software id = CSRX-XXDC
#
# model = OmniTIK UPA-5HnD
# serial number = 4C9C04E27FCE
/interface bridge
add admin-mac=4C:5E:0C:6D:7A:27 auto-mac=no fast-forward=no mtu=1500 name=\
    bridge-local
/interface ethernet
set [ find default-name=ether1 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full comment=\
    r1.leb name=ether1-gateway
set [ find default-name=ether2 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full comment=\
    ptpcrw.leb name=ether2-master-local
set [ find default-name=ether3 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full comment=\
    ptphil.leb name=ether3-slave-local
set [ find default-name=ether4 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full comment=\
    ptpazo.leb name=ether4-slave-local
set [ find default-name=ether5 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full name=\
    ether5-slave-local
/interface wireless
set [ find default-name=wlan1 ] adaptive-noise-immunity=ap-and-client-mode \
    band=5ghz-onlyn channel-width=5mhz country="united states3" disabled=no \
    frequency=5865 frequency-mode=superchannel ht-supported-mcs="mcs-0,mcs-1,m\
    cs-2,mcs-3,mcs-4,mcs-5,mcs-6,mcs-7,mcs-8,mcs-9,mcs-10,mcs-11,mcs-12,mcs-13\
    ,mcs-14,mcs-15" mode=ap-bridge name=wlan1-gateway nv2-cell-radius=10 \
    preamble-mode=long radio-name=omn1.leb ssid=HamWAN station-roaming=\
    enabled tdma-period-size=4 wireless-protocol=nv2
/interface vrrp
add authentication=ah interface=bridge-local name=vrrp1 version=2
/interface list
add name=mactel
add name=mac-winbox
/interface wireless channels
add band=5ghz-onlyn frequency=5865 list=HamWAN name=Omni width=5
add band=5ghz-onlyn comment="Cell sites radiate this at 0 degrees (north)" \
    frequency=5920 list=HamWAN name=Sector1-5 width=5
add band=5ghz-onlyn comment=\
    "Cell sites radiate this at 120 degrees (south-east)" frequency=5900 \
    list=HamWAN name=Sector2-5 width=5
add band=5ghz-onlyn comment=\
    "Cell sites radiate this at 240 degrees (south-west)" frequency=5880 \
    list=HamWAN name=Sector3-5 width=5
add band=5ghz-onlyn comment="Cell sites radiate this at 0 degrees (north)" \
    frequency=5920 list=HamWAN name=Sector1-10 width=10
add band=5ghz-onlyn comment=\
    "Cell sites radiate this at 120 degrees (south-east)" frequency=5900 \
    list=HamWAN name=Sector2-10 width=10
add band=5ghz-onlyn comment=\
    "Cell sites radiate this at 240 degrees (south-west)" frequency=5880 \
    list=HamWAN name=Sector3-10 width=10
add band=5ghz-onlyn comment=Omn2 frequency=5865 list=HamWAN name=omn1-5 \
    width=5
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip ipsec proposal
set [ find default=yes ] enc-algorithms=aes-128-cbc
/ip pool
add name=pool1 ranges=44.34.128.210-44.34.128.222
add name=dhcp_pool4 ranges=10.10.0.2-10.10.0.254
add name=dhcp_pool5 ranges=44.34.128.210-44.34.128.222
/ip dhcp-server
add address-pool=dhcp_pool5 authoritative=after-2sec-delay disabled=no \
    interface=wlan1-gateway name=dhcp2
/routing ospf instance
set [ find default=yes ] distribute-default=if-installed-as-type-1 in-filter=\
    AMPR-default out-filter=AMPR-default redistribute-connected=as-type-1 \
    redistribute-other-ospf=as-type-1 router-id=44.34.128.183
/snmp community
set [ find default=yes ] addresses=44.0.0.0/8
/interface bridge port
add bridge=bridge-local hw=no interface=ether2-master-local
add bridge=bridge-local hw=no interface=ether1-gateway
add bridge=bridge-local hw=no interface=ether4-slave-local
add bridge=bridge-local hw=no interface=ether3-slave-local
add bridge=bridge-local hw=no interface=ether5-slave-local
/ip neighbor discovery-settings
set discover-interface-list=none
/interface ethernet poe settings
set ether1-poe-in-long-cable=yes
/interface list member
add interface=ether2-master-local list=mactel
add interface=ether3-slave-local list=mactel
add interface=ether2-master-local list=mac-winbox
add interface=ether4-slave-local list=mactel
add interface=ether3-slave-local list=mac-winbox
add interface=ether5-slave-local list=mactel
add interface=ether4-slave-local list=mac-winbox
add interface=wlan1-gateway list=mactel
add interface=ether5-slave-local list=mac-winbox
add interface=bridge-local list=mactel
add interface=wlan1-gateway list=mac-winbox
add interface=bridge-local list=mac-winbox
/ip address
add address=44.34.128.183/27 interface=bridge-local network=44.34.128.160
add address=44.34.128.209/28 interface=wlan1-gateway network=44.34.128.208
add address=44.34.128.174 interface=vrrp1 network=44.34.128.174
/ip dhcp-server network
add address=44.34.128.208/28 dns-server=44.34.132.1,44.34.133.1 domain=\
    memhamwan.net gateway=44.34.128.209 netmask=28 ntp-server=\
    44.34.132.3,44.34.133.3
/ip dns
set servers=44.34.128.190
/ip firewall mangle
add action=change-mss chain=output new-mss=1378 protocol=tcp tcp-flags=syn \
    tcp-mss=!0-1378
add action=change-mss chain=forward new-mss=1378 protocol=tcp tcp-flags=syn \
    tcp-mss=!0-1378
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
add authentication=md5 interface=bridge-local network-type=broadcast
add authentication=md5 interface=wlan1-gateway network-type=broadcast
/routing ospf network
add area=backbone network=44.34.128.160/27
add area=backbone network=44.34.128.208/28
/snmp
set enabled=yes
/system clock
set time-zone-name=America/Los_Angeles
/system identity
set name=omn1.leb.memhamwan.net
/system leds
set 0 interface=ether1-gateway
set 1 interface=ether2-master-local
set 2 interface=ether3-slave-local
set 3 interface=ether4-slave-local
set 4 interface=ether5-slave-local
/system logging
add action=echo topics=wireless
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
set filter-direction=rx filter-interface=ether2-master-local