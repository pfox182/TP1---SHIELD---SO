#!/bin/bash

COMANDOS="pwd sudo touch"

#$1 ->Tipo de operacion
#$2 ->String del comando (parametro)

CONFG_FILE=/home/utnso/TP1---SHIELD---SO/modulos/comandos/seguridad.conf

TUBERIAS="<>|&"

if [ $1 = "iniciar" ];then
  #Leer el archivo de configuracion
  COMANDOS_DEL_ARCHIVO="\"`cat $CONFG_FILE`\""
  
  sed -e "3s/.*/`echo "COMANDOS="$COMANDOS_DEL_ARCHIVO`/g" $0 > $0.tmp;mv -f $0.tmp $0
	#sed -e "3s/.*/`echo "COMANDOS="$COMANDOS_DEL_ARCHIVO`/g" $0 ->Sustituye la linea 3 del archivo seguridad.sh($0) y lo muestra por pantalla
	#> $0.tmp;mv $0.tmp $0 ->Captura la salida del comando anterior y lo guarda en un archivo temporal, que luego reescribe el script seguridad.sh
  exit 0
fi


if [ $1 = "procesar" ];then
  for COMANDO_RESTRINGIDO in $COMANDOS
  do
  	STR_FILTRADO=`echo " $2 " | grep -E "( $COMANDO_RESTRINGIDO | $COMANDO_RESTRINGIDO[$TUBERIAS]|[$TUBERIAS]$COMANDO_RESTRINGIDO |[$TUBERIAS]$CMDR[$TUBERIAS])"`
  	if [ -n "$STR_FILTRADO" ];then #Contiene un comando restringido
		echo "Error: El comando $COMANDO_RESTRINGIDO esta restringido."
		exit 1  	
  	fi
  done

  #Si paso el for => no hay comandos restringidos
  exit 0
fi
 
if [ $1 = "informacion" ];then
  echo "Lista de comandos restringidos:"
  for COMANDO_RESTRINGIDO in $COMANDOS
  do
  	echo $COMANDO_RESTRINGIDO
  done
  exit 0
fi
	
