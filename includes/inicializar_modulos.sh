function inicializar_modulos()
{
  for MODULO in `cat $MODULOS_DE_COMANDO;cat $MODULOS_PERIODICOS` #MODULO es la ruta absoluta de cala modulo de comando + :on o :off 
  do
	#Me fijo si esta activo
	local SEPARACION=`expr index "$MODULO" ":"`
	local MODULO_ACTIVO=${MODULO:$SEPARACION}
	SEPARACION=`expr $SEPARACION - 1` #Retrocedo 1 para saltar el ":"
	MODULO=${MODULO:0:$SEPARACION}

	if [ "$MODULO_ACTIVO" = "on" ];then
		source $MODULO iniciar #Se utiliza source para que se exporten las variables a la sesion de trabajo
		if [ $? -ne 0 ];then
			echo "Error al inicializar modulo: $MODULO"
			return 1	#Si llega a fallar 1 modulo sale
		fi
	fi
  done

 return 0  #Todos los modulos fueron validados
}
