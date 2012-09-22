function terminar_procesos_en_segundo_plano()
{
	TERMINAL_DE_LA_SESSION=$1
	SENIAL=$2 #Señal a enviar a los procesos de la sesion
	TTY=${TERMINAL_DE_LA_SESSION:5} #Le saco /dev/ para que quede solo la terminal
	
	#Control de parametros
	if [ -z "$1" -o -z "$2" ];then 
		echo "Fltan parametros para terminar_procesos_en_segundo_plano.sh"
		return 1
	fi
	
	PIDS_DE_PROCESOS=`ps auxh | grep $TTY | grep $USER | grep -v $0 | awk '{ print $2 }'`
	
	for PID in $PIDS_DE_PROCESOS
	do
		if [ -f /proc/${PID}/stat ];then #Si existe el proceso
			kill -s $SENIAL $PID
		fi
	done

	return 0
}



