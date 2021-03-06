#!/bin/bash

iptables -t nat -N PROXY
iptables -t nat -F PROXY
iptables -t nat -A PROXY -d 0.0.0.0/8 -j RETURN
iptables -t nat -A PROXY -d 10.0.0.0/8 -j RETURN
iptables -t nat -A PROXY -d 127.0.0.0/8 -j RETURN
iptables -t nat -A PROXY -d 169.254.0.0/16 -j RETURN
iptables -t nat -A PROXY -d 172.16.0.0/12 -j RETURN
iptables -t nat -A PROXY -d 192.168.0.0/16 -j RETURN
iptables -t nat -A PROXY -d 224.0.0.0/4 -j RETURN
iptables -t nat -A PROXY -d 240.0.0.0/4 -j RETURN
iptables -t nat -A PROXY -p tcp --dport 80 -j REDIRECT --to-ports 3129
iptables -t nat -A PROXY -p tcp --dport 443 -j REDIRECT --to-ports 3129
iptables -t nat -A PROXY -j RETURN

iptables -t nat -F OUTPUT
iptables -t nat -A OUTPUT -p tcp -m owner ! --uid-owner 3129 -j PROXY
iptables -P OUTPUT ACCEPT

iptables -t nat -F PREROUTING
iptables -t nat -A PREROUTING -p tcp --dport 443 -j PROXY
iptables -t nat -A PREROUTING -p tcp --dport 80 -j PROXY

# restore docker default setup
systemctl restart docker