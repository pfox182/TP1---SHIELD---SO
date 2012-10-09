#!/bin/bash

#$1 ->Tipo de operacion
#$2 ->String del comando (parametro)

source /home/utnso/TP1---SHIELD---SO/modulos/comandos/auditoria.conf

OUTPUT_FILE="/home/utnso/output_auditoria"
CONFG_FILE="/home/utnso/TP1---SHIELD---SO/modulos/comandos/auditoria.conf"

case $1 in
	iniciar)
 		#Leer el archivo de configuracion y exportar la variable con los valores asignados
  		export COMANDOS=`cat $CONFG_FILE`
		#No se le pone exit, porque sino al llamarlo con source corta la ejecucion del script que lo llamo ( ej: nucleo.sh )
		;;


	procesar)
  		if [ -s "$OUTPUT_FILE" ]; then
	          TAMANO_ARCHIVO_LOG=`stat -c %s $OUTPUT_FILE` #Obtengo el tamaño del archivo de log local.
			if [ $TAMANO_ARCHIVO_LOG -gt $TAMANO_MAXIMO ]; then
			  echo "supero el tamaño del log local, se comenzara a loguear en el servidor remoto."
			else
		       	  echo $2 >> $OUTPUT_FILE
			fi
	        else
	         echo $2 > $OUTPUT_FILE
	        fi 
	        exit 0
	        ;;

	informacion)
  		TAMANO_ARCHIVO_LOG=`stat -c %s $OUTPUT_FILE` #Obtengo el tamaño del archivo de log local.	
		echo "Tamaño maximo del archivo local de log: $TAMANO_MAXIMO , IP del servidor remoto de 			logueo: $IP_SERVIDOR_REMOTO , tamaño del archivo de log local: $TAMANO_ARCHIVO_LOG."
		exit 0
		;;

	detener)
		unset COMANDOS
		;;

	*)
		echo "El mensaje $1 no forma parte de la interface."
		exit 1
		;;
esac





