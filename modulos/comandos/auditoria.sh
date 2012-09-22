#!/bin/bash

source /home/utnso/TP1---SHIELD---SO/modulos/comandos/auditoria.conf

OUTPUT_FILE="/home/utnso/output_auditoria"
ARCHIVO_CONFIG_LOCAL="/home/utnso/TP1---SHIELD---SO/modulos/comandos/auditoria.conf"
 

if [ "$1" = "procesar" ]; then
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
fi

if [ "$1" = "informacion" ];then
	TAMANO_ARCHIVO_LOG=`stat -c %s $OUTPUT_FILE` #Obtengo el tamaño del archivo de log local.	
	echo "Tamaño maximo del archivo local de log: $TAMANO_MAXIMO , IP del servidor remoto de logueo: $IP_SERVIDOR_REMOTO , tamaño del archivo de log local: $TAMANO_ARCHIVO_LOG."

fi




