#!/bin/bash

#cargo archivo de configuracion
CONFG_FILE="/home/$USER/.shield/modulos/periodicos/trafico_red.conf" 

CANT_PAQUETESIP_SAL=$(ifconfig $(ifconfig | grep eth | awk '{print$1}') | grep -m 1 "TX" | awk '{print$2}' | cut -d ":" -f 2)

SOCKETS_ABIERTOS=$TMP_FILE_DIR/SOCKETS_ABIERTOS-$TTY_FILE.tmp
IDPROCESOS_SOCKETS=$TMP_FILE_DIR/IDPROCESOS_SOCKETS-$TTY_FILE.tmp


case "$1" in
	 "") #Mensaje vacio
                ;;

	 "procesar")
		#comparo cantidad maxima de paquetes ip salientes con la cantidad actual.
		if [ $CANT_PAQUETESIP_SAL -ge $CANT_MAX_PAQUETESIP_SAL ];then
			#busco los sockets activos.
			lsof -i -t > $IDPROCESOS_SOCKETS
			while read line;do
        			#de los procesos encontrado me fijo a que usuario pertenecen y su TTY
				USER_PROCESO=$(ps aux | awk '{print$1,$2}' | grep $line | awk '{print$1}')
        			USER_TTY=$(ps aux | awk '{print$2,$7}' | grep $line | awk '{print$2}')
				#comparo si es el usuario del proceso es igual al usuario del shield y si es de la misma terminal
				if [[ $USER_PROCESO = $USER && $USER_TTY = $TTY ]];then
                			#Muestro los sockets activos del proceso
					lsof -i | grep $line > $SOCKETS_ABIERTOS
                                        cat $SOCKETS_ABIERTOS
					#Mato al Proceso que genero los sockets.
					kill -15 $line
                			echo "Se elimino el Proceso $line del sistema."
        			fi;done < $IDPROCESOS_SOCKETS
			#borro archivos temporal 
			rm $IDPROCESOS_SOCKETS
			rm $SOCKETS_ABIERTOS
		fi
		exit $?;;

	"informacion")
		echo "La cantidad actual de paquetes ip salientes es : $CANT_PAQUETESIP_SAL"
		echo "La cantidad maxima de paquetes ip salientes permitidos por usuario es: $CANT_MAX_PAQUETESIP_SAL"
 		;;
	
	"detener")
		unset CANT_MAX_PAQUETESIP_SAL;;

	"iniciar")

        	for VARIABLE in `cat $CONFG_FILE`
        	do
                	export $VARIABLE
        	done;;

	  *)
                echo "El mensaje $1 no forma parte de la interface."
                exit 1
                ;;

esac



