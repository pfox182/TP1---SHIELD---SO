#!/bin/bash
function cantidad_de_sockets_abiertos()
{	
	local CANT_TOTAL=0
	local SOCKETS_ABIERTOS=0

	for PID in `ps auxh | grep $USER | grep $TTY | grep -v grep | awk '{ print $2 }'`
	do
		if [ -f /proc/${PID}/stat ];then
			typeset -i SOCKETS_ABIERTOS=`file /proc/${PID}/fd/* | grep -v "/dev/$TTY" | grep -E "socket:\[.*\]" | wc -l`
			CANT_TOTAL=`expr $CANT_TOTAL + $SOCKETS_ABIERTOS`
		fi
	done

	echo "$CANT_TOTAL"

	return $CANT_TOTAL
}
