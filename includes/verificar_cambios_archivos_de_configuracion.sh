#!/bin/bash

# $1 -> $TIEMPO_VERIFICAR_ARCHIVOS_DE_CONFIGURACION
# $ULTIMA_ACTUALIZACION_DE_CONFIGURACION -> variable global del nucleo

function enviar_senial()
{
	PID_NUCLEO=`ps auxh | grep $SHIELD | grep $TTY | grep -v grep | awk '{ print $2 }'`
	kill -USR2 $PID_NUCLEO	
}

function el_modulos_esta_activo()
{
	#$1 es el nombre del modulo
	if ( test -r $MODULOS_DE_COMANDO && test -r $MODULOS_PERIODICOS );then
		local CONFIG_DEL_MODULO=`( cat $MODULOS_DE_COMANDO;cat $MODULOS_PERIODICOS ) | grep -E "\/.*/$1\.sh\:.."`
		local SEPARACION=`expr index "$CONFIG_DEL_MODULO" ":"`
		local MODULO_ACTIVO=${CONFIG_DEL_MODULO:$SEPARACION}
		if [ "$MODULO_ACTIVO" = "on" ];then
			return 0
		else
			return 1
		fi
	else
		echo "No existen los archivos $MODULOS_DE_COMANDO y $MODULOS_PERIODICOS, o no se tiene permiso de lectura"
		return 1
	fi
}

while ( sleep $1 );do
	#Reviso cambios en la configuracion de los modulos de comando
	if ( test -d  $ARCHIVOS_DE_CONFIGURACION_MODULOS );then
		for ARCHIVO in `ls $ARCHIVOS_DE_CONFIGURACION_MODULOS/*/*.conf` #TODO:No abria que depender de la extencion .conf
		do		
			#Obtengo el nombre del modulo
			#MODULO=`echo $A | cut -d "/" -f 6 | cut -d "." -f 1` #Opcion alternativa		
			MODULO=`echo $ARCHIVO | sed -e "s/^\/.*\///g" | sed -e "s/\..*//g"` #devuelve ej: /home/$USER/.shield/modulos/seguridad.conf -> seguridad
	
			ULTIMA_MODICIFACION=`stat -c "%Y" $ARCHIVO`
			el_modulos_esta_activo $MODULO
			if ( [ $? = 0 ] && [ $ULTIMA_MODICIFACION -gt $ULTIMA_ACTUALIZACION_DE_CONFIGURACION ] );then 
				enviar_senial
				exit 0
			fi
		done
	else
		echo "No existe el directorio $ARCHIVOS_DE_CONFIGURACION_MODULOS"
		exit 1
	fi
done

