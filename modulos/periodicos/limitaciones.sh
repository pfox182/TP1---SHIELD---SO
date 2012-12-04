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
CONF_FILE=/home/$USER/.shield/modulos/periodicos/limitaciones.conf
#Son las funciones que utiliza para los calculos
. $CARPETA_DE_INSTALACION/modulos/periodicos/limitaciones/es_mayor_que.sh #Compara numeros decimales
. $CARPETA_DE_INSTALACION/modulos/periodicos/limitaciones/uso_de_cpu.sh
. $CARPETA_DE_INSTALACION/modulos/periodicos/limitaciones/uso_de_mem.sh
. $CARPETA_DE_INSTALACION/modulos/periodicos/limitaciones/cantidad_de_procesos.sh
. $CARPETA_DE_INSTALACION/modulos/periodicos/limitaciones/cantidad_de_archivos_abiertos.sh
. $CARPETA_DE_INSTALACION/modulos/periodicos/limitaciones/cantidad_de_sockets_abiertos.sh

case $1 in
	"") #Mensaje vacio
		;;
	iniciar)
		 #Leer el archivo de configuracion
		 if ( test -e $CONF_FILE );then #Me aseguro de que exista
			  for VARIABLE in `cat $CONF_FILE`
			  do
				export $VARIABLE
			  done
		 else
			echo "El archivo de configuracion $CONF_FILE de limitaciones.sh no existe"
			exit 1
		 fi
		 ;;

	procesar)
		calculos_de_estados
			if [ $CANT_SOCKETS_ACTUAL -ge $MAX_SOCK ];then
				echo "Se sobrepaso el limite de la cantidad de sockets abiertos: $MAX_SOCK"
				exit 1
			fi
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
		
			if [ $CANT_ARCHIVOS_ACTUAL -ge $MAX_OPEN_FILES ];then
				echo "Se sobrepaso el limite de la cantidad de archivos abiertos: $MAX_OPEN_FILES, la cantidad abierta es $CANT_ARCHIVOS_ACTUAL"
				exit 1
			fi

			;;

	informacion)
		calculos_de_estados
		#Informar por pantalla
		echo "Limite de la CPU: $MAX_CPU% , valor actual: $CPU_ACTUAL%."
		echo "Limite de la Memoria: $MAX_MEM% , valor actual: $MEM_ACTUAL%."
		echo "Limite de la cantidad de procesos: $MAX_PROCES , valor actual: $CANT_PROCESS_ACTUAL."
		echo "Limite de la cantidad de archivos: $MAX_OPEN_FILES , valor actual: $CANT_ARCHIVOS_ACTUAL."
		echo "Limite de la cantidad de sockets: $MAX_SOCK , valor actual: $CANT_SOCKETS_ACTUAL."
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

