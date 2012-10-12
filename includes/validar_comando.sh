function validar_comando()
{
  for MODULO in `cat $MODULOS_DE_COMANDO` #MODULO es la ruta absoluta de cala modulo de comando + :on o :off
  do
	#Me fijo si esta activo
	local MODULO_ACTIVO=`echo $MODULO | cut  -d ":" -f 2`
	local MODULO=`echo $MODULO | cut  -d ":" -f 1`
	
	if [ "$MODULO_ACTIVO" = "on" ];then
		bash $MODULO procesar "$1"
		if [ $? -ne 0 ];then
			echo "Error al procesar el modulo $MODULO"
			return 1	#Si llega a fallar 1 modulo sale
		fi
	fi
	
  done

 return 0  #Todos los modulos fueron validados
}
