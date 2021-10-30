#!/usr/bin/bash -x

kill -9 "$(cat /root/SetupScripts/run/hostapd.pid)"
kill -9 "$(cat /root/SetupScripts/run/dnsmasq_"$1".pid)"

if [[ "$1" = "wlan1" || "$1" = "wlan2" ]]; then
  echo "Restore defaults for $1"
else
  echo "Unknown interface number. Use only wlan1 or wlan2"
  exit 1
fi

sudo ip link set "$1" down
macchanger -p "$1"
sudo iw dev "$1" set type monitor

if [[ "$1" = "wlan1" ]]; then
  ip address del 192.168.77.1/24 dev $1
else
  ip address del 192.168.66.1/24 dev $1
fi

sudo ip link set "$1" up
