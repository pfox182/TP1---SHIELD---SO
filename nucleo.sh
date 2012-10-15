#!/bin/bash

source /home/$USER/.shield/install.conf
source /home/$USER/.shield/tiempos.conf

. $CARPETA_DE_INSTALACION/includes/prompt.sh
#Incluciones de variables
. $CARPETA_DE_INSTALACION/includes/nucleo.variables

#Incluciones de funcionalidad
. $CARPETA_DE_INSTALACION/includes/validar_comando.sh
. $CARPETA_DE_INSTALACION/includes/es_un_built_in.sh
. $CARPETA_DE_INSTALACION/includes/ejecutar_built_in.sh
. $CARPETA_DE_INSTALACION/includes/ejecutar_comando.sh
. $CARPETA_DE_INSTALACION/includes/inicializar_modulos.sh
. $CARPETA_DE_INSTALACION/includes/detener_modulos.sh
. $CARPETA_DE_INSTALACION/includes/registrar_e_inicializar_modulos.sh
. $CARPETA_DE_INSTALACION/includes/terminar_procesos_en_segundo_plano.sh

#Registrar e inicializar todos los modulos
registrar_e_inicializar_modulos
if [ $? -ne 0 ];then #Se produjo un error en algun modulo
	exit 1
fi

#Verificar cambios en los archivos de configuracion en segundo plano
bash $CARPETA_DE_INSTALACION/includes/verificar_cambios_archivos_de_configuracion.sh $TIEMPO_VERIFICAR_ARCHIVOS_DE_CONFIGURACION & 

#Ejecucion de modulos periodicos en segundo plano
bash $CARPETA_DE_INSTALACION/includes/ejecutar_modulos_periodicos.sh $TIEMPO_MODULOS_PERIODICOS & 

while [ true ]
do
  #Capturar señal enviada ante el error de algun modulo periodico
  trap "terminar_procesos_en_segundo_plano TERM;exit 1" SIGUSR1 
  
  #Capturar señal enviada por el cambio en algun archivo de programacion
  trap "registrar_e_inicializar_modulos;if [ $? -ne 0 ];then exit 1;fi;bash $CARPETA_DE_INSTALACION/includes/verificar_cambios_archivos_de_configuracion.sh $TIEMPO_VERIFICAR_ARCHIVOS_DE_CONFIGURACION &" SIGUSR2 

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


