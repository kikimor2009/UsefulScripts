#!/bin/bash

if [[ -z $1 || ! ($# -eq 1) ]]; then
    echo "Usage : changeWiFiName.sh name"
    exit 1
fi
        
name2g="$(grep "SSID=\"" /home/script/uaputl_2_4ghz.conf | cut -d "\"" -f 2)"
name5g="$(grep "SSID=\"" /home/script/uaputl_5ghz.conf | cut -d "\"" -f 2)"
#newname2g="$1_2g"
#newname5g="$1_5g"
        
newname="$1"
        
#echo -e "$name2g\n$name5g"
#echo "$newname2g \n $newname5g"
#echo "$newname"

result=$(grep -o "uaputl_5ghz.conf" /home/script/startWifiHotspot.sh)

if [ -n "$result" ]; then
  sed -i "s/$name5g/$newname/" /home/script/uaputl_5ghz.conf
else
  sed -i "s/$name2g/$newname/" /home/script/uaputl_2_4ghz.conf
fi

sed -i "s/ssid=.*/ssid=\"$newname\"/" /home/script/wpa_supplicant.conf
       
cd /usr/share/mrvl || exit
uaputl.exe bss_stop
uaputl.exe sys_reset
sleep 5

cd /home/script || exit
./startWifiHotspot.sh
