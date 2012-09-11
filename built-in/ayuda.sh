#!/bin/bash

source ~/TP1/includes/es_un_built_in.sh

case $1 in
	"" )
		echo "Muestra informacion acerca de los built-in"
		exit 0;;
  	 "ayuda" )
		echo "Muestra informacion acerca de los built-in"
		exit 0;;
		
esac  


echo "El paramentro pasado no es un built-in."
exit 1


