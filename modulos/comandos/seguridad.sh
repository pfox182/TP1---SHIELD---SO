
#!/bin/bash
#TODO:No funcionan los comandos con tuberias

#$1 ->Tipo de operacion
#$2 ->String del comando (parametro)

CONFG_FILE="/home/utnso/TP1/modulos/comandos/seguridad.conf"

if [ $1 = "procesar" ];then
  while read COMANDO_RESTRINGIDO
  do
  	STR_FILTRADO=`echo " $2 " | grep -e " $COMANDO_RESTRINGIDO "`
  	if [ -n "$STR_FILTRADO" ];then #Contiene un comando restringido
		echo "Error: El comando $COMANDO_RESTRINGIDO esta restringido."
		exit 1  	
  	fi
  done < $CONFG_FILE

  #Si paso el for => no hay comandos restringidos
  exit 0
fi
 
	
