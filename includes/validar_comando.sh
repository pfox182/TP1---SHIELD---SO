function validar_comando()
{
  for MODULO in `cat $MODULOS_DE_COMANDO` #MODULO es la ruta absoluta de cala modulo de comando + :on o :off
  do
	#Me fijo si esta activo
	local SEPARACION=`expr index "$MODULO" ":"`
	local MODULO_ACTIVO=${MODULO:$SEPARACION}
	SEPARACION=`expr $SEPARACION - 1` #Retrocedo 1 para saltar el ":"
	MODULO=${MODULO:0:$SEPARACION}	
	
	if [ "$MODULO_ACTIVO" = "on" ];then
		bash $MODULO procesar "$1"
		if [ $? -ne 0 ];then
			return 1	#Si llega a fallar 1 modulo sale
		fi
	fi
	
  done

 return 0  #Todos los modulos fueron validados
}
