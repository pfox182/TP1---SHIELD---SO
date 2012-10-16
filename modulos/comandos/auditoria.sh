#!/bin/bash

#$1 ->Tipo de operacion
#$2 ->String del comando (parametro)


OUTPUT_FILE="/home/$USER/.shield/output_auditoria"
CONFG_FILE="/home/$USER/.shield/modulos/comandos/auditoria.conf"

case $1 in
	"") #Mensaje vacio
		;;
	iniciar)
 		#Leer el archivo de configuracion
		for VARIABLE in `cat $CONFG_FILE`
		do
			export $VARIABLE
		done
		#No se le pone exit, porque sino al llamarlo con source corta la ejecucion del script que lo llamo ( ej: nucleo.sh )
		;;


	procesar)
  		if [ -s "$OUTPUT_FILE" ]; then
	          TAMANO_ARCHIVO_LOG=`stat -c %s $OUTPUT_FILE` #Obtengo el tamaño del archivo de log local.
			if [ $TAMANO_ARCHIVO_LOG -gt $TAMANO_MAXIMO ]; then
			  echo "supero el tamaño del log local, se comenzara a loguear en el servidor remoto."
			  #Obtengo el usuario para loguearme en el servidor remoto,y me logueo al mismo, 				   actualizando el archivo de log remoto.
			  USER=`whoami`
			  `ssh $USER@$IP_SERVIDOR_REMOTO " $2 " >> "$OUTPUT_FILE"`
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
		;;

	detener)
		unset TAMANO_MAXIMO
		unset IP_SERVIDOR_REMOTO
		unset TAMANO_ARCHIVO_LOG
		;;

	*)
		echo "El mensaje $1 no forma parte de la interface."
		exit 1
		;;
esac





