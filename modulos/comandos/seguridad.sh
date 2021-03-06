#!/bin/bash

#$1 ->Tipo de operacion
#$2 ->String del comando (parametro)

CONFG_FILE=/home/$USER/.shield/modulos/comandos/seguridad.conf

TUBERIAS="<>|&"

case $1 in
	"") #Mensaje vacio
		;;
	iniciar)
 		#Leer el archivo de configuracion y exportar la variable con los valores asignados
		if ( test -e $CONFG_FILE );then #Me aseguro de que exista
  			export COMANDOS_RESTRINGIDOS=`cat $CONFG_FILE`
		else
			echo "El archivo de configuracion $CONFG_FILE de seguridad.sh no existe"
			exit 1
		fi
		#No se le pone exit, porque sino al llamarlo con source corta la ejecucion del script que lo llamo ( ej: nucleo.sh )
		;;


	procesar)
  		for COMANDO_RESTRINGIDO in $COMANDOS_RESTRINGIDOS
  		do
  			STR_FILTRADO=`echo " $2 " | grep -E "( $COMANDO_RESTRINGIDO | $COMANDO_RESTRINGIDO[$TUBERIAS]|[$TUBERIAS]$COMANDO_RESTRINGIDO |[$TUBERIAS]$CMDR[$TUBERIAS])"`
  		if [ -n "$STR_FILTRADO" ];then #Contiene un comando restringido
			echo "Error: El comando $COMANDO_RESTRINGIDO esta restringido."
			exit 1  	
  			fi
  		done

  		#Si paso el for => no hay comandos restringidos
		;;
 
	informacion)
  		echo "Lista de comandos restringidos:"
  		for COMANDO_RESTRINGIDO in $COMANDOS_RESTRINGIDOS
 		do
  			echo $COMANDO_RESTRINGIDO
 		done
		;;

	detener)
		unset COMANDOS_RESTRINGIDOS
		;;

	*)
		echo "El mensaje $1 no forma parte de la interface."
		exit 1
		;;
esac

	
