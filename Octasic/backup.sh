#!/usr/bin/env bash

dir=`ifconfig eth0 | grep 'HWaddr' | awk '{print $5}' | cut -c 7-`

mkdir /home/$dir
cd /home/$dir

cp /etc/TxAttenuationTable.csv .
cp  /home/wgs/scripts/setTREX.bin .

obm di > obmdi.txt
obm di -s > obmdi-s.txt
ifconfig > ifconfig.txt
obm bi > obmbi.txt
obm in > obmin.txt

chmod 755 *

tar -cf $dir'.tar' *
chmod 777 $dir'.tar'
