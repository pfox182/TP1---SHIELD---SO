#!/bin/bash

MAX_CPU=10;MAX_MEM=40;MAX_PROCES=10;MAX_SOCK=2;MAX_OPEN_FILES=10;

#$1 -> mensaje de la interface ("iniciar","procesar",detener"...)
#$2 -> la terminal donde se encuentra logeado el usuario

#Archivos
CONF_FILE=/home/utnso/TP1---SHIELD---SO/modulos/periodicos/limitaciones/limitaciones.conf
. /home/utnso/TP1---SHIELD---SO/modulos/periodicos/limitaciones/uso_de_cpu.sh

if [ ! $1 ];then
	echo "Error, no cumple la interface de los modulos (parametro vacio en limitaciones.sh)."
	exit 1
fi

if [ $1 = "iniciar" ];then
  #Leer el archivo de configuracion
  VARIABLES_DEL_ARCHIVO=`cat $CONF_FILE`
  
  sed -e "3s/.*/`echo $VARIABLES_DEL_ARCHIVO`/g" $0 > $0.tmp;mv $0.tmp $0
	#sed -e "3s/.*/`echo "COMANDOS="$COMANDOS_DEL_ARCHIVO`/g" $0 ->Sustituye la linea 3 del archivo limitaciones.sh($0) y lo muestra por pantalla
	#> $0.tmp;mv $0.tmp $0 ->Captura la salida del comando anterior y lo guarda en un archivo temporal, que luego reescribe el script limitaciones.sh
  exit 0
fi


if [ "$1" = "procesar" ];then
	#Control de consumo de CPU	
		uso_de_cpu $2
		CPU_ACTUAL=$?
		if [ $CPU_ACTUAL -ge $MAX_CPU ];then
			echo "Se sobrepaso el limite de uso del CPU: $MAX_CPU%"
			exit 1
		fi
fi

if [ "$1" = "informacion" ];then
	#Calculos de estado actual
	uso_de_cpu $2	
	CPU_ACTUAL=$?
	
	echo "Limite de la CPU: $MAX_CPU% , valor actual: $CPU_ACTUAL%."

fi

exit 0
