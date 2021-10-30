#!/bin/bash

echo "radio/rfoff" >> simple_inst.txt
echo "exit" >> simple_inst.txt
sleep 10
pkill -f cdma_ref
sleep 1
pkill pppd
pkill l2tp
sleep 1
pkill -f simple_start_cdma.sh
sleep 1
echo stop > /home/bin/stop_mon.txt
sleep 2
pkill -f simple_monitor.sh
rm -f /home/bin/commands.txt
rm -f /home/bin/stop_mon.txt
rm -f /home/bin/restart.txt
rm -f /home/bin/normal.txt
rm -f /home/bin/reg_pri.txt
rm -f /home/bin/reg_sec.txt
rm -f /home/bin/AttPw.txt
rm -f /home/bin/targets_esn.txt
true > /home/bin/ESN_DB.txt
obm dr -p /tftpboot/bts3000.img

#echo "[ $(date -R) ] : Stop cdma script." | tee -a debug_out* ;
mv debug_out* ./logs/

#cd logs || exit

#if [[ $(find . -mtime +30) ]]; then
#  echo "File exists and is older than 30 days"
#  rm -f "$(ls -t | tail -1)"
#fi
#sleep 10
