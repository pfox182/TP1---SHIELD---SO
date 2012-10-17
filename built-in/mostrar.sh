#!/bin/bash
VAR=`env | grep -e "^$VAR="`
VALUE=`env | grep -e "^$1=" | cut -d "=" -f 2` 
if ( test -n $VAR );then #Si $VAR es distinto de vacio
	echo $VALUE
else
	echo "La variable $1 no se encuentra definida"
fi

 
