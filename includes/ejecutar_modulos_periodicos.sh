#!/bin/bash
# $1 -> $TIEMPO_MODULOS_PERIODICOS


function enviar_senial()
{
	
	PID_NUCLEO=`ps aux | grep $SHIELD | grep $TTY | grep -v grep | awk '{ print $2 }'`
	echo "El PID que encontre es $PID_NUCLEO,SHIELD es $SHIELD"
	
	kill -USR1 $PID_NUCLEO	
}

function matar_todo()
{
	for pid in `ps aux | grep $TTY | grep -v ejecutar_modulos_periodicos.sh | grep -vE 'bash$' | grep -v grep | awk '{ print $2 }'`
	do
		if [ -f /proc/${pid}/stat ]; then
			kill -n 9 $pid
		fi
	done
	echo "El programa ha finalizado."
	return 0
}
function terminar_shield()
{
	PID_ACTUALIZACION_CONFIG=`ps aux | grep $TTY | grep verificar_cambios_archivos_de_configuracion.sh | grep -v grep | awk '{ print $2 }'`
	if [ -f /proc/${PID_ACTUALIZACION_CONFIG}/stat ]; then
		kill -n 9 $PID_ACTUALIZACION_CONFIG
		echo "config, $PID_ACTUALIZACION_CONFIG"
	fi
	PID_SHIELD=`ps aux | grep $TTY | grep $SHIELD | grep -v grep | awk '{ print $2 }'`
	if [ -f /proc/${PID_SHIELD}/stat ]; then
		kill -n 9 $PID_SHIELD
		echo "shield, $PID_SHIELD"
	fi		
	echo "El programa ha finalizado."
	return 0
}

while ( sleep $1 );do
	if ( test -e $MODULOS_PERIODICOS );then
		for MODULO in `cat $MODULOS_PERIODICOS`
		do	
			#Me fijo si esta activo
			MODULO_ACTIVO=`echo $MODULO | cut  -d ":" -f 2`
			MODULO=`echo $MODULO | cut  -d ":" -f 1`

			if [ "$MODULO_ACTIVO" = "on" ];then #Si esta activo
				if ( test -z `echo $MODULO | grep control_carga` );then	
					bash $MODULO procesar
					if [ $? -ne 0 ] ;then
						MSJ_ERR="Error al procesar el modulo $MODULO"
						echo "$MSJ_ERR -> guardado en $LOG_ERR_FILE"
						if ( test -w $LOG_ERR_FILE );then		
							echo "$MSJ_ERR">> $LOG_ERR_FILE
						else
							echo "Error al guardar en $LOG_ERR_FILE , el archivo no existe o no se tiene permisos de escritura"
						fi
						#enviar_senial
						matar_todo
						exit 1
					fi
				else
					source $MODULO procesar
					if [ $? -ne 0 ] ;then
						MSJ_ERR="Error al procesar el modulo $MODULO"
						echo "$MSJ_ERR -> guardado en $LOG_ERR_FILE"
						if ( test -w $LOG_ERR_FILE );then		
							echo "$MSJ_ERR">> $LOG_ERR_FILE
						else
							echo "Error al guardar en $LOG_ERR_FILE , el archivo no existe o no se tiene permisos de escritura"
						fi
						#enviar_senial
						matar_todo
						exit 1
					fi
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
		matar_todo
		exit 1
	fi
		
done


	
	
