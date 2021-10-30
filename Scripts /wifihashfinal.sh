#!/bin/bash

# read wifi mac and calc its sum then write into file

WLAN_HASH=$(/usr/sbin/iw wlan0 info | grep "addr" | cut -d ' ' -f2 | md5sum | cut -d' ' -f1 | cut -c 25-)
ifconfig wlan0 |  grep 'ether ' | awk '{print $2}' | tr -d "\n" | md5sum | awk '{print $1}' | cut -c 20- > hash.txt

wifiname='rf_'$(cat hash.txt)'_5g'

#change the wifi settings
sed -i "s/^ssid=.*/ssid=$wifiname/" /etc/hostapd/hostapd.conf
rm -f hash.txt

#pass for wifi vmx21234
