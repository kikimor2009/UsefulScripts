#!/usr/bin/env bash

echo "interface eth0" >> /etc/dhcpcd.conf
echo "static ip_address=192.168.0.100/24" >> /etc/dhcpcd.conf 
echo "static routers=192.168.0.1" >> /etc/dhcpcd.conf