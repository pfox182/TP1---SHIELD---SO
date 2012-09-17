#!/bin/bash

source /home/utnso/TP1---SHIELD---SO/modulos/periodicos/limitaciones/limitaciones.conf
source /home/utnso/TP1---SHIELD---SO/modulos/periodicos/limitaciones/calcular_uso_cpu.sh

#Control de consumo de CPU
while ( sleep 1 );do
	if [ "$1" = "procesar" ];then
		calcular_uso_cpu
		CPU_ACTUAL=$?
		if [ $CPU_ACTUAL -ge $MAX_CPU ];then
			exit 1
		fi
	fi
	exit 0
done
