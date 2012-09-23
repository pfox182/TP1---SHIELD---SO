function detener_modulos()
{
	for MODULO in `ls $MODULOS_INICIALIZAR_DIR`
	do
		bash $MODULO detener #Si se esta ejecutando se detiene
		if [ $? = 1 ];then
			echo "Error al detener el modulo de $MODULO."
			return 1
		fi
	done
	return 0
}
