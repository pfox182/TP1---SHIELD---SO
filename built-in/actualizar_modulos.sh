#!/bin/bash
. /home/utnso/TP1---SHIELD---SO/includes/inicializar_modulos.sh
. /home/utnso/TP1---SHIELD---SO/includes/detener_modulos.sh
. /home/utnso/TP1---SHIELD---SO/includes/registrar_e_inicializar_modulos.sh

registrar_e_inicializar_modulos
if [ $? = 1 ];then #Se produjo un error en algun modulo
	exit 1
fi
