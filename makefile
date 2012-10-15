#Makefile

#Variables
export USUARIO=ktta

#Directorios de instalacion
export DIR_SHIELD=/etc/shield
export DIR_ENLACE=/usr/bin
export DIR_CONFIG=/home/$(USUARIO)/.shield


instalar:
	bash make/comprobar_si_es_root.sh || exit 1
	#Validamos que no este instalado shield 
	bash make/validar_instalar.sh || exit 1
	#Creamos el directorio principal
	mkdir $(DIR_SHIELD)
	#Copio los archivos al directorio
	cp nucleo.sh $(DIR_SHIELD)/
	cp -R modulos $(DIR_SHIELD)/
	cp -R built-in $(DIR_SHIELD)/
	cp -R includes $(DIR_SHIELD)/
	#Configuramos los permisos del directorio de instalacion
	chmod -R 555 $(DIR_SHIELD)
	#Creamos el enlace simbolico
	(test -e $(DIR_SHIELD)/nucleo.sh) || (echo "No existe $(DIR_SHIELD)/nucleo.sh , para crear el enlace simbolico";exit 1)
	ln $(DIR_SHIELD)/nucleo.sh $(DIR_ENLACE)/shield.sh
	chmod 555 $(DIR_ENLACE)/shield.sh
	bash make/unset_variables.sh
	exit 0	

desinstalar:
	#Restricciones
	bash make/comprobar_si_es_root.sh || exit 1
	bash make/validar_desinstalar.sh || exit 1
	#Desinstalacion
	rm -Rf $(DIR_SHIELD)
	rm $(DIR_ENLACE)/shield.sh
	bash make/unset_variables.sh
	exit 0
configurar:
	#Restricciones
	bash make/comprobar_si_es_root.sh || exit 1
	#Validaciones
	bash make/validar_configurar.sh || exit 1	
	#Copiamos la configuracion
	mkdir $(DIR_CONFIG)	
	cp config/tiempos.conf $(DIR_CONFIG)/
	cp -r config/modulos $(DIR_CONFIG)/
	echo "export CARPETA_DE_INSTALACION="$(DIR_SHIELD) > $(DIR_CONFIG)/install.conf
	echo $(DIR_SHIELD)/modulos/comandos/seguridad.sh:on > $(DIR_CONFIG)/modulos_de_comando.conf
	echo $(DIR_SHIELD)/modulos/comandos/auditoria.sh:on >> $(DIR_CONFIG)/modulos_de_comando.conf
	echo $(DIR_SHIELD)/modulos/comandos/control_sesiones.sh:on >> $(DIR_CONFIG)/modulos_de_comando.conf
	echo $(DIR_SHIELD)/modulos/periodicos/limitaciones.sh:on > $(DIR_CONFIG)/modulos_periodicos.conf
	echo $(DIR_SHIELD)/modulos/periodicos/trafico_red.sh:on >> $(DIR_CONFIG)/modulos_periodicos.conf
	echo $(DIR_SHIELD)/modulos/periodicos/control_carga.sh:on >> $(DIR_CONFIG)/modulos_periodicos.conf
	#Configuramos los permisos del directorio de configuracion
	chmod -R 555 $(DIR_CONFIG)
	#Le asignamos la shell al usuario
	chsh -s $(DIR_ENLACE)/shield.sh $(USUARIO)
	bash make/unset_variables.sh
	exit 0
resetear:
	bash "make/comprobar_si_es_root.sh" || exit 1
	#Validaciones
	bash make/validar_resetear.sh || exit 1
	chsh -s /bin/bash $(USUARIO)
	rm -Rf $(DIR_CONFIG)
	bash make/unset_variables.sh
	exit 0

reinstalar:
	make desinstalar
	make instalar

reconfigurar:
	make resetear
	make configurar

	
	
	




