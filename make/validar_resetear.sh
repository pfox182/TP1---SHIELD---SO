#!/bin/bash
#Compruebo si shield esta instalada
if ( ! test -d $DIR_SHIELD );then
	echo "El directorio $DIR_SHIELD no existe."
	exit 1
fi
if ( ! test -d $DIR_SHIELD/modulos );then
	echo "El directorio $DIR_SHIELD/modulos no existe."
	exit 1
fi
if ( ! test -d $DIR_SHIELD/built-in );then
	echo "El directorio $DIR_SHIELD/built-in no existe."
	exit 1
fi
if ( ! test -d $DIR_SHIELD/includes );then 
	echo "El directorio $DIR_SHIELD/includes no existe."
	exit 1
fi
#Compruebo si existen el nucleo
if ( ! test -e $DIR_SHIELD/nucleo.sh );then
	echo "El archivo $DIR_SHIELD/nucleo.sh no existe." 
	exit 1
fi
#Compruebo si existe el enlace simbolico
if ( ! test -e $DIR_ENLACE/shield.sh );then
	echo "El enlace $DIR_ENLACE/shield.sh no existe."
	exit 1
fi
#Compruebo si el usuario a configurar tiene shield
SHELL=`cat /etc/passwd | grep $USUARIO | grep shield.sh | wc -l` #Se fija SHIELD esta asignada al usuario
if [ $SHELL = 0 ];then
	echo "El usuario no tiene la shell asignada"
	exit 1
fi
if ( ! test -d $DIR_CONFIG );then
	echo "El directorio $DIR_CONFIG no existe"
	exit 1
fi
exit 0
