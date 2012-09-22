function inicializar_modulos()
{
  for MODULO in `ls $MODULOS_INICIALIZAR_DIR` #Solo aparecen los .sh 
  do
	bash $MODULO iniciar
	if [ $? -ne 0 ];then
		echo "Error al inicializar modulo: $MODULO"
		return 1	#Si llega a fallar 1 modulo sale
	fi
  done

 return 0  #Todos los modulos fueron validados
}
