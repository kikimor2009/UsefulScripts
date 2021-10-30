#!/bin/bash

#main ip address of the board
ip=$(grep "address" /etc/network/interfaces | awk '{print $2}' | tr -d "\n")

#4 octet of main ip address
oct4=$( echo "$ip" | tr "." " " | awk '{print $4}')

#correct ips of pri and sec
dspPr=$(echo "$ip" | sed "s/\(.*\)\..*/\1.$((oct4 + 1))/")
dspSec=$(echo "$ip" | sed "s/\(.*\)\..*/\1.$((oct4 + 2))/")

#if obmd.properties exists
if [[ -e "/etc/obmd.properties" ]]; then
  mv /etc/obmd.properties /etc/obmd.properties.bak
fi

sleep 5
obm cw
chmod 0777 /etc/obmd.properties
chmod 0777 /etc/obmd.properties.bak

#current ips of pri and sec in obm.prop
opdspPr=$(grep "Dsp\[0\].IPAddress" /etc/obmd.properties | awk '{ print $2 }')
opdspSec=$(grep "Dsp\[1\].IPAddress" /etc/obmd.properties | awk '{ print $2 }')

if [ -e "/etc/obmd.properties.bak" ]; then
  #current ips of pri and sec in obm.prop.bak
  opbdspPr=$(grep "Dsp\[0\].IPAddress" /etc/obmd.properties.bak | awk '{ print $2 }')
  opbdspSec=$(grep "Dsp\[1\].IPAddress" /etc/obmd.properties.bak | awk '{ print $2 }')
  sed -i "s/$opbdspPr/$dspPr/" /etc/obmd.properties.bak
  sed -i "s/$opbdspSec/$dspSec/" /etc/obmd.properties.bak
fi

#change ips of the dsps to correct
sed -i "s/$opdspPr/$dspPr/" /etc/obmd.properties
sed -i "s/$opdspSec/$dspSec/" /etc/obmd.properties
