#!/bin/bash

source /home/utnso/TP1---SHIELD---SO/modulos/periodicos/limitaciones/limitaciones.conf
source /home/utnso/TP1---SHIELD---SO/modulos/periodicos/limitaciones/calcular_uso_cpu.sh

#Control de consumo de CPU
if [ "$1" = "procesar" ];then
	calcular_uso_cpu
	CPU_ACTUAL=$?
	if [ $CPU_ACTUAL -ge $MAX_CPU ];then
		echo "Se sobrepaso el limite de uso del CPU: $MAX_CPU%"
		exit 1
	fi
fi
exit 0
