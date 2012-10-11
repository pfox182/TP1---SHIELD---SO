#!/bin/bash

# $1 -> $TIEMPO_VERIFICAR_ARCHIVOS_DE_CONFIGURACION
# $ULTIMA_ACTUALIZACION_DE_CONFIGURACION -> variable global del nucleo

function enviar_senial()
{
	PID_NUCLEO=`ps auxh | grep nucleo.sh | grep $TTY | grep -v grep | awk '{ print $2 }'`
	kill -USR2 $PID_NUCLEO	
}

function el_modulos_esta_activo()
{
	#$1 es el nombre del modulo
	local CONFIG_DEL_MODULO=`( cat $MODULOS_DE_COMANDO;cat $MODULOS_PERIODICOS ) | grep $1` #TODO:Agregar el filtrado por expresion regular
	local SEPARACION=`expr index "$CONFIG_DEL_MODULO" ":"`
	local MODULO_ACTIVO=${CONFIG_DEL_MODULO:$SEPARACION}
	if [ "$MODULO_ACTIVO" = "on" ];then
		return 0
	else
		return 1
	fi
}

while ( sleep $1 );do
	#Reviso cambios en la configuracion de los modulos de comando
	for ARCHIVO in `ls $ARCHIVOS_DE_CONFIGURACION_MODULOS/*/*.conf` #TODO:No abria que depender de la extencion .conf
	do		
		#Obtengo el nombre del modulo
		MODULO=`echo $ARCHIVO | sed -e "s/^\/.*\///g" | sed -e "s/\..*//g"` #devuelve ej: /home/utnso/.shield/modulos/seguridad.conf -> seguridad
	
		ULTIMA_MODICIFACION=`stat -c "%Y" $ARCHIVO`
		el_modulos_esta_activo $MODULO
		if ( [ $? = 0 ] && [ $ULTIMA_MODICIFACION -gt $ULTIMA_ACTUALIZACION_DE_CONFIGURACION ] );then 
			enviar_senial
			exit 0
		fi
	done
done

