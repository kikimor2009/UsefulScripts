#!/bin/bash

# $1 - interface name(e.g. wlan1)
# $2 - ssid string
# $3 - bssid string
# $4 - password string
# $5 - channel number

if [[ $( nmcli connection show | grep "$1") ]];
then
    sudo nmcli con down "$1"
    sudo nmcli con delete "$1"
fi

sudo nmcli con add type wifi ifname "$1" con-name "$1" autoconnect no ssid "$2"
sudo nmcli con modify "$1" 802-11-wireless.mode ap
if [ "$5" -gt 14 ];
then
    sudo nmcli con modify "$1" 802-11-wireless.band a
else
    sudo nmcli con modify "$1" 802-11-wireless.band bg
fi
sudo nmcli con modify "$1" 802-11-wireless.cloned-mac-address "$3"
sudo nmcli con modify "$1" 802-11-wireless.channel "$5"
sudo nmcli con modify "$1" ipv4.method shared
sudo nmcli con modify "$1" wifi-sec.key-mgmt wpa-psk
sudo nmcli con modify "$1" wifi-sec.psk "$4"
sudo nmcli con up "$1"
