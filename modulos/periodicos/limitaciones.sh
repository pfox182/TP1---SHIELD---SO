#!/bin/bash

 

#$1 -> mensaje de la interface ("iniciar","procesar",detener"...)
function calculos_de_estados() 
{
	#Calculos de estadoS 
	CPU_ACTUAL=$(uso_de_cpu)
	if [ `echo $CPU_ACTUAL | grep -E ^[\.]` ];then #Si el resultado es .6% lo transforma en 0.6%
		CPU_ACTUAL="0$CPU_ACTUAL"
	fi	

	MEM_ACTUAL=$(uso_de_mem )
	if [ `echo $MEM_ACTUAL | grep -E ^[\.]` ];then
		MEM_ACTUAL="0$MEM_ACTUAL"
	fi

	CANT_PROCESS_ACTUAL=$(cantidad_de_procesos) #Siempre es un numero entero

	CANT_ARCHIVOS_ACTUAL=$(cantidad_de_archivos_abiertos) #Siempre es un numero entero

	CANT_SOCKETS_ACTUAL=$(cantidad_de_sockets_abiertos) #Siempre es un numero entero
	
}
#Archivos
CONF_FILE=/home/utnso/TP1---SHIELD---SO/modulos/periodicos/limitaciones/limitaciones.conf
. /home/utnso/TP1---SHIELD---SO/modulos/periodicos/limitaciones/es_mayor_que.sh #Compara numeros decimales
. /home/utnso/TP1---SHIELD---SO/modulos/periodicos/limitaciones/uso_de_cpu.sh
. /home/utnso/TP1---SHIELD---SO/modulos/periodicos/limitaciones/uso_de_mem.sh
. /home/utnso/TP1---SHIELD---SO/modulos/periodicos/limitaciones/cantidad_de_procesos.sh
. /home/utnso/TP1---SHIELD---SO/modulos/periodicos/limitaciones/cantidad_de_archivos_abiertos.sh
. /home/utnso/TP1---SHIELD---SO/modulos/periodicos/limitaciones/cantidad_de_sockets_abiertos.sh

case $1 in
	iniciar)
		  #Leer el archivo de configuracion
		  for VARIABLE in `cat $CONF_FILE`
		  do
			export $VARIABLE
		  done
		  ;;

	procesar)
		calculos_de_estados
		#Control de consumo de CPU	
			es_mayor_que $CPU_ACTUAL $MAX_CPU
			if [ $? = 0 ];then
				echo "Se sobrepaso el limite de uso del CPU: $MAX_CPU%"
				exit 1
			fi
			es_mayor_que $MEM_ACTUAL $MAX_MEM
			if [ $? = 0 ];then
				echo "Se sobrepaso el limite de uso del Memoria: $MAX_MEM%"
				exit 1
			fi
		
			if [ $CANT_PROCESS_ACTUAL -ge $MAX_PROCES ];then
				echo "Se sobrepaso el limite de la cantidad de procesos abiertos: $MAX_PROCES"
				exit 1
			fi
		
			if [ $CANT_ARCHIVOS_ACTUAL -ge $MAX_SOCK ];then
				echo "Se sobrepaso el limite de la cantidad de archivos abiertos: $MAX_OPEN_FILES"
				exit 1
			fi

			if [ $CANT_SOCKETS_ACTUAL -ge $MAX_SOCK ];then
				echo "Se sobrepaso el limite de la cantidad de sockets abiertos: $MAX_SOCK"
				exit 1
			fi
		
			exit 0 #Si no se sobrepaso ningun limite sale con 0
			;;

	informacion)
		calculos_de_estados
		#Informar por pantalla
		echo "Limite de la CPU: $MAX_CPU% , valor actual: $CPU_ACTUAL%."
		echo "Limite de la Memoria: $MAX_MEM% , valor actual: $MEM_ACTUAL%."
		echo "Limite de la cantidad de procesos: $MAX_PROCES , valor actual: $CANT_PROCESS_ACTUAL."
		echo "Limite de la cantidad de archivos: $MAX_OPEN_FILES , valor actual: $CANT_ARCHIVOS_ACTUAL."
		echo "Limite de la cantidad de archivos: $MAX_SOCK , valor actual: $CANT_SOCKETS_ACTUAL."
	
		exit 0
		;;
	detener)
		unset MAX_CPU
		unset MAX_MEM
		unset MAX_PROCES
		unset MAX_SOCK
		unset MAX_SOCK
		;;

	*)
		echo "El mensaje $1 no forma parte de la interface."
		exit 1
		;;
esac

