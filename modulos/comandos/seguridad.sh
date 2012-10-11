#!/bin/bash

#$1 ->Tipo de operacion
#$2 ->String del comando (parametro)

CONFG_FILE=/home/utnso/TP1---SHIELD---SO/modulos/comandos/seguridad.conf

TUBERIAS="<>|&"

case $1 in
	iniciar)
 		#Leer el archivo de configuracion y exportar la variable con los valores asignados
  		export COMANDOS_RESTRINGIDOS=`cat $CONFG_FILE`
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
  		exit 0
		;;
 
	informacion)
  		echo "Lista de comandos restringidos:"
  		for COMANDO_RESTRINGIDO in $COMANDOS_RESTRINGIDOS
 		do
  			echo $COMANDO_RESTRINGIDO
 		done
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

	
