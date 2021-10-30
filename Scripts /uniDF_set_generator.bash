#!/usr/bin/env bash

if [[ -z "$1" ]]; then echo "Write the correct ip address"; exit 1; fi

oct4=$(echo $1 | tr "." " " | awk '{ print $4 }') #4 octet of main ip address

#L = left; R = right
#Pr = primary; Sec = secondary

#all Ips for left device
mainIpL=$1
dspPrL=$(echo $1 | sed "s/\(.*\)\..*/\1.$((oct4 + 1))/")
dspSecL=$(echo $1 | sed "s/\(.*\)\..*/\1.$((oct4 + 2))/")

sh ./ipset.sh $mainIpL $dspPrL $dspSecL $mainIpL"_left" #upd zip folder for left device

#all Ips for right device$
mainIpR=$(echo $1 | sed "s/\(.*\)\..*/\1.$((oct4 + 5))/")
dspPrR=$(echo $1 | sed "s/\(.*\)\..*/\1.$((oct4 + 6))/")
dspSecR=$(echo $1 | sed "s/\(.*\)\..*/\1.$((oct4 + 7))/")

sh ./ipset.sh $mainIpR $dspPrR $dspSecR $mainIpR"_right" #upd zip folder for right device
