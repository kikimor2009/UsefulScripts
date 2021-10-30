#!/bin/bash

cp -rf /tmp/Home_tmp/* /root/

cp -f /root/PA4devserv/libobm* /usr/lib/
rm -f /root/PA4devserv/libobm*
chmod -R 777 /usr/lib/libobm*

chmod -R 777 /root/*


#Checking the existence of Config folder and copy if need
if [ ! -d "/root/PA4devserv/Config" ]; then
  cp -r /tmp/Config /root/PA4devserv/
  #Setup ip address of the board in device_settings
  ipaddress=$(ifconfig eth0 | grep 'inet ' | awk '{print $2}' | cut -d: -f2)
  sed -i "s/boardIP/$ipaddress/g" /root/PA4devserv/Config/device_settings.xml
else
  rm -f /root/PA4devserv/Config/location_regestry.db
  cp -f /tmp/Config/empty.db /root/PA4devserv/Config/
fi

#Checking the existence of ClientConfig folder and copy if need
if [ ! -d "/home/PA4devserv/ClientConfig" ]; then
  cp -r /tmp/ClientConfig /root/PA4devserv/
else
  #Rules to copy files only if they are new in ClientConfig
  cd /root/PA4devserv/ClientConfig/
  for f in *
  do
    if [[ "$f" -ot /tmp/ClientConfig/"$f" ]]; then
      cp -f /tmp/ClientConfig/"$f" /root/PA4devserv/ClientConfig/
    fi
  done
fi

chmod -R 777 /root/*


