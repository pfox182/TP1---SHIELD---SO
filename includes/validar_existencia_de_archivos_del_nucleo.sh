#!/bin/bash

if ( ! test -e /home/$USER/.shield/install.conf );then
	echo "No existe el archivos /home/$USER/.shield/install.conf"
	exit 1
fi
if ( ! test -e /home/$USER/.shield/tiempos.conf );then
	echo "No existe el archivos /home/$USER/.shield/tiempos.conf"
	exit 1
fi
if ( ! $CARPETA_DE_INSTALACION/includes/prompt.sh );then
	echo "No existe el archivos $CARPETA_DE_INSTALACION/includes/prompt.sh"
	exit 1
fi
if ( ! $CARPETA_DE_INSTALACION/includes/nucleo.variables );then
	echo "No existe el archivos $CARPETA_DE_INSTALACION/includes/nucleo.variables"
	exit 1
fi
if ( ! test -e $CARPETA_DE_INSTALACION/includes/validar_comando.sh );then
	echo "No existe el archivos $CARPETA_DE_INSTALACION/includes/validar_comando.sh"
	exit 1
fi
if ( ! test -e $CARPETA_DE_INSTALACION/includes/es_un_built_in.sh );then
	echo "No existe el archivos $CARPETA_DE_INSTALACION/includes/es_un_built_in.sh"
	exit 1
fi
if ( ! test -e $CARPETA_DE_INSTALACION/includes/ejecutar_built_in.sh );then
	echo "No existe el archivos $CARPETA_DE_INSTALACION/includes/ejecutar_built_in.sh"
	exit 1
fi
if ( ! test -e $CARPETA_DE_INSTALACION/includes/ejecutar_comando.sh );then
	echo "No existe el archivos $CARPETA_DE_INSTALACION/includes/ejecutar_comando.sh"
	exit 1
fi
if ( ! test -e $CARPETA_DE_INSTALACION/includes/inicializar_modulos.sh );then
	echo "No existe el archivos $CARPETA_DE_INSTALACION/includes/inicializar_modulos.sh"
	exit 1
fi
if ( ! test -e $CARPETA_DE_INSTALACION/includes/detener_modulos.sh );then
	echo "No existe el archivos $CARPETA_DE_INSTALACION/includes/detener_modulos.sh"
	exit 1
fi
if ( ! test -e $CARPETA_DE_INSTALACION/includes/registrar_e_inicializar_modulos.sh );then
	echo "No existe el archivos $CARPETA_DE_INSTALACION/includes/registrar_e_inicializar_modulos.sh"
	exit 1
fi
if ( ! test -e $CARPETA_DE_INSTALACION/includes/terminar_procesos_en_segundo_plano.sh );then
	echo "No existe el archivos $CARPETA_DE_INSTALACION/includes/terminar_procesos_en_segundo_plano.sh"
	exit 1
fi
if ( ! test -e $CARPETA_DE_INSTALACION/includes/verificar_cambios_archivos_de_configuracion.sh );then
	echo "No existe el archivos $CARPETA_DE_INSTALACION/includes/verificar_cambios_archivos_de_configuracion.sh"
	exit 1
fi
if ( ! test -e $CARPETA_DE_INSTALACION/includes/ejecutar_modulos_periodicos.sh );then
	echo "No existe el archivos $CARPETA_DE_INSTALACION/includes/ejecutar_modulos_periodicos.sh"
	exit 1
fi


