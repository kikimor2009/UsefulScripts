#!/bin/bash

#4 octet of main ip address
oct4=$(echo "$1" | tr "." " " | awk '{print $4}')

#correct ips of pri only
dspPri=$(echo "$1" | sed "s/\(.*\)\..*/\1.$((oct4 + 1))/")

#subnetwork from ip adress
network=${1//$oct4/}

#setup the correct dsp from the user input 0=pri only
if [ "$2" -eq 0 ]; then
  sed -i "/octasicPhyIp/s/=\".*\"/=\"$dspPri\"/" /home/etc/app.conf
  killall wgsPri
# obm dr -p /tftpboot/RAT_SLS.img
  obm dr -p /tftpboot/bts3000.img
  sleep 2
else
  echo "Error. Write the corect dsp number"
  exit 0
fi

echo "[ $(date -R) ] : DSP reset completed" | tee -a debug_out*

#ip of the stack (octasic)
sed -i "/octasicApiIp/s/=\".*\"/=\"$1\"/" /home/etc/app.conf

sed -i "/pppIp/s/=\".*\"/=\"$1\"/" /home/etc/app.conf

#network part of mobiles assigned ip addr random
#rand=$(( (( $RANDOM % 10 + 15 )) + (( $RANDOM % 10 )) + (( $RANDOM % 100 + 27 )) ));
#sed -i "/mobileIpBase/s/=\".*\"/=\"$rand\"/" /home/etc/app.conf

#network part of mobiles assigned as ip addr of board
sed -i "/mobileIpBase/s/=\".*\"/=\"$network\"/" /home/etc/app.conf

#listen on by address
sed -i "/listen-address/s/=.*/=$1/" /etc/dnsmasq.octbts3000.conf

#setup PN
sed -i "/pnOffset/s/=\".*\"/=\"$3\"/" /home/etc/app.conf

#setup SID
sed -i "/sid/s/=\".*\"/=\"$4\"/" /home/etc/app.conf

#setup NID
sed -i "/nid/s/=\".*\"/=\"$5\"/" /home/etc/app.conf

#setup mcc
sed -i "/mcc/s/=\".*\"/=\"$6\"/" /home/etc/app.conf

#setup band
sed -i "/band/s/=\".*\"/=\"$7\"/" /home/etc/app.conf

#setup channel
sed -i "/channel/s/=\".*\"/=\"$8\"/" /home/etc/app.conf
