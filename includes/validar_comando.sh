function validar_comando()
{
  if ( test -r $MODULOS_DE_COMANDO );then
	  for MODULO in `cat $MODULOS_DE_COMANDO` #MODULO es la ruta absoluta de cala modulo de comando + :on o :off
	  do
		#Me fijo si esta activo
		local MODULO_ACTIVO=`echo $MODULO | cut  -d ":" -f 2`
		local MODULO=`echo $MODULO | cut  -d ":" -f 1`
	
		if [ "$MODULO_ACTIVO" = "on" ];then
			bash $MODULO procesar "$1"
			if [ $? -ne 0 ];then
				local MSJ_ERR="Error al procesar el modulo $MODULO con el comando \"$1\""
				echo "$MSJ_ERR -> guardado en $LOG_ERR_FILE"
				if ( test -w $LOG_ERR_FILE );then			
					echo "$MSJ_ERR">> $LOG_ERR_FILE
				else
					echo "Error al guardar en $LOG_ERR_FILE, el archivo no existe o no se tiene permiso de escritura."
				fi
				return 1	#Si llega a fallar 1 modulo sale
			fi
		fi
	
	  done
	  return 0  #Todos los modulos fueron validados
  else
	local MSJ_ERR="No existe el archvo $MODULOS_DE_COMANDO o no se tiene permiso de lectura."
	echo "$MSJ_ERR -> guardado en $LOG_ERR_FILE"
	if ( test -w $LOG_ERR_FILE );then			
		echo "$MSJ_ERR">> $LOG_ERR_FILE
	else
		echo "Error al guardar en $LOG_ERR_FILE, el archivo no existe o no se tiene permiso de escritura."
	fi
	return 1
  fi
 
}
