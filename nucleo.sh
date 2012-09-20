#!/bin/bash

. /home/utnso/TP1---SHIELD---SO/includes/prompt.sh
#Incluciones de datos
. /home/utnso/TP1---SHIELD---SO/nucleo.conf

#Incluciones de funcionalidad
. /home/utnso/TP1---SHIELD---SO/includes/validar_comando.sh
. /home/utnso/TP1---SHIELD---SO/includes/es_un_built_in.sh
. /home/utnso/TP1---SHIELD---SO/includes/ejecutar_built_in.sh
. /home/utnso/TP1---SHIELD---SO/includes/ejecutar_comando.sh
. /home/utnso/TP1---SHIELD---SO/includes/inicializar_modulos_de_comando.sh
. /home/utnso/TP1---SHIELD---SO/includes/terminar_procesos_en_segundo_plano.sh

. /home/utnso/TP1---SHIELD---SO/includes/ejemplo
#Variables de uso comun
TERMINAL_DE_LA_SESSION=`tty`

#Iniciar modulos de comando
#inicializar_modulos_de_comando

#Ejecucion de modulos periodicos en segundo plano
bash /home/utnso/TP1---SHIELD---SO/includes/ejecutar_modulos_periodicos.sh $TIEMPO_MODULOS_PERIODICOS $TERMINAL_DE_LA_SESSION & 

while [ true ]
do
  #Capturar señal enviada por algun modulo periodico
  trap "terminar_procesos_en_segundo_plano $TERMINAL_DE_LA_SESSION TERM;exit 1" SIGUSR1 
  
  #Capturar señales de temrinacion
  trap "terminar_procesos_en_segundo_plano $TERMINAL_DE_LA_SESSION TERM;echo El programa termino inesperadamente.;exit 1" SIGINT
  trap "terminar_procesos_en_segundo_plano $TERMINAL_DE_LA_SESSION TERM;echo El programa termino inesperadamente.;exit 1" TERM
  trap "terminar_procesos_en_segundo_plano $TERMINAL_DE_LA_SESSION TERM;echo El programa termino inesperadamente.;exit 1" KILL
	
  #Comenzar a leer comandos
  prompt;read STRING

  es_un_built_in "$STRING"
  if [ $? -eq 0 ];then 
	ejecutar_built_in "$STRING"
  else
	validar_comando "$STRING"
	if [ $? -eq 0 ];then
		ejecutar_comando "$STRING" 
	fi

  fi	

done

exit 1 #Deberia salir con el built-in salir


