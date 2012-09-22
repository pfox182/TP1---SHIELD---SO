#!/bin/bash

#cargo archivo de configuracion
. /home/utnso/TP1---SHIELD---SO/modulos/periodicos/trafico_red.conf 

CANT_PAQUETESIP_SAL=$(ifconfig eth1 | grep "Paquetes TX" | awk '{print$2}' | cut -d ":" -f 2)


#comparo cantidad maxima de paquetes ip salientes con la cantidad actual.
if [ $1 = "iniciar" ];then
	if [ $CANT_MAX_PAQUETESIP_SAL -ge $CANT_PAQUETESIP_SAL ];then
		echo "La cantidad actual de paquetes ip salientes es: $CANT_PAQUETESIP_SAL"		
	else
		echo "informa por pantalla los sockets activos y elimina al proceso del sistema"
	fi
fi



#informo el estado actual de paquetes ip salientes y la cantidad maxima permitida.
if [ $1 = "informacion" ];then
	echo "La cantidad actual de paquetes ip salientes es : $CANT_PAQUETESIP_SAL"
	echo "La cantidad maxima de paquetes ip salientes permitidos por usuario es: $CANT_MAX_PAQUETESIP_SAL"
fi

	
