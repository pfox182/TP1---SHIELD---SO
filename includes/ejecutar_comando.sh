function ejecutar_comando()
{
  #$1 -> Comando a ejecutar   
	
	es_un_built_in "$1" #Compruebo se es un built-in
  	
	if [ $? -eq 0 ];then 
		ejecutar_built_in "$1"
		return $?
  	else
		if [ -w /tmp ];then
			 eval "$1" 2>$ERROR_FILE #Si no hay error => archivo vacio
		else
			echo "Compruebe que exista la carpeta /tmp y los   permisos de lectura y escritura de la misma"
			return 1
		fi

		if [ -s /tmp/tmp_error ];then #Si existe y hay algo escrito
	 		echo "El comando $1 produjo un error."
	  		echo -e "Error:\n `cat $ERROR_FILE`"
			echo "">$ERROR_FILE #Limpio el archivo de error para el proximo comando a ejecutar
			return 1
		fi
	fi
	return 0
}

