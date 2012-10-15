#!/bin/bash
#$1 -> USUARIO
#Si no defino el USUARIO busca todos los usuarios
if [ ! -z $1 ];then
	SHELL=`cat /etc/passwd | grep $1 | grep shield.sh | wc -l` #Se fija SHIELD esta asignada al usuario
else
	SHELL=`cat /etc/passwd | grep shield.sh | wc -l` #Se fija si hay algun usuario con SHIELD
fi

if [ $SHELL = 0 ];then
	exit 0
else
	if [ ! -z $1 ];then
		echo "SHIELD esta asignada al usuario $1."
		exit 1
	else
		echo "SHIELD esta asignada a algun usuario."
		exit 1
	fi
fi
