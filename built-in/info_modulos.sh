#!/bin/bash


if [[ $# != "0" ]];then        
       for MODULO in `cat $MODULOS_DE_COMANDO;cat $MODULOS_PERIODICOS`
       do
		MODULO_ACTIVO=`echo $MODULO | cut  -d ":" -f 2`
		MODULO=$(echo $MODULO | grep "$*")		

			if [[ $MODULO != "" ]];then
				if [[ $MODULO_ACTIVO = "on" ]];then
					MODULO=$(echo $MODULO | cut -d ":" -f 1)
					echo "------------------$MODULO--------------------"
					bash $MODULO informacion
					ES_MODULO=1
				else
					echo "Error: El modulo $MODULO no esta activo"
				fi
			fi
       done
	
	if [[ $ES_MODULO != "1"  ]];then
                  echo "Error: El parametro no coincide con el nombre de un modulo"                        
	fi

else
	         for MODULO in `cat $MODULOS_DE_COMANDO;cat $MODULOS_PERIODICOS`
       do
                MODULO_ACTIVO=`echo $MODULO | cut  -d ":" -f 2`
                MODULO=$(echo $MODULO)
        
                        
                                if [[ $MODULO_ACTIVO = "on" ]];then
                                        MODULO=$(echo $MODULO | cut -d ":" -f 1)
                                        echo "------------------$MODULO--------------------"
                                        bash $MODULO informacion
                                        ES_MODULO=1
                                fi
       done

fi




