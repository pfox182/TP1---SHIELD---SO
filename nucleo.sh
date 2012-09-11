#!/bin/bash

source ./includes/prompt.sh

#Incluciones de funcionalidad
source ./includes/validar_comando.sh
source ./includes/es_un_built_in.sh
source ./includes/ejecutar_built_in.sh
source ./includes/ejecutar_comando.sh


PCLAVE="salir" #Salida de la shell

prompt;read STRING

while [ "$STRING" != $PCLAVE ]
do

  es_un_built_in "$STRING"
  if [ $? -eq 0 ];then #TODO:Esta fallando la autenticacion
	ejecutar_built_in "$STRING"
  else
	validar_comando "$STRING"
	if [ $? -eq 0 ];then
		ejecutar_comando "$STRING" #TODO:No funciona el 2° plano
	fi

  fi	

  prompt;read STRING 
done

exit 0


