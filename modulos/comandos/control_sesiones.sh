#!/bin/bash


#Cargo archivo de configuracion
. /home/$USER/.shield/modulos/comandos/control_sesiones.conf

#Cantidad de sesiones abiertas por un mismo usuario
CANT_SESIONES=`ps aux | grep shield.sh | grep -v grep | grep $USER | wc -l`
CANT_SESIONES=`expr $CANT_SESIONES - 1`


#Comparo la cantidad max permitida con la cant actual de sesiones
case "$1" in
	"iniciar" )

    		if [ $CANT_MAX_SESIONES -ge $CANT_SESIONES ];then
			echo "La cantidad actual de sesiones abiertas es: $CANT_SESIONES"
     	 	else 
			echo "Cantidad maxima de sesiones superadas"
			PID_NUCLEO=`ps auxh | grep $SHIELD | grep $TTY | grep -v grep | awk '{ print $2 }'`
			kill -USR1 $PID_NUCLEO
    	 	fi;;

#Informo el estado actual de la configuracion y de las sesiones activas
	"informacion")

		echo "La cantidad actual de sesiones abiertas es: $CANT_SESIONES"
 	 	echo "La cantidad maxima de sesiones permitidas por usuario es: $CANT_MAX_SESIONES"
		exit 0;;
	
	"detener")
		unset CANT_MAX_SESIONES;;
esac


