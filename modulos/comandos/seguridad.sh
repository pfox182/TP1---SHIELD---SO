
#!/bin/bash

#$1 ->Tipo de operacion
#$2 ->String del comando (parametro)

CONFG_FILE="/home/utnso/TP1/modulos/comandos/seguridad.conf"
TUBERIAS="<>|&"

if [ $1 = "procesar" ];then
  while read COMANDO_RESTRINGIDO
  do
  	STR_FILTRADO=`echo " $2 " | grep -E "( $COMANDO_RESTRINGIDO | $COMANDO_RESTRINGIDO[$TUBERIAS]|[$TUBERIAS]$COMANDO_RESTRINGIDO |[$TUBERIAS]$CMDR[$TUBERIAS])"`
  	if [ -n "$STR_FILTRADO" ];then #Contiene un comando restringido
		echo "Error: El comando $COMANDO_RESTRINGIDO esta restringido."
		exit 1  	
  	fi
  done < $CONFG_FILE

  #Si paso el for => no hay comandos restringidos
  exit 0
fi
 
	
