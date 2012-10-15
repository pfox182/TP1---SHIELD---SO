function inicializar_modulos()
{
  for MODULO in `cat $MODULOS_DE_COMANDO;cat $MODULOS_PERIODICOS` #MODULO es la ruta absoluta de cala modulo de comando + :on o :off 
  do
	#Me fijo si esta activo
	local MODULO_ACTIVO=`echo $MODULO | cut  -d ":" -f 2`
	local MODULO=`echo $MODULO | cut  -d ":" -f 1`

	if [ "$MODULO_ACTIVO" = "on" ];then
		source $MODULO iniciar #Se utiliza source para que se exporten las variables a la sesion de trabajo
		if [ $? -ne 0 ];then
			local MSJ_ERR="Error al inicializar modulo: $MODULO"
			echo "$MSJ_ERR -> guardado en $LOG_ERR_FILE"
			echo $MSJ_ERR >> $LOG_ERR_FILE
			return 1	#Si llega a fallar 1 modulo sale
		fi
	fi
  done
  
  #Guardo el momento en el que se cargaron
  export ULTIMA_ACTUALIZACION_DE_CONFIGURACION=`date "+%s"` #%s -> epoch time ( una especie de entero del tiempo actual )
  return 0  #Todos los modulos fueron validados
}
