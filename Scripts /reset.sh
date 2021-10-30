#!/bin/bash

#gps_rst.sh on
#sleep 5
#gps_rst.sh off
#dsp_rst.sh on
#sleep 10
#dsp_rst.sh off
#obm dr
#sleep 5

is_gps_executed () {
        for i in {1..5}; do
                if obm gr; then
			echo "obm gr has executed OK"
                        return 0
                fi
		echo "sleep $(( i * 5 ))"
                sleep $(( i * 5 ))
        done
	echo "obm gr has Failed"
        return 1 
}

is_obm_executed () {
        for i in {1..5}; do
                if obm dr; then
			echo "obm dr has executed OK"
                        return 0
                fi
		echo "sleep $(( i * 5 ))"
                sleep $(( i * 5 ))
		obm dr -p /tftpboot/bts3000.img
		sleep 1
        done
	echo "obm dr has Failed"
        return 1 
}

is_gps_executed || exit 1
sleep 2
ref_clk_mux.sh gps
./pumpgps
if [ $? -ne 0 ] ; then exit 1; fi
is_obm_executed || exit 1