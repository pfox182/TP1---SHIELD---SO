#!/bin/bash
# $1 -> $TIEMPO_MODULOS_PERIODICOS


function enviar_senial()
{
	PID_NUCLEO=`ps auxh | grep $SHIELD | grep $TTY | grep -v grep | awk '{ print $2 }'`
	kill -USR1 $PID_NUCLEO	
}

while ( sleep $1 );do
	if ( test -e $MODULOS_PERIODICOS );then
		for MODULO in `cat $MODULOS_PERIODICOS`
		do	
			#Me fijo si esta activo
			MODULO_ACTIVO=`echo $MODULO | cut  -d ":" -f 2`
			MODULO=`echo $MODULO | cut  -d ":" -f 1`

			if [ "$MODULO_ACTIVO" = "on" ];then #Si esta activo	
				source $MODULO procesar
				if [ $? -ne 0 ] ;then
					MSJ_ERR="Error al procesar el modulo $MODULO"
					echo "$MSJ_ERR -> guardado en $LOG_ERR_FILE"
					if ( test -w $LOG_ERR_FILE );then		
						echo "$MSJ_ERR">> $LOG_ERR_FILE
					else
						echo "Error al guardar en $LOG_ERR_FILE , el archivo no existe o no se tiene permisos de escritura"
					fi
					enviar_senial
					exit 1
				fi
			fi
		done
	else
		MSJ_ERR="No existe el archivo $MODULOS_PERIODICOS"
		echo "$MSJ_ERR -> guardado en $LOG_ERR_FILE"
		if ( test -w $LOG_ERR_FILE );then		
			echo "$MSJ_ERR">> $LOG_ERR_FILE
		else
			echo "Error al guardar en $LOG_ERR_FILE , el archivo no existe o no se tiene permisos de escritura"
		fi
		enviar_senial
		exit 1
	fi
		
done


	
	
