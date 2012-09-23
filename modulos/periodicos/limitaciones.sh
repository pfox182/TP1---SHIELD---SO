#!/bin/bash

MAX_CPU=20;MAX_MEM=10;MAX_PROCES=10;MAX_SOCK=2;MAX_OPEN_FILES=10;

#$1 -> mensaje de la interface ("iniciar","procesar",detener"...)
#$2 -> la terminal donde se encuentra logeado el usuario

#Archivos
CONF_FILE=/home/utnso/TP1---SHIELD---SO/modulos/periodicos/limitaciones/limitaciones.conf
. /home/utnso/TP1---SHIELD---SO/modulos/periodicos/limitaciones/es_mayor_que.sh #Compara numeros decimales
. /home/utnso/TP1---SHIELD---SO/modulos/periodicos/limitaciones/uso_de_cpu.sh
. /home/utnso/TP1---SHIELD---SO/modulos/periodicos/limitaciones/uso_de_mem.sh
. /home/utnso/TP1---SHIELD---SO/modulos/periodicos/limitaciones/cantidad_de_procesos.sh

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
  exit 0
fi

#Calculos de estadoS (Como el mensaje no fue iniciar, voy a nececitar los estados)
CPU_ACTUAL=$(uso_de_cpu $2)
	if [ `echo $CPU_ACTUAL | grep -E ^[\.]` ];then #Si el resultado es .6% lo transforma en 0.6%
		CPU_ACTUAL="0$CPU_ACTUAL"
	fi	

MEM_ACTUAL=$(uso_de_mem $2)
	if [ `echo $MEM_ACTUAL | grep -E ^[\.]` ];then
		MEM_ACTUAL="0$MEM_ACTUAL"
	fi

CANT_PROCESS_ACTUAL=$(cantidad_de_procesos $2) #Siempre es un numero entero

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
fi

if [ "$1" = "informacion" ];then
	#Informar por pantalla
	echo "Limite de la CPU: $MAX_CPU% , valor actual: $CPU_ACTUAL%."
	echo "Limite de la Memoria: $MAX_MEM% , valor actual: $MEM_ACTUAL%."
	echo "Limite de la cantidad de procesos: $MAX_PROCES , valor actual: $CANT_PROCESS_ACTUAL."
fi

exit 0
