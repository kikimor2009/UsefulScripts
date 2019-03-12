#!/bin/bash

echo -en "Enter the number for wifi configuration and press [ENTER].\n\t0 for 2.4 GHZ\n\t1 for 5 GHZ.\n"
read flag

if [ -z "$flag" ]; then
	echo -e "Error! You haven't entered anything."
    exit
elif [ $flag -eq 0 ]; then
	flag=$1
	echo "Uaptl 2.4 GHZ configuration will be used for wifi"
elif [ $flag -eq 1 ]; then
	flag=$1
	echo "Uaptl 5 GHZ configuration will be used for wifi"
else
	echo -e "Error! You have entered the wrong number.\nStart the script again with correct value."
    exit

fi
