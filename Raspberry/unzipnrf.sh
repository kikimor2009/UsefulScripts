#!/usr/bin/env bash

mv -f /tmp/rc.local /etc/
chmod 755 /etc/rc.local
chown root:root /etc/rc.local

rm -rf /home/pi/nrfscan
unzip -uo /tmp/nrfscan.zip -d /home/pi/
chmod -R 777 /home/pi/nrfscan
rm -rf /home/pi/__MACOSX
