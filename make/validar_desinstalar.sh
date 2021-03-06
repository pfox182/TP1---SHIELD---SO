#!/bin/bash
#Compruebo si no existen los directorios de shield
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
#Compruebo si SHIELD esta configurada para algun usuario
bash make/usuario_sin_shield.sh #Si hay un usuario con shield, el programa sale con error
if [ $? != 0 ];then
	exit 1
fi
if ( test -d /home/*/.shield );then
	echo "Shield esta configurada para algun usuario."
	exit 1
fi
exit 0
