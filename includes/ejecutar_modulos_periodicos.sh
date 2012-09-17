#!/bin/bash
# $1 -> $TIEMPO_MODULOS_PERIODICOS

function terminar_sesion()
{
	USER=`whoami`
	for PID in `ps auxh | grep $USER | grep -v grep | awk '{ print $2 }'`
	do
		kill -15 $PID
	done
}
RUTA_DE_MODULOS_PERIODICOS=/home/utnso/TP1---SHIELD---SO/modulos/periodicos/*.sh
while ( sleep $1 );do
	for MODULO in `ls $RUTA_DE_MODULOS_PERIODICOS`
	do		
		bash $MODULO procesar
		if [ $? -ne 0 ] ;then			
			echo "SE PUDRIO TODO"
			terminar_sesion
		fi
	done
		
done

	
	
