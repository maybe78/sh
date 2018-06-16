#!/bin/sh

# Your vpn provider IP
VPNSERVERIP=`127.0.0.1`
OPVPNENABLE=`nvram get openvpncl_enable | awk '$1 == "0" {print $1}'`

if [ "$OPVPNENABLE" != 0 ]
then
   nvram set openvpncl_enable=0
   nvram commit
fi

sleep 10
mkdir /tmp/gnezdo; cd /tmp/gnezdo
echo "#!/bin/sh
iptables -I FORWARD -i br0 -o tun0 -j ACCEPT
iptables -I FORWARD -i tun0 -o br0 -j ACCEPT
iptables -t nat -I POSTROUTING -o tun0 -j MASQUERADE" > route-up.sh
echo "#!/bin/sh
sleep 2
iptables -t nat -D POSTROUTING -o tun0 -j MASQUERADE" > route-down.sh
chmod 700 route-up.sh route-down.sh 
sleep 10

# NOTE: Paste your.*.ovpn profile between ##--BEGIN--## and ##--END--##
 
echo "##--BEGIN--##
# paste your *.openvpn file entire contents here
##--END--##
log-append /tmp/gnezdovpn.log
script-security 2" > openvpn.conf

(killall openvpn; openvpn --config /tmp/gnezdo/openvpn.conf --route-up /tmp/gnezdo/route-up.sh --down /tmp/gnezdo/route-down.sh) &
exit 0