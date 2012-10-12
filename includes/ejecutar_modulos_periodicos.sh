#!/bin/bash
# $1 -> $TIEMPO_MODULOS_PERIODICOS


function enviar_senial()
{
	PID_NUCLEO=`ps auxh | grep shield.sh | grep $TTY | grep -v grep | awk '{ print $2 }'`
	kill -USR1 $PID_NUCLEO	
}

while ( sleep $1 );do
	for MODULO in `cat $MODULOS_PERIODICOS`
	do	
		#Me fijo si esta activo
		MODULO_ACTIVO=`echo $MODULO | cut  -d ":" -f 2`
		MODULO=`echo $MODULO | cut  -d ":" -f 1`

		if [ "$MODULO_ACTIVO" = "on" ];then #Si esta activo	
			bash $MODULO procesar
			if [ $? -ne 0 ] ;then
				enviar_senial
				exit 1
			fi
		fi
	done
		
done


	
	
