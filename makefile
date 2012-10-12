#Makefile

#Variables
USUARIO=martin

#Directorios de instalacion
DIR_SHIELD=/etc/shield
DIR_ENLACE=/usr/bin
DIR_CONFIG=/home/$(USUARIO)/.shield


instalar:
	bash comprobar_si_es_root.sh || exit 1
	#Validamos que no este instalado shield (Si fallara alguno sale y muestra por pantalla el error)
	!(test -d $(DIR_SHIELD)) || (echo "El directorio $(DIR_SHIELD) ya existe.";exit 1)
	!(test -e $(DIR_SHIELD)/nucleo.sh && test -d $(DIR_SHIELD)/modulos && -d $(DIR_SHIELD)/built-in && test -d $(DIR_SHIELD)/includes) || (echo "Los directorios de SHIELD ya existen.";exit 1)
	#Creamos el directorio principal
	mkdir $(DIR_SHIELD)
	#Copio los archivos al directorio
	cp nucleo.sh $(DIR_SHIELD)/
	cp -R modulos $(DIR_SHIELD)/
	cp -R built-in $(DIR_SHIELD)/
	cp -R includes $(DIR_SHIELD)/
	#Configuramos los permisos del directorio de instalacion
	chmod -R 777 $(DIR_SHIELD)
	#Creamos el enlace simbolico
	(test -e $(DIR_SHIELD)/nucleo.sh) || (echo "No existe $(DIR_SHIELD)/nucleo.sh , para crear el enlace simbolico";exit 1)
	!(test -e $(DIR_ENLACE)/shield.sh) || (echo "El enlace $(DIR_ENLACE)/shield.sh ya existe.";exit 1)
	ln $(DIR_SHIELD)/nucleo.sh $(DIR_ENLACE)/shield.sh
	chmod 777 $(DIR_ENLACE)/shield.sh
	exit 0	

desinstalar:
	bash comprobar_si_es_root.sh || exit 1
	test -d $(DIR_SHIELD) || (echo "Shield no se encuentra instalado";exit 1)
	bash usuario_sin_shield.sh	#Si hay un usuario con shield, el programa sale con error
	rm -Rf $(DIR_SHIELD)
	rm $(DIR_ENLACE)/shield.sh
	exit 0
configurar:
	#TODO: Si no lo puede configurar hay que volver atras
	bash comprobar_si_es_root.sh || exit 1
	#Validaciones
	test -d $(DIR_SHIELD) || (echo "Shield no se encuentra instalado";exit 1)	
	test -e $(DIR_ENLACE)/shield.sh || (echo "El enlace $(DIR_ENLACE)/shield.sh no existe.";exit 1)
	bash usuario_sin_shield.sh $(USUARIO)
	!(test -d $(DIR_CONFIG)) || (echo "El directorio $(DIR_CONFIG) ya existe.";exit 1)
	#Copiamos la configuracion
	mkdir $(DIR_CONFIG)	
	cp -r config/modulos $(DIR_CONFIG)/
	#cp config/modulos_de_comando.config $(DIR_CONFIG)/
	#cp config/modulos_periodicos.config $(DIR_CONFIG)/
	echo "export CARPETA_DE_INSTALACION="$(DIR_SHIELD) > $(DIR_CONFIG)/install.conf
	echo $(DIR_SHIELD)/modulos/comandos/seguridad.sh:on > $(DIR_CONFIG)/modulos_de_comando.conf
	echo $(DIR_SHIELD)/modulos/comandos/auditoria.sh:on >> $(DIR_CONFIG)/modulos_de_comando.conf
	echo $(DIR_SHIELD)/modulos/comandos/control_sesiones.sh:on >> $(DIR_CONFIG)/modulos_de_comando.conf
	echo $(DIR_SHIELD)/modulos/periodicos/limitaciones.sh:off > $(DIR_CONFIG)/modulos_periodicos.conf
	echo $(DIR_SHIELD)/modulos/periodicos/trafico_red.sh:on >> $(DIR_CONFIG)/modulos_periodicos.conf
	echo $(DIR_SHIELD)/modulos/periodicos/control_carga.sh:on >> $(DIR_CONFIG)/modulos_periodicos.conf

	#Configuramos los permisos del directorio de configuracion
	chmod -R 777 $(DIR_CONFIG)
	#Le asignamos la shell al usuario
	chsh -s $(DIR_ENLACE)/shield.sh $(USUARIO)
	exit 0
resetear:
	bash comprobar_si_es_root.sh || exit 1
	#Validaciones
	test -d $(DIR_SHIELD) || (echo "Shield no se encuentra instalado";exit 1)	
	test -e $(DIR_ENLACE)/shield.sh || (echo "El enlace $(DIR_ENLACE)/shield.sh no existe.";exit 1)
	!(bash usuario_sin_shield.sh $(USUARIO))
	test -d $(DIR_CONFIG) || (echo "El directorio $(DIR_CONFIG) no existe.";exit 1)
	chsh -s /bin/bash $(USUARIO)
	rm -Rf $(DIR_CONFIG)
	exit 0

desinstalarTODO:
	rm -Rf $(DIR_CONFIG)
	rm -Rf $(DIR_SHIELD)
	rm $(DIR_ENLACE)/shield.sh
	chsh -s /bin/bash $(USUARIO)
	exit 0

	
	
	




