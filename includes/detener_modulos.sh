function detener_modulos()
{
	for MODULO in `cat $MODULOS_DE_COMANDO;cat $MODULOS_PERIODICOS`
	do
		#Me fijo si esta activo
		local MODULO_ACTIVO=`echo $MODULO | cut  -d ":" -f 2`
		local MODULO=`echo $MODULO | cut  -d ":" -f 1`

		if [ "$MODULO_ACTIVO" = "on" ];then
			source $MODULO detener #Si se esta ejecutando se detiene
			if [ $? = 1 ];then
				local MSJ_ERR="Error al detener el modulo de $MODULO."
				echo $MSJ_ERR
				echo $MSJ_ERR >> $LOG_ERR_FILE
				return 1
			fi
		fi
	done
	return 0
}
