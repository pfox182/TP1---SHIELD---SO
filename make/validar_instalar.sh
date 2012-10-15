#!/bin/bash
#Compruebo si existen los directorios de shield
if ( test -d $DIR_SHIELD );then
	echo "El directorio $DIR_SHIELD ya existe."
	exit 1
fi
if ( test -d $DIR_SHIELD/modulos );then
	echo "El directorio $DIR_SHIELD/modulos ya existe."
	exit 1
fi
if ( test -d $DIR_SHIELD/built_in );then
	echo "El directorio $DIR_SHIELD/built-in ya existe."
	exit 1
fi
if ( test -d $DIR_SHIELD/includes );then 
	echo "El directorio $DIR_SHIELD/includes ya existe."
	exit 1
fi
#Compruebo si existen el nucleo
if ( test -e $DIR_SHIELD/nucleo.sh );then
	echo "El archivo $DIR_SHIELD/nucleo.sh ya existe." 
	exit 1
fi
#Compruebo si existe el enlace simbolico
if ( test -e $DIR_ENLACE/shield.sh )
	echo "El enlace $DIR_ENLACE/shield.sh ya existe."
	exit 1
fi
exit 0
