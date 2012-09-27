function terminar_procesos_en_segundo_plano()
{
	SENIAL=$1 #Señal a enviar a los procesos de la sesion
	
	#Control de parametros
	if [ -z "$1" ];then 
		echo "Falta la Señal a enviar por terminar_procesos_en_segundo_plano.sh"
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



