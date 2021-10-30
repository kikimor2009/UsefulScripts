#!/bin/bash
wi="$(ifconfig | grep "wlan" | awk -F: '{print $1}')"
echo "$wi" > /root/scripts/EnablModeMoni.txt
/usr/bin/sed -i '/wla/s/^/airmon-ng start /' /root/scripts/EnablModeMoni.txt
airmon-ng check kill
/usr/bin/bash /root/scripts/EnablModeMoni.txt
