function detener_modulos()
{
	for MODULO in `cat $MODULOS_DE_COMANDO;cat $MODULOS_PERIODICOS`
	do
		#Me fijo si esta activo
		local SEPARACION=`expr index "$MODULO" ":"`
		local MODULO_ACTIVO="${MODULO:$SEPARACION}"
		SEPARACION=`expr $SEPARACION - 1` #Retrocedo 1 para saltar el ":"
		MODULO="${MODULO:0:$SEPARACION}"

		if [ "$MODULO_ACTIVO" = "on" ];then
			source ${MODULO:0:$SEPARACION} detener #Si se esta ejecutando se detiene
			if [ $? = 1 ];then
				echo "Error al detener el modulo de $MODULO."
				return 1
			fi
		fi
	done
	return 0
}
