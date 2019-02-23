#!/bin/bash

# Inspired from http://www.naju.se/articles/openvpn-netns.html
# ...but it didn't work out of the box (interfaces set up but no I/O went through)
#
# He forgot to set $5 as the point-to-point remote end.
#
# DHCP DNS portion from https://github.com/masterkorp/openvpn-update-resolv-conf/blob/master/update-resolv-conf.sh
#
# The new netns will be called by the basename of your OpenVPN configuration file.
# (Watch out: renaming such a file on Debian requires running "systemctl daemon-reload"!)

NS=$(basename -s .conf $config)
NETNSDIR="/etc/netns/$NS"
RESOLVCONF="$NETNSDIR/resolv.conf"

case $script_type in

	up)
		ip netns add $NS
		ip netns exec $NS ip link set dev lo up

		mkdir -p $NETNSDIR
		echo -n >${RESOLVCONF}
		for optionname in ${!foreign_option_*}; do
			if [ "${!optionname:0:15}" = "dhcp-option DNS" ]; then
				echo "nameserver ${!optionname#dhcp-option DNS }" >>${RESOLVCONF}
			fi
		done
		# If it wasn't a leak risk, I'd add just in case:
		# echo -e "nameserver 8.8.8.8\n8.8.4.4" >>${RESOLVCONF}

		ip link set dev "$1" up netns $NS mtu "$2"
		ip netns exec $NS ip addr add dev "$1" "$4/${ifconfig_netmask:-30}" ${ifconfig_remote:+peer "$ifconfig_remote"} ${ifconfig_broadcast:+broadcast "$ifconfig_broadcast"}
		test -n "$ifconfig_ipv6_local" && ip netns exec $NS ip addr add dev "$1" "$ifconfig_ipv6_local"/112
	;;

	route-up)
		ip netns exec $NS ip route add default via "$route_vpn_gateway"
		test -n "$ifconfig_ipv6_remote" && ip netns exec $NS ip route add default via "$ifconfig_ipv6_remote"
	;;

	down)
		#ip netns delete $NS
		ip netns exec $NS ip route del default
	;;

esac

exit 0
