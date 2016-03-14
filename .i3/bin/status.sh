#!/bin/sh
# shell script to prepend i3status with more stuff



getFreeMem(){
 free=vmstat | sed -n '$ p' | awk '{print $5/1024/1024}'

}


i3status | while :
do
        read line
	free=$(vmstat -h | sed -n '$ p' | awk '{$5; print( $5)}')
	arc=$(sysctl -n kstat.zfs.misc.arcstats.size  | awk '{printf("%.0i\n", $1/1024^2)}')
	network_in=$(netstat -bh -f link -Iem0 | sed -n '$ p' | awk '{print($8)}')
        network_out=$(netstat -bh -f link -Iem0 | sed -n '$ p' | awk '{print($11)}')
	temp=$(sysctl -n dev.cpu.4.temperature | awk '{print($1)}' )
	echo "FreeMem: $free | ARC: $arc MB | Up/Down: $network_out/$network_in | Temp: $temp |$line" || exit 1
done
