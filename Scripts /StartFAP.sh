#!/usr/bin/bash -x

#Checking for params quantity
if [[ "$#" -ne 6 ]]; then
  echo "Script use: wlan_num MAC channel SSID wpa_type pass"
  exit 1
fi

echo "Appling config for $1"
sed -i "/interface/s/=.*$/=$1/" /etc/hostapd/hostapd_wlan.conf #change wlan intrf

#Changing MAC of the wlan
sudo ip link set "$1" down || exit 2
macchanger --mac="$2" "$1"

#Changing AP working channel
if [[ "$3" -gt 0 && "$3" -lt 14 ]]; then
  sed -i "/hw_mode/s/=.*$/=g/" /etc/hostapd/hostapd_wlan.conf #change standart
  sed -i "/channel/s/=.*$/=$3/" /etc/hostapd/hostapd_wlan.conf #change channel
elif [[ "$3" -gt 35 && "$3" -lt 162 ]]; then
  sed -i "/hw_mode/s/=.*$/=a/" /etc/hostapd/hostapd_wlan.conf #change standart
  sed -i "/channel/s/=.*$/=$3/" /etc/hostapd/hostapd_wlan.conf #change channel
else
  echo "Wrong channel number. Check the parameter"
  exit 3
fi

#Set AP SSID
sed -i "/ssid/s/=.*$/=${4}/" /etc/hostapd/hostapd_wlan.conf

#Set wpa version
if [[ "$5" -eq 1 || "$5" -eq 2 ]]; then
  sed -i "/wpa=/s/=.*$/=$5/" /etc/hostapd/hostapd_wlan.conf
else
  echo "Supported wpa versions are: 1 or 2"
  exit 4
fi

#Set AP password
sed -i "/wpa_passphrase/s/=.*$/=${6}/" /etc/hostapd/hostapd_wlan.conf

#set iptables

#set ip gw
if [[ "$1" = "wlan1" ]]; then
  ip address add 192.168.77.1/24 dev "$1"
else
  ip address add 192.168.66.1/24 dev "$1"
fi

sudo ip link set "$1" up

if [[ "$1" = "wlan1" ]]; then
  dnsmasq --interface=wlan1 --except-interface=lo --bind-interfaces --dhcp-range=192.168.77.10,192.168.77.90,12h --address=/#/192.168.77.1 --pid-file=/root/SetupScripts/run/dnsmasq_$1.pid --conf-file=/dev/null
else
  dnsmasq --interface=wlan2 --except-interface=lo --bind-interfaces --dhcp-range=192.168.66.10,192.168.66.90,12h --address=/#/192.168.66.1 --pid-file=/root/SetupScripts/run/dnsmasq_$1.pid --conf-file=/dev/null
fi

sleep 1

#running sepparate hostapd
hostapd -BP /root/SetupScripts/run/hostapd.pid /etc/hostapd/hostapd_wlan.conf
