#!/bin/bash

wifiname2=$(grep -o "sony.[^\"]*" /home/script/uaputl_2_4ghz.conf)
wifiname5=$(grep -o "sony.[^\"]*" /home/script/uaputl_5ghz.conf)

result=$(grep -o "uaputl_5ghz.conf" /home/script/startWifiHotspot.sh)

if [ -n "$result" ]; then
  sed -i "s/$result/uaputl_2_4ghz\.conf/g" /home/script/startWifiHotspot.sh
  sed -i "s/ssid=.*/ssid=\"$wifiname2\"/g" /home/script/wpa_supplicant.conf
else
  sed -i "s/uaputl_2_4ghz\.conf/uaputl_5ghz\.conf/g" /home/script/startWifiHotspot.sh
  sed -i "s/ssid=.*/ssid=\"$wifiname5\"/g" /home/script/wpa_supplicant.conf
fi
