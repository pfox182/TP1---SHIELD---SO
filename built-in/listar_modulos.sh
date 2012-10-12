#!/bin/bash

for MODULO in `cat $MODULOS_DE_COMANDO;cat $MODULOS_PERIODICOS`
  do	
    MODULO_ACTIVO=`echo $MODULO | cut  -d ":" -f 2`
    MODULO=`echo $MODULO | cut  -d ":" -f 1`    
    if [ "$MODULO_ACTIVO" == "on" ];then
	echo "$MODULO"	
    fi
  done

exit 0



