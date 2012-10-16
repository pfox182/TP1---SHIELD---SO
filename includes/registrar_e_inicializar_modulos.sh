function registrar_e_inicializar_modulos()
{
#Verificar si hay modulos ejecutandose y detenerlos
	local PID_EJECUTAR_PERIODICOS=`ps aux | grep ejecutar_modulos_periodicos.sh | grep $USER | grep $TTY | grep -v grep | awk '{ print $2 }'`
	if [ ! -z $PID_EJECUTAR_PERIODICOS ];then #-z se fija si la cadena es igual a vacio
		kill -15 $PID_EJECUTAR_PERIODICOS #Termino la ejecucion de modulos periodicos
	fi

	detener_modulos
	if [ $? -ne 0 ];then
		return 1
	fi

#Inicializar los modulos
	inicializar_modulos
	if [ $? -ne 0 ];then
		return 1
	fi
	
	return 0
}
