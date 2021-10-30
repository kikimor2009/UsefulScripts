#!/usr/bin/env bash

#getting ips to setup
ip=$(sed -n 1p /tmp/Scripts/ipconf.txt)
chmod 755 /etc/network/interfaces
sed -i "s/address.*/$ip/" /etc/network/interfaces

gt=$(sed -n 4p /tmp/Scripts/ipconf.txt)
sed -i "s/gateway.*/$gt/" /etc/network/interfaces

#setup antennas
obm cw
chmod 755 /etc/obmd.properties

dsp0=$(sed -n 2p /tmp/Scripts/ipconf.txt)
sed -i "3s/.*/$dsp0/" /etc/obmd.properties

dsp1=$(sed -n 3p /tmp/Scripts/ipconf.txt)
sed -i "6s/.*/$dsp1/" /etc/obmd.properties

#cp octdfserver
cp /tmp/Files/octdfserv/octdfserver_pri /home
chmod 755 /home/octdfserver_pri
cp /tmp/Files/octdfserv/octdfserver_sec /home
chmod 755 /home/octdfserver_sec
cp /tmp/Files/octdfserv/octdfserver_rus.img /tftpboot
chmod 755 /tftpboot/octdfserver_rus.img

#detecting projectID and copy specific files
prID=$(obm bi | grep "ProjectId" | awk '{print $4}' | tr -d "\n")

if [ -d "/tmp/Files/$prID" ]; then
  cp -f /tmp/Files/$prID/octdfse* /tftpboot
  chmod 755 /tftpboot/octdfserver_rus.img
fi

#cp libs
cp /tmp/Files/lib/* /usr/lib
chmod 755 /usr/lib/libobmapi.so
chmod 755 /usr/lib/librus_controller.so

#change rc.local
cp -f /tmp/Files/rc.local /etc/
chmod 777 /etc/rc.local
chown root:root /etc/rc.local
