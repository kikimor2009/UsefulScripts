#!/bin/bash

rm -f screenlog.0
rm -f /home/bin/goodAmpPwr.txt
#touch debug_out_"$(date -I)"_"$(date +%T)".txt

#first_start=0 #first run flag for checks
chmod 777 ./*

#echo "[ $(date -R) ] : Setup config for cdma " | tee -a debug_out*
#echo "[ $(date -R) ] : Parameters for config $1 $2 $3 $4 $5 $6 $7 $8" >> debug_out*
#./set_config.sh "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8"
#echo "[ $(date -R) ] : Config created." | tee -a debug_out*

echo "[ $(date -R) ] : Resetting gps and dsp "  # | tee -a debug_out*
if ! ./reset.sh ; then
  echo "[ $(date -R) ] : Resetting failed. Exit " # | tee -a debug_out*
  exit 1;
fi
echo "[ $(date -R) ] : Resetting completed successfully " # | tee -a debug_out*

#if [ -f "$9" ] && [ -s "$9" ]; then
#  cp "$9" ./current_imsi_targets.txt
#  if [ -n "${10}" ]; then
#    line_num=$(grep -n "${10}" current_imsi_targets.txt | cut -d: -f1)
#    target_id=$((line_num - 1))
#  fi
#else
#  echo "[ $(date -R) ] : Imsi targets file not found. Path $9 " | tee -a debug_out*
#fi

echo "[ $(date -R) ] : Starting cdma scripts" # | tee -a debug_out*
#echo "[ $(date -R) ] : screen -dmSL cdma  ./start_cdma.sh $target_id" >> debug_out*
#echo "[ $(date -R) ] : screen -dmSL cdma  start_cdma.sh " >> debug_out*
#screen -dmSL cdma  ./start_cdma.sh "$target_id"
screen -dmSL cdma  ./start_cdma_simple.sh
sleep 5

while true ; do
  IFS= read -r line
  [ -z "$line" ] && continue
  if [[ "$line" =~ [Ee]rror || "$line" =~ ERROR ]] && [[ ${line} != *"OCTASIC_API"* ]]; then
    echo "[ $(date -R) ] : There are some errors during the cdma start. Stop the cdma." | tee -a debug_out*
    echo "[ $(date -R) ] : $line " | tee -a debug_out*
    pkill -f cdma_ref
    sleep 3
    pkill -f start_cdma.sh
    pkill -f screen
    sleep 3
    echo "[ $(date -R) ] : Restart cdma" | tee -a debug_out*
    true > screenlog.0
    #echo "[ $(date -R) ] : screen -dmSL cdma  ./start_cdma.sh $target_id" >> debug_out*
    echo "[ $(date -R) ] : screen -dmSL cdma  ./start_cdma.sh " >> debug_out*
    #screen -dmSL cdma  ./start_cdma.sh "$target_id"
    screen -dmSL cdma  ./start_cdma.sh
    sleep 5
  fi

  if [[ "$line" =~ ^\/BTS3000\> ]] && [[ first_start -eq 0 ]]; then
    first_start=1
    echo "[ $(date -R) ] : Starting the cdma tower" | tee -a debug_out*
    echo on > /home/bin/rfon.txt
    sleep 3
    rm -f /home/bin/rfon.txt
  fi

  # if [[ "$line" =~ "SetAttenuation 3" ]] && [[ ${line} != *"Terminated"* ]]
  # then
  #   while true ; do
  #     echo "[ $(date -R) ] : Checking the power" | tee -a debug_out*
  #     sleep 15 #можно ли сделать меньше и стоит ли это делать ?
  #     wget "http://192.168.7.124/ukr/?PAmp=5" -O ampPower.txt
  #      power=$(grep -o 'Out.*W<' ampPower.txt | cut -d " " -f3)
  #      rm -f /home/bin/ampPower.txt
  #      if [[ "$power" =~ ^0\. ]]; then
  #        echo "[ $(date -R) ] : Not enough power. Power = ${power}. Restart" | tee -a debug_out*
  #        echo restart > /home/bin/restart.txt
  #        sleep 3
  #        rm -f /home/bin/restart.txt
  #      else
  #        echo "[ $(date -R) ] : Power ok. Power = ${power}." | tee -a debug_out*
  #        echo fine > /home/bin/normal.txt
  #        echo good > /home/bin/goodAmpPwr.txt
  #        sleep 3
  #        rm -f /home/bin/normal.txt
  #        echo "done"
  #        break
  #      fi
  #    done
  #    echo "[ $(date -R) ] : Everything is ok" | tee -a debug_out*
  #  fi
  #
  #  if [[ "$line" =~ "SetAttenuation" ]]; then
  #    echo "[ $(date -R) ] : Writing power to the file" | tee -a debug_out*
  #    sleep 5
  #    wget "http://192.168.7.124/ukr/?PAmp=5" -O init_output_pwr.txt
  #  fi
  #
  #  if [[ "$line" =~ "CDMA_L3" && "$line" =~ "Message" && "$line" =~ "User" ]]
  #  then
  #    #    echo "$line" >> test_reg_raw.txt
  #    phone=$(echo "$line" | grep -o ":[0-9]\{10\}" | cut -d ':' -f2)
  #    echo "$phone" >> reg_pri.txt
  #    esn=$(echo "$line" | grep -o "0x\w\{8\}" | cut -d 'x' -f2)
  #    if ! grep "$esn" ESN_DB.txt ; then
  #      echo "$esn" >> ESN_DB.txt
  #      echo "$esn" >> targets_esn.txt
  #    fi
  #  fi

  if [ -e "stop_mon.txt" ]; then
    echo "[ $(date -R) ] : Stop monitor." | tee -a debug_out* ;
    exit 0;
  fi;
done < screenlog.0
