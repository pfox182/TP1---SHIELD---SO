#!/bin/bash
# $1 -> $TIEMPO_MODULOS_PERIODICOS


function enviar_senial()
{
	PID_NUCLEO=`ps auxh | grep nucleo.sh | grep $TTY | grep -v grep | awk '{ print $2 }'`
	kill -USR1 $PID_NUCLEO	
}

while ( sleep $1 );do
	for MODULO in `cat $MODULOS_PERIODICOS`
	do	
		#Me fijo si esta activo
		local SEPARACION=`expr index "$MODULO" ":"`
		local MODULO_ACTIVO="${MODULO:$SEPARACION}"
		SEPARACION=`expr $SEPARACION - 1` #Retrocedo 1 para saltar el ":"
		MODULO="${MODULO:0:$SEPARACION}"

		if [ "$MODULO_ACTIVO" = "on" ];then #Si esta activo	
			bash $MODULO procesar
			if [ $? -ne 0 ] ;then
				enviar_senial
				exit 1
			fi
		fi
	done
		
done


	
	
