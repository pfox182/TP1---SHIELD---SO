#!/bin/bash

. /home/utnso/TP1---SHIELD---SO/modulos/periodicos/control_carga.conf

case "$1" in 
	"procesar") 
		LINE=$(ps auxh | sort -rk3 | head -1)  
		ID_PROCESO=$(echo $LINE | awk '{print $2}')
		CONSUMO_CPU_PROCESO=$(echo "$(echo $LINE | awk '{print $3}') * 10" | bc | cut -f1 -d'.')
		NICE_PROCESO=$(ps -Al | grep -m 1 $ID_PROCESO | awk '{print $8}')
			if [ $CONSUMO_CPU_PROCESO -ge $MAX_CONSUMO_CPU ];then
				#Aumento el nice de ID_PROCESO
				renice +$(expr $NICE_PROCESO + 5) $ID_PROCESO > null
				#comparo con el proceso anterior para ver si es el mismo o si reseteo la cantidad de nice
				if [[ $ID_PROCESO = $ID_PROCESO_ANTERIOR ]];then
					CANT_NICE=$(expr $CANT_NICE + 1)
				else	
					CANT_NICE=1
				fi
				#si aumento mas de cuatro veces el nice de un proceso en forma continua lo elimino
				if [ $CANT_NICE -eq 4 ];then
					kill -9 $ID_PROCESO
					echo "Se elimino al proceso $ID_PROCESO del sistema"
				fi			
				ID_PROCESO_ANTERIOR=$ID_PROCESO
			fi;;
	"informacion")
		echo "El maximo consumo de CPU es:$MAX_CONSUMO_CPU"
		if [[ $CANT_NICE -ne 4 && $CANT_NICE != "" ]];then
		echo "Proceso $ID_PROCESO su nice es:$NICE_PROCESO y la cantidad de incrementos del nice es:$CANT_NICE"
		fi;;


	"iniciar")

		;;


	"detener")
		unset MAX_CONSUMO_CPU;;
esac

