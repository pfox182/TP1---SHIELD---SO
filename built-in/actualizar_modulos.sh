#!/bin/bash
. $CARPETA_DE_INSTALACION/includes/inicializar_modulos.sh
. $CARPETA_DE_INSTALACION/includes/detener_modulos.sh
. $CARPETA_DE_INSTALACION/includes/registrar_e_inicializar_modulos.sh

registrar_e_inicializar_modulos
if [ $? = 1 ];then #Se produjo un error en algun modulo
	exit 1
fi
