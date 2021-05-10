# RouterOS 6.48.1
# software id = GXJJ-5ZK0
#
# model = CRS125-24G-1S
# serial number = 5240040DE39C
/interface bridge
add admin-mac=4C:5E:0C:A4:F9:29 auto-mac=no comment=\
    "created from master port" name=bridge1 protocol-mode=none
/interface ethernet
set [ find default-name=ether1 ] name=ether1-master-local speed=100Mbps
set [ find default-name=ether2 ] comment="leb's guest network" disabled=yes \
    name=ether2-slave-local speed=100Mbps
set [ find default-name=ether3 ] name=ether3-slave-local speed=100Mbps
set [ find default-name=ether4 ] name=ether4-slave-local speed=100Mbps
set [ find default-name=ether5 ] name=ether5-slave-local speed=100Mbps
set [ find default-name=ether6 ] name=ether6-slave-local speed=100Mbps
set [ find default-name=ether7 ] name=ether7-slave-local speed=100Mbps
set [ find default-name=ether8 ] name=ether8-slave-local speed=100Mbps
set [ find default-name=ether9 ] name=ether9-slave-local speed=100Mbps
set [ find default-name=ether10 ] name=ether10-slave-local speed=100Mbps
set [ find default-name=ether11 ] name=ether11-slave-local speed=100Mbps
set [ find default-name=ether12 ] name=ether12-slave-local speed=100Mbps
set [ find default-name=ether13 ] comment=eth0.nas1.leb name=\
    ether13-slave-local speed=100Mbps
set [ find default-name=ether14 ] comment=eth1.nas1.leb name=\
    ether14-slave-local speed=100Mbps
set [ find default-name=ether15 ] comment=ups1.leb name=ether15-slave-local \
    speed=100Mbps
set [ find default-name=ether16 ] name=ether16-slave-local speed=100Mbps
set [ find default-name=ether17 ] comment=ether1.ptpazo.leb name=\
    ether17-slave-local speed=100Mbps
set [ find default-name=ether18 ] comment=ether1.ptpmno.leb name=\
    ether18-slave-local speed=100Mbps
set [ find default-name=ether19 ] comment=eth1.esxi1.leb name=\
    ether19-slave-local speed=100Mbps
set [ find default-name=ether20 ] comment=eth0.esxi1.leb name=\
    ether20-slave-local speed=100Mbps
set [ find default-name=ether21 ] comment=ether1.ptphil.leb name=\
    ether21-slave-local speed=100Mbps
set [ find default-name=ether22 ] comment=ether1.ptpsco.leb name=\
    ether22-slave-local speed=100Mbps
set [ find default-name=ether23 ] comment=ilo.nas1.leb name=\
    ether23-slave-local speed=100Mbps
set [ find default-name=ether24 ] comment=ether1.omn1.leb name=\
    ether24-slave-local speed=100Mbps
set [ find default-name=sfp1 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full name=\
    sfp1-slave-local
/interface vrrp
add authentication=ah interface=bridge1 name=vrrp1 version=2
/interface ethernet switch trunk
add member-ports=ether10-slave-local,ether11-slave-local name=trunk1
/interface list
add exclude=dynamic name=discover
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip ipsec proposal
set [ find default=yes ] enc-algorithms=aes-128-cbc
/ip pool
add name=dhcp_pool1 ranges=10.0.2.2-10.0.2.14
/routing ospf instance
set [ find default=yes ] in-filter=AMPR-default out-filter=AMPR-default \
    redistribute-bgp=as-type-1 redistribute-connected=as-type-1 \
    redistribute-other-ospf=as-type-1 redistribute-static=as-type-1 \
    router-id=44.34.128.161
/snmp community
set [ find default=yes ] addresses=44.0.0.0/8 name=hamwan
add addresses=44.0.0.0/8 name=public
/system logging action
set 3 bsd-syslog=yes remote=44.34.128.171 syslog-facility=syslog \
    syslog-severity=error
add bsd-syslog=yes name=centrallogging remote=44.34.128.171 syslog-facility=\
    syslog target=remote
/interface bridge port
add bridge=bridge1 interface=ether3-slave-local
add bridge=bridge1 interface=ether4-slave-local
add bridge=bridge1 interface=ether5-slave-local
add bridge=bridge1 interface=ether6-slave-local
add bridge=bridge1 interface=ether7-slave-local
add bridge=bridge1 interface=ether8-slave-local
add bridge=bridge1 interface=ether9-slave-local
add bridge=bridge1 interface=ether10-slave-local
add bridge=bridge1 interface=ether11-slave-local
add bridge=bridge1 interface=ether12-slave-local
add bridge=bridge1 interface=ether13-slave-local
add bridge=bridge1 interface=ether14-slave-local
add bridge=bridge1 interface=ether15-slave-local
add bridge=bridge1 interface=ether16-slave-local
add bridge=bridge1 interface=ether17-slave-local
add bridge=bridge1 interface=ether18-slave-local
add bridge=bridge1 interface=ether19-slave-local
add bridge=bridge1 interface=ether20-slave-local
add bridge=bridge1 interface=ether21-slave-local
add bridge=bridge1 interface=ether22-slave-local
add bridge=bridge1 interface=ether23-slave-local
add bridge=bridge1 interface=ether24-slave-local
add bridge=bridge1 interface=sfp1-slave-local
add bridge=bridge1 interface=ether1-master-local
/ip neighbor discovery-settings
set discover-interface-list=none
/interface list member
add interface=bridge1 list=discover
add interface=ether3-slave-local list=discover
add interface=ether4-slave-local list=discover
add interface=ether5-slave-local list=discover
add interface=ether6-slave-local list=discover
add interface=ether7-slave-local list=discover
add interface=ether8-slave-local list=discover
add interface=ether9-slave-local list=discover
add interface=ether10-slave-local list=discover
add interface=ether11-slave-local list=discover
add interface=ether12-slave-local list=discover
add interface=ether13-slave-local list=discover
add interface=ether14-slave-local list=discover
add interface=ether15-slave-local list=discover
add interface=ether16-slave-local list=discover
add interface=ether17-slave-local list=discover
add interface=ether18-slave-local list=discover
add interface=ether19-slave-local list=discover
add interface=ether20-slave-local list=discover
add interface=ether21-slave-local list=discover
add interface=ether22-slave-local list=discover
add interface=ether23-slave-local list=discover
add interface=ether24-slave-local list=discover
add interface=sfp1-slave-local list=discover
add list=discover
add interface=vrrp1 list=discover
/ip address
add address=44.34.128.161/27 interface=bridge1 network=44.34.128.160
/ip dns
set servers=44.34.128.190
/ip firewall mangle
add action=change-mss chain=output new-mss=1378 passthrough=yes protocol=tcp \
    tcp-flags=syn tcp-mss=!0-1378
add action=change-mss chain=forward new-mss=1378 passthrough=yes protocol=tcp \
    tcp-flags=syn tcp-mss=!0-1378
/ip ipsec policy
set 0 dst-address=0.0.0.0/0 src-address=0.0.0.0/0
/ip proxy
set cache-path=web-proxy1
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
/lcd
set time-interval=daily
/lcd interface
add interface=bridge1
/lcd interface pages
set 2 interfaces=sfp1-slave-local
/routing filter
add action=accept chain=AMPR-default prefix=44.0.0.0/8 prefix-length=8-32
add action=accept chain=AMPR-default prefix=0.0.0.0/0
add action=reject chain=AMPR-default
/routing ospf interface
add authentication=md5 interface=bridge1 network-type=broadcast
/routing ospf network
add area=backbone network=44.34.128.160/27
/snmp
set contact="#HamWAN on irc.freenode.org" enabled=yes trap-version=2
/system clock
set time-zone-autodetect=no time-zone-name=America/Chicago
/system identity
set name=r1.leb.memhamwan.net
/system logging
set 0 action=echo disabled=yes
set 1 action=echo
set 2 action=echo
add action=remote topics=critical,error,info,warning
add topics=critical,error,info,warning
add action=echo topics=!debug
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
/tool sniffer
set filter-interface=all filter-port=ntp