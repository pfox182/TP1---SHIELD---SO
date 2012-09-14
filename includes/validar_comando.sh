function validar_comando()
{
  for MODULO in `ls $MODULOS_DIR` #Solo aparecen los .sh y no aparece su copia temporal abierta 
  do
	bash $MODULO procesar "$1"
	if [ $? -ne 0 ];then
		return 1	#Si llega a fallar 1 modulo sale
	fi
  done

 return 0  #Todos los modulos fueron validados
}
