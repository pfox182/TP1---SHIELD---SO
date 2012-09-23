#!/bin/bash

MAX_CPU=20;MAX_MEM=10;MAX_PROCES=10;MAX_SOCK=2;MAX_OPEN_FILES=10;

#$1 -> mensaje de la interface ("iniciar","procesar",detener"...)

#Archivos
CONF_FILE=/home/utnso/TP1---SHIELD---SO/modulos/periodicos/limitaciones/limitaciones.conf
. /home/utnso/TP1---SHIELD---SO/modulos/periodicos/limitaciones/es_mayor_que.sh #Compara numeros decimales
. /home/utnso/TP1---SHIELD---SO/modulos/periodicos/limitaciones/uso_de_cpu.sh
. /home/utnso/TP1---SHIELD---SO/modulos/periodicos/limitaciones/uso_de_mem.sh
. /home/utnso/TP1---SHIELD---SO/modulos/periodicos/limitaciones/cantidad_de_procesos.sh
. /home/utnso/TP1---SHIELD---SO/modulos/periodicos/limitaciones/cantidad_de_archivos_abiertos.sh
. /home/utnso/TP1---SHIELD---SO/modulos/periodicos/limitaciones/cantidad_de_sockets_abiertos.sh

if [ ! $1 ];then
	echo "Error, no cumple la interface de los modulos (parametro vacio en limitaciones.sh)."
	exit 1
fi

if [ $1 = "iniciar" ];then
  #Leer el archivo de configuracion
  VARIABLES_DEL_ARCHIVO=`cat $CONF_FILE`
  
  sed -e "3s/.*/`echo $VARIABLES_DEL_ARCHIVO`/g" $0 > $0.tmp;mv -f $0.tmp $0
	#sed -e "3s/.*/`echo "COMANDOS="$COMANDOS_DEL_ARCHIVO`/g" $0 ->Sustituye la linea 3 del archivo limitaciones.sh($0) y lo muestra por pantalla
	#> $0.tmp;mv $0.tmp $0 ->Captura la salida del comando anterior y lo guarda en un archivo temporal, que luego reescribe el script limitaciones.sh
  exit $?
fi

if [ "$1" = "detener" ];then
	
	sed -e "3s/.*/ /g" $0 > $0.tmp;mv -f $0.tmp $0 #Borra la linea 3
	exit $?
fi

#Calculos de estadoS (Como el mensaje no fue iniciar o detener, voy a nececitar los estados)
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

if [ "$1" = "procesar" ];then
	#Control de consumo de CPU	
		es_mayor_que $CPU_ACTUAL $MAX_CPU
		if [ $? = 0 ];then
			echo "Se sobrepaso el limite de uso del CPU: $MAX_CPU%"
			exit 1
		fi
		es_mayor_que $CPU_ACTUAL $MAX_CPU
		if [ $? = 0 ];then
			echo "Se sobrepaso el limite de uso del Memoria: $MAX_MEM%"
			exit 1
		fi
		
		if [ $CANT_PROCESS_ACTUAL -ge $MAX_PROCES ];then
			echo "Se sobrepaso el limite de la cantidad de procesos abiertos: $MAX_PROCES"
			exit 1
		fi
		
		if [ $CANT_ARCHIVOS_ACTUAL -ge $MAX_OPEN_FILES ];then
			echo "Se sobrepaso el limite de la cantidad de archivos abiertos: $MAX_OPEN_FILES"
			exit 1
		fi

		if [ $CANT_SOCKETS_ACTUAL -ge $MAX_SOCK ];then
			echo "Se sobrepaso el limite de la cantidad de sockets abiertos: $MAX_SOCK"
			exit 1
		fi
		
		exit 0
fi

if [ "$1" = "informacion" ];then
	#Informar por pantalla
	echo "Limite de la CPU: $MAX_CPU% , valor actual: $CPU_ACTUAL%."
	echo "Limite de la Memoria: $MAX_MEM% , valor actual: $MEM_ACTUAL%."
	echo "Limite de la cantidad de procesos: $MAX_PROCES , valor actual: $CANT_PROCESS_ACTUAL."
	echo "Limite de la cantidad de archivos: $MAX_OPEN_FILES , valor actual: $CANT_ARCHIVOS_ACTUAL."
	echo "Limite de la cantidad de archivos: $MAX_SOCK , valor actual: $CANT_SOCKETS_ACTUAL."
	
	exit 0
fi

exit 0
