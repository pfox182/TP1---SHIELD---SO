#!/bin/bash

. /home/utnso/TP1---SHIELD---SO/includes/es_un_built_in.sh

UI="\033[4m"
UF="\033[0m"
AYUDA="${UI}ayuda$UF-> Muestra informacion acerca de los built-in. \n"
INFO_MODULOS="${UI}info_modulos$UF -> A cada módulo activo para el usuario le indica que imprima en pantalla información sobre sí mismo. Si al built-in se lo invoca en la forma “info_modulos string”, sólo imprimirá la información de los modulos cuyo nombre contengan al string recibido. \n"
LISTAR_MODULOS="${UI}listar_modulos$UF -> Presenta en pantalla los paths absolutos de los módulos que tiene activo el usuario. \n"
ACTUALIZAR_MODULOS="${UI}actualizar_modulos$UF -> Invoca a la función del núcleo Registrar e inicializar módulos. \n"
MOSTRAR="${UI}mostrar$UF -> Muestra el valor de la variable interna del shell pasada como parametro. \n"
SALIR="${UI}salir$UF -> Termina la sesión actual del usuario. \n"
APAGAR="${UI}apagar$UF -> Apaga la pc. \n"

TODOS="$AYUDA\n$INFO_MODULOS\n$LISTAR_MODULOS\n$ACTUALIZAR_MODULOS\n$MOSTRAR\n$SALIR\n$APAGAR"
case $1 in
	"" )
		echo -e $TODOS
		exit 0;;

	"ayuda" )
		echo -e $AYUDA
		exit 0;;
	"info_modulos" )
		echo -e $INFO_MODULOS
		exit 0;;
	"listar_modulos" )
		echo -e $LISTAR_MODULOS
		exit 0;;
	"actualizar_modulos" )
		echo -e $ACTUALIZAR_MODULOS
		exit 0;;
	"mostrar" )
		echo -e $MOSTRAR
		exit 0;;
	"salir" )
		echo -e $SALIR
		exit 0;;
	"apagar" )
		echo -e $APAGAR
		exit 0;;
		
esac 


echo "El paramentro pasado no es un built-in."
exit 1


