#!/bin/bash
function uso_de_cpu()
{	
	local TTY=$1
	local CPU_TOTAL=0.0

	for PROCESS_CPU in `ps auxh | grep $USER | grep $TTY |grep -v grep | awk '{ print $3 }'` 
	do
		CPU_TOTAL=`echo $CPU_TOTAL + $PROCESS_CPU | bc`
	done
	local SEPARACION=`expr index "$CPU_TOTAL" "."`
	local SEPARACION=`expr $SEPARACION - 1`
	typeset -i CPU_APROX=`echo ${CPU_TOTAL:0:$SEPARACION}`
	
	return $CPU_APROX
}

