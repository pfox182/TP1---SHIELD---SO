#!/bin/bash
function cantidad_de_procesos()
{	
	local TTY=$1
	local CANT_TOTAL=0

	PROCESS=`ps auxh | grep $USER | grep $TTY | grep -v grep | grep -v $0 | awk '{ print $1 }' | wc -l`
	CANT_TOTAL=`expr $PROCESS - 1`
	echo "$CANT_TOTAL"

	return $CANT_TOTAL
}
