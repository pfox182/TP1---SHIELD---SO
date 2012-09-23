#!/bin/bash
# $1 -> $TIEMPO_MODULOS_PERIODICOS


function enviar_senial()
{
	PID_NUCLEO=`ps auxh | grep nucleo.sh | grep $TTY | grep -v grep | awk '{ print $2 }'`
	kill -USR1 $PID_NUCLEO	
}



RUTA_DE_MODULOS_PERIODICOS=/home/utnso/TP1---SHIELD---SO/modulos/periodicos/*.sh
while ( sleep $1 );do
	for MODULO in `ls $RUTA_DE_MODULOS_PERIODICOS`
	do		
		bash $MODULO procesar
		if [ $? -ne 0 ] ;then
			enviar_senial
			exit 1
		fi
	done
		
done


	
	
