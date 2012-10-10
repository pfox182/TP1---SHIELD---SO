#!/bin/bash

BUILT_IN_LIST=/home/utnso/TP1---SHIELD---SO/includes/built_in.list

. /home/utnso/TP1---SHIELD---SO/includes/es_un_built_in.sh


es_un_built_in $1

if [[ $? = "0" || $1 = "" ]];then
	if [[ $1 = "" ]];then
	cat /home/utnso/TP1---SHIELD---SO3/built-in/ayuda/*.info
	else
	cat /home/utnso/TP1---SHIELD---SO3/built-in/ayuda/$1.info  
	fi
	exit $?
else
	echo "El Parametro no es un Built in"
	exit $?
fi 

