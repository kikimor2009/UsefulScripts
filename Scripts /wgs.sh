#!/bin/bash

kill -9 "$(pgrep wgsPri)"
kill -9 "$(pgrep wgsSec)"

cp -R /tmp/Files/wgs /home/
chmod -R 0777 /home

#MACs of devices
obi=$(obm bi | grep "MAC" | awk '{print $6}' | tr -d "\n" | sed 's/:/ /g')
odi=$(obm di | grep "Mac" | awk '{print $5}' | tr -d "\n" | sed 's/:/ /g')
odis=$(obm di -s | grep "Mac" | awk '{print $5}' | tr -d "\n" | sed 's/:/ /g')


#writing MACs to the files
sed -i "s/obm_bi_mac/$obi/" /home/wgs/bin-pri/l1c_cfg_parm.txt
sed -i "s/obm_di_mac/$odi/" /home/wgs/bin-pri/l1c_cfg_parm.txt

sed -i "s/obm_bi_mac/$obi/" /home/wgs/bin-sec/l1c_cfg_parm.txt
sed -i "s/obm_di_s_mac/$odis/" /home/wgs/bin-sec/l1c_cfg_parm.txt

#detecting board
if (obm bi | grep "| Model" | grep "3500"); then
  model=3500
else
  model=9100
fi

#detecting projectID and copy specific files
prID=$(obm bi | grep "ProjectId" | awk '{print $4}' | tr -d "\n")

cp -f /tmp/Files/"$model"/"$prID"/oct* /home/wgs/
chmod -R 0777 /home

#copying new images to the tftpboot folder
cd /tftpboot || exit
rm -rf ./*
cp -f /tmp/Files/"$model"/"$prID"/images/* .
chmod -R 0777 /tftpboot


#copying new rc.local, rsyslog in etc
cp -f /tmp/Files/config/* /etc/
chmod -R 0777 /etc/rc.local
