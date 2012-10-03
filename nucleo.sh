#!/bin/bash

. /home/utnso/TP1---SHIELD---SO/includes/prompt.sh
#Incluciones de variables
. /home/utnso/TP1---SHIELD---SO/includes/nucleo.variables

#Incluciones de funcionalidad
. /home/utnso/TP1---SHIELD---SO/includes/validar_comando.sh
. /home/utnso/TP1---SHIELD---SO/includes/es_un_built_in.sh
. /home/utnso/TP1---SHIELD---SO/includes/ejecutar_built_in.sh
. /home/utnso/TP1---SHIELD---SO/includes/ejecutar_comando.sh
. /home/utnso/TP1---SHIELD---SO/includes/inicializar_modulos.sh
. /home/utnso/TP1---SHIELD---SO/includes/detener_modulos.sh
. /home/utnso/TP1---SHIELD---SO/includes/registrar_e_inicializar_modulos.sh
. /home/utnso/TP1---SHIELD---SO/includes/terminar_procesos_en_segundo_plano.sh


#Variables de uso comun
export TERMINAL_DE_LA_SESSION=`tty`
export TTY=${TERMINAL_DE_LA_SESSION:5} 

#Registrar e inicializar todos los modulos
registrar_e_inicializar_modulos
if [ $? = 1 ];then #Se produjo un error en algun modulo
	exit 1
fi

#Verificar cambios en los archivos de configuracion en segundo plano
bash /home/utnso/TP1---SHIELD---SO/includes/verificar_cambios_archivos_de_configuracion.sh $TIEMPO_VERIFICAR_ARCHIVOS_DE_CONFIGURACION & 

#Ejecucion de modulos periodicos en segundo plano
bash /home/utnso/TP1---SHIELD---SO/includes/ejecutar_modulos_periodicos.sh $TIEMPO_MODULOS_PERIODICOS & 

while [ true ]
do
  #Capturar señal enviada ante el error de algun modulo periodico
  trap "terminar_procesos_en_segundo_plano TERM;exit 1" SIGUSR1 
  
  #Capturar señal enviada por el cambio en algun archivo de programacion
  trap "registrar_e_inicializar_modulos;if [ $? = 1 ];then exit 1;fi;bash /home/utnso/TP1---SHIELD---SO/includes/verificar_cambios_archivos_de_configuracion.sh $TIEMPO_VERIFICAR_ARCHIVOS_DE_CONFIGURACION &" SIGUSR2 #TODO:Extraer en una sola funcion registrar_e_inicializar_modulos y verificar_cambios_archivos_de_configuracion

  #Capturar señales de temrinacion
  trap "terminar_procesos_en_segundo_plano TERM;echo El programa finalizo.;exit 1" TERM
  trap "terminar_procesos_en_segundo_plano TERM;echo El programa termino inesperadamente.;exit 1" SIGINT
  trap "terminar_procesos_en_segundo_plano TERM;echo El programa termino inesperadamente.;exit 1" KILL
	
  #Comenzar a leer comandos
  prompt;read STRING

	validar_comando "$STRING"
	if [ $? -eq 0 ];then
		ejecutar_comando "$STRING" 
	fi

done

exit 1 #Deberia salir con el built-in salir


