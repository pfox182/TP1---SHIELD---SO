function ejecutar_comando()
{
  #$1 -> Comando a ejecutar   
	
	es_un_built_in "$1" #Compruebo se es un built-in
  	
	if [ $? -eq 0 ];then 
		ejecutar_built_in "$1"
		return $?
  	else #Es un comando de bash
		eval "$1" 2>$ERROR_FILE #Evaluo el comando de bash y guardo su posible error
		if [ -s $ERROR_FILE ];then #Si existe y hay algo escrito lo muestro
	 		echo "El comando $1 produjo un error."
	  		echo -e "Error:\n `cat $ERROR_FILE`"
			echo "">$ERROR_FILE #Limpio el archivo de error para el proximo comando a ejecutar
			return 1
		fi
	fi
	return 0
}

