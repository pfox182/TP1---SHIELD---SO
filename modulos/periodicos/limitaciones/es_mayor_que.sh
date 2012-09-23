#!/bin/bash
function es_mayor_que()
{	
	local ACTUAL=$1
	local MAX=$2
		
	if [ -z `echo $MAX - $ACTUAL | bc | grep -` ];then #Si no hay un "-" => es positivo
		return 1 #No es mayor
	else
		return 0 #Es mayor
	fi
}

