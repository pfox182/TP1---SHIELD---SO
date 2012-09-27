#!/bin/bash

#TODO:Hay que hacer que solo recorra los archivos de los modulos que esten en ON

# $1 -> $TIEMPO_VERIFICAR_ARCHIVOS_DE_CONFIGURACION
# $ULTIMA_ACTUALIZACION_DE_CONFIGURACION -> variable global del nucleo

function enviar_senial()
{
	PID_NUCLEO=`ps auxh | grep nucleo.sh | grep $TTY | grep -v grep | awk '{ print $2 }'`
	kill -USR2 $PID_NUCLEO	
}

while ( sleep $1 );do
	for ARCHIVO in `ls $ARCHIVOS_DE_CONFIGURACION_MODULOS/*/*.conf` #TODO:No abria que depender de la extencion .conf
	do		
		ULTIMA_MODICIFACION=`stat -c "%Y" $ARCHIVO`
		if [ $ULTIMA_MODICIFACION -gt $ULTIMA_ACTUALIZACION_DE_CONFIGURACION ];then 
			enviar_senial
			exit 0
		fi
	done
done

