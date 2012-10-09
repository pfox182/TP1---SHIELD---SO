#!/bin/bash
#$1 -> USUARIO
#Si no defino el USUARIO busca todos los usuarios
if ( test -z $1 );then
	SHELL=`cat /etc/passwd | grep $1 | grep shield` #Se fija si hay algun usuario con SHIELD
else
	SHELL=`cat /etc/passwd | grep shield` #Se fija si hay algun usuario con SHIELD
fi

if ( test -z $SHELL );then
	exit 0
else
	echo "Esta asigana SHIELD"
	exit 1
fi
