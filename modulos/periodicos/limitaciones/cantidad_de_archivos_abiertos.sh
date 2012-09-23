#!/bin/bash
function cantidad_de_archivos_abiertos()
{	
	local TTY=$1
	local CANT_TOTAL=0
	local ARCHIVOS_ABIERTOS=0

	for PID in `ps auxh | grep $USER | grep $TTY | grep -v grep | grep -v $0 | awk '{ print $2 }'`
	do

		if [ -f /proc/${PID}/stat ];then
			ARCHIVOS_ABIERTOS=`file /proc/${PID}/fd/* | grep -v "/dev/$TTY" | wc -l`
			CANT_TOTAL=`expr $CANT_TOTAL + $ARCHIVOS_ABIERTOS`
		fi
		
	done

	echo "$CANT_TOTAL"

	return $CANT_TOTAL
}
