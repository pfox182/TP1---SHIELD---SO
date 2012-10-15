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
			local ERROR=`cat $ERROR_FILE`
			local ERROR=${ERROR#"/etc/shield/includes/ejecutar_comando.sh: línea 11:"} #Se borra el substring indicado de la cadena
	 		echo "El comando $1 produjo un error."
	  		echo -e "Error:\n $ERROR"
			rm -f $ERROR_FILE #Borro el archivo de error para el proximo comando a ejecutar
			return 1
		fi
	fi
	return 0
}

