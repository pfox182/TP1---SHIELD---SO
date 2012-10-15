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
if ( ! test -d $DIR_SHIELD/built_in );then
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
if ( ! test -e $DIR_ENLACE/shield.sh )
	echo "El enlace $DIR_ENLACE/shield.sh no existe."
	exit 1
fi
#Compruebo si el usuario a configurar no tiene shield
bash make/usuario_sin_shield.sh $USUARIO #Si el usuario tiene shield, el programa sale con error
if [ $? -ne 0 ];then
	exit 1
fi
if ( test -d $DIR_CONFIG );then
	echo "El directorio $DIR_CONFIG ya existe"
	exit 1
fi
exit 0
