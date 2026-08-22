#!/bin/bash

NS_NAME="proxyns"
PROXY_PORT="2080"
PROXY_TYPE="socks5"

ip netns add $NS_NAME

ip link add v-host type veth peer name v-ns
ip link set v-ns netns $NS_NAME

ip addr add 10.200.200.1/24 dev v-host
ip link set v-host up

ip -n $NS_NAME addr add 10.200.200.2/24 dev v-ns
ip -n $NS_NAME link set v-ns up
ip -n $NS_NAME link set lo up

pkill -f "socat TCP-LISTEN:$PROXY_PORT,bind=10.200.200.1"
socat TCP-LISTEN:$PROXY_PORT,bind=10.200.200.1,reuseaddr,fork TCP:127.0.0.1:$PROXY_PORT &

mkdir -p /etc/netns/$NS_NAME
echo "nameserver 1.1.1.1" > /etc/netns/$NS_NAME/resolv.conf

pkill -f "tun2socks -device tun0"
ip netns exec $NS_NAME tun2socks -device tun0 -proxy $PROXY_TYPE://10.200.200.1:$PROXY_PORT &
sleep 1

ip -n $NS_NAME link set tun0 up
ip -n $NS_NAME route add default dev tun0

echo "'$NS_NAME' created. traffic going through $PROXY_TYPE://127.0.0.1:$PROXY_PORT"
