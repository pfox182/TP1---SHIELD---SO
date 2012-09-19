#!/bin/bash

source /home/utnso/TP1---SHIELD---SO/includes/prompt.sh
#Incluciones de datos
source /home/utnso/TP1---SHIELD---SO/nucleo.conf

#Incluciones de funcionalidad
source /home/utnso/TP1---SHIELD---SO/includes/validar_comando.sh
source /home/utnso/TP1---SHIELD---SO/includes/es_un_built_in.sh
source /home/utnso/TP1---SHIELD---SO/includes/ejecutar_built_in.sh
source /home/utnso/TP1---SHIELD---SO/includes/ejecutar_comando.sh
source /home/utnso/TP1---SHIELD---SO/includes/inicializar_modulos_de_comando.sh

#Variables de uso comun
TERMINAL_DE_LA_SESSION=`tty`

#Iniciar modulos de comando
inicializar_modulos_de_comando

#Ejecucion de modulos periodicos en segundo plano
bash /home/utnso/TP1---SHIELD---SO/includes/ejecutar_modulos_periodicos.sh $TIEMPO_MODULOS_PERIODICOS $TERMINAL_DE_LA_SESSION & 

prompt;read STRING

while [ true ]
do
  
  #Capturar señal enviada por algun modulo periodico
  trap "exit 1" SIGUSR1 

  es_un_built_in "$STRING"
  if [ $? -eq 0 ];then 
	ejecutar_built_in "$STRING"
  else
	validar_comando "$STRING"
	if [ $? -eq 0 ];then
		ejecutar_comando "$STRING" 
	fi

  fi	

  prompt;read STRING 
done

exit 1 #Deberia salir con el built-in salir


