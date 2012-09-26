#!/bin/bash

#cargo archivo de configuracion
. /home/utnso/TP1---SHIELD---SO/modulos/periodicos/trafico_red.conf 

CANT_PAQUETESIP_SAL=$(ifconfig $(ifconfig | grep eth | awk '{print$1}') | grep -m 1 "TX" | awk '{print$2}' | cut -d ":" -f 2)


#comparo cantidad maxima de paquetes ip salientes con la cantidad actual.
if [ $1 = "procesar" ];then
	if [ $CANT_PAQUETESIP_SAL -ge $CANT_MAX_PAQUETESIP_SAL ];then	
		#Muestro los sockets activos
		lsof -i > SOCKETS_ABIERTOS.tmp
		cat SOCKETS_ABIERTOS.tmp 
		#busco los sockets activos y elimino sus procesos. 
		lsof -i -t > IDPROCESOS_SOCKETS.tmp
		while read line;do
        		#de los procesos encontrado me fijo a que usuario pertenecen
			USER_PROCESO=$(ps aux | awk '{print$1,$2}' | grep $line | awk '{print$1}')
        		#comparo si es el usuario del proceso es igual al usuario del shield
			if [ $USER_PROCESO = $USER ];then
                		kill -9 $line
                		echo "Se elimino el Proceso:$line USER:$USER_PROCESO"
        		fi;done < IDPROCESOS_SOCKETS.tmp
		#borro archivos temporal 
		rm IDPROCESOS_SOCKETS.tmp
		rm SOCKETS_ABIERTOS.tmp
	fi
	exit $?
fi



#informo el estado actual de paquetes ip salientes y la cantidad maxima permitida.
if [ $1 = "informacion" ];then
	echo "La cantidad actual de paquetes ip salientes es : $CANT_PAQUETESIP_SAL"
	echo "La cantidad maxima de paquetes ip salientes permitidos por usuario es: $CANT_MAX_PAQUETESIP_SAL"
 	exit $?
fi
