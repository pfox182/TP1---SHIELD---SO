#!/bin/bash

BUILT_IN_LIST=$CARPETA_DE_INSTALACION/includes/built_in.list

. $CARPETA_DE_INSTALACION/includes/es_un_built_in.sh


es_un_built_in $1

if [[ $? = "0" || $1 = "" ]];then
	if [[ $1 = "" ]];then
	cat $CARPETA_DE_INSTALACION/built-in/ayuda/*.info
	else
	cat $CARPETA_DE_INSTALACION/built-in/ayuda/$1.info  
	fi
	exit $?
else
	echo "El Parametro no es un Built in"
	exit $?
fi 

