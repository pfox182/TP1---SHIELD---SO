function registrar_e_inicializar_modulos()
{
	local TERMINAL_DE_LA_SESSION=$1
	local TTY=${TERMINAL_DE_LA_SESSION:5} #Le saco /dev/ para que quede solo la terminal

#Verificar si hay modulos ejecutandose y detenerlos
	local PID_EJECUTAR_PERIODICOS=`ps aux | grep ejecutar_modulos_periodicos.sh | grep $USER | grep $TTY | grep -v grep | awk '{ print $2 }'`
	if [ ! -z $PID_EJECUTAR_PERIODICOS ];then
		kill -15 $PID_EJECUTAR_PERIODICOS #Termino la ejecucion de modulos periodicos
	fi

	local MSJ=$(detener_modulos)
	
	if [ $? = 1 ];then
		echo $MSJ
		return 1
	fi

#Inicializar los modulos
	local MSJ=$(inicializar_modulos)
	
	if [ $? = 1 ];then
		echo $MSJ
		return 1
	fi
	
	return 0
}
