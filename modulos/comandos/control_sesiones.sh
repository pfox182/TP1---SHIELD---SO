#!/bin/bash


#Cargo archivo de configuracion
. /home/utnso/TP1---SHIELD---SO/modulos/comandos/control_sesiones.conf

#Cantidad de sesiones abiertas por un mismo usuario
CANT_SESIONES=`ps aux | grep nucleo.sh | grep -v grep | grep $USER | wc -l`

#CANT_SESIONES=$(who | grep $(whoami) | wc -l)


#Comparo la cantidad max permitida con la cant actual de sesiones
if [ "$1" = "iniciar" ];then
     if [ $CANT_MAX_SESIONES -ge $CANT_SESIONES ];then
	echo "La cantidad actual de sesiones abiertas es: $CANT_SESIONES"
     else 
	echo "Cantidad maxima de sesiones superadas"
     fi	
fi 

#Informo el estado actual de la configuracion y de las sesiones activas
if [ "$1" = "informacion" ];then
	echo "La cantidad actual de sesiones abiertas es: $CANT_SESIONES"
	echo "La cantidad maxima de sesiones permitidas por usuario es: $CANT_MAX_SESIONES"
fi


exit 0
