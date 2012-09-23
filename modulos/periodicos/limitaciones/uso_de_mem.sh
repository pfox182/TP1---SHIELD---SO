#!/bin/bash
function uso_de_mem()
{	
	local TTY=$1
	local MEM_TOTAL=0.0

	for PROCESS_MEM in `ps auxh | grep $USER | grep $TTY |grep -v grep | awk '{ print $4 }'` 
	do
		MEM_TOTAL=`echo $MEM_TOTAL + $PROCESS_MEM | bc`
	done
	local SEPARACION=`expr index "$MEM_TOTAL" "."`
	local SEPARACION=`expr $SEPARACION - 1`
	typeset -i CPU_APROX=`echo ${MEM_TOTAL:0:$SEPARACION}`
	
	echo "$MEM_TOTAL"

	return $MEM_APROX
}

