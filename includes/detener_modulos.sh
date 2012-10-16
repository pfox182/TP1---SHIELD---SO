function detener_modulos()
{
	if ( test -e $MODULOS_DE_COMANDO && test -e $MODULOS_PERIODICOS );then #Me aseguro de que existan
		for MODULO in `cat $MODULOS_DE_COMANDO;cat $MODULOS_PERIODICOS`
		do
			#Me fijo si esta activo
			local MODULO_ACTIVO=`echo $MODULO | cut  -d ":" -f 2`
			local MODULO=`echo $MODULO | cut  -d ":" -f 1`

			if [ "$MODULO_ACTIVO" = "on" ];then
				source $MODULO detener 
				if [ $? -ne 0 ];then
					local MSJ_ERR="Error al detener el modulo de $MODULO."
					echo "$MSJ_ERR -> guardado en $LOG_ERR_FILE"
					if ( test -w $LOG_ERR_FILE );then
						echo "$MSJ_ERR">> $LOG_ERR_FILE
					else
						echo "Error al guardar en $LOG_ERR_FILE , el archivo no existe o no se tiene permisos de escritura"
					fi
					return 1
				fi
			fi
		done
		return 0
	else
		local MSJ_ERR="No existen los archivos de configuracion de los modulos $MODULOS_DE_COMANDO y $MODULOS_PERIODICOS"
		echo "$MSJ_ERR -> guardado en $LOG_ERR_FILE"
		if ( test -w $LOG_ERR_FILE );then		
			echo "$MSJ_ERR">> $LOG_ERR_FILE
		else
			echo "Error al guardar en $LOG_ERR_FILE , el archivo no existe o no se tiene permisos de escritura"
		fi
		return 1
	fi
}
