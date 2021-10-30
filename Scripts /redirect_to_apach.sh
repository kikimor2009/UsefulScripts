#!/usr/bin/bash -x

sysctl -w net.ipv4.conf.all.route_localnet=1

iptables -t nat -I PREROUTING -s 192.168.66.0/24 -p tcp --dport 80 -j DNAT --to 127.0.0.1:80
iptables -t nat -I PREROUTING -s 192.168.66.0/24 -p tcp --dport 443 -j DNAT --to 127.0.0.1:443

systemctl start apache2
