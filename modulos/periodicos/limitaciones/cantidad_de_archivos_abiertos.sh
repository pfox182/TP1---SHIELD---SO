#!/bin/bash
function cantidad_de_archivos_abiertos()
{	
	local CANT_TOTAL=0
	local ARCHIVOS_ABIERTOS=0

	for PID in `ps auxh | grep $USER | grep $TTY | grep -v grep | awk '{ print $2 }'`
	do
		#Si el proceso no existe lfof devuelve 0
		ARCHIVOS_ABIERTOS=`lsof -p $PID | wc -l`
		CANT_TOTAL=`expr $CANT_TOTAL + $ARCHIVOS_ABIERTOS`
	done

	echo "$CANT_TOTAL"

	return $CANT_TOTAL
}
