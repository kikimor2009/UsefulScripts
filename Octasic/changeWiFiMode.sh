#!/bin/bash

#Change wifi name of the board (2.4 and 5 ghz)
md5=`ifconfig eth0 | grep 'HWaddr' | awk '{print $5}' | tr -d "\n" | md5sum | awk '{print $1}' | cut -c 24- `

wifiname2=sony_"$md5"_2g
wifiname5=sony_"$md5"_5g

sed -i "5s/SSID=.*/SSID=\"$wifiname5\"/g" /home/script/uaputl_5ghz.conf
sed -i "5s/SSID=.*/SSID=\"$wifiname2\"/g" /home/script/uaputl_2_4ghz.conf

result=$(cat /home/script/startWifiHotspot.sh | grep -o "uaputl_5ghz.conf")

if [ -n "$result" ]; then
    sed -i "s/$result/uaputl_2_4ghz\.conf/g" /home/script/startWifiHotspot.sh
    sed -i "4s/ssid=.*/ssid=\"$wifiname2\"/g" /home/script/wpa_supplicant.conf
else
    sed -i "s/uaputl_2_4ghz\.conf/uaputl_5ghz\.conf/g" /home/script/startWifiHotspot.sh
    sed -i "4s/ssid=.*/ssid=\"$wifiname5\"/g" /home/script/wpa_supplicant.conf
fi
