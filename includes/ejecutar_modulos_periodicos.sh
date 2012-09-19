#!/bin/bash
# $1 -> $TIEMPO_MODULOS_PERIODICOS
# $2 -> $TERMINAL_DE_LA_SESSION (me indica cual va a ser la sesion afectada por los modulos periodicos)

#Variables
TERMINAL_DE_LA_SESSION=$2
TTY=${TERMINAL_DE_LA_SESSION:5:9} #Le saco /dev/ para que quede solo la terminal

function enviar_senial()
{
	PID_NUCLEO=`ps auxh | grep nucleo.sh | grep $1 | grep -v grep | awk '{ print $2 }'`
	kill -USR1 $PID_NUCLEO	
}



RUTA_DE_MODULOS_PERIODICOS=/home/utnso/TP1---SHIELD---SO/modulos/periodicos/*.sh
while ( sleep $1 );do
	for MODULO in `ls $RUTA_DE_MODULOS_PERIODICOS`
	do		
		bash $MODULO procesar $TTY
		if [ $? -ne 0 ] ;then
			enviar_senial $TTY
			exit 1
		fi
	done
		
done


	
	
