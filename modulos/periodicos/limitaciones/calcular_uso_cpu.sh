

function calcular_uso_cpu()
{
	#Variables
	typeset -i SUMA_TIME1=0
	typeset -i SUMA_TIME2=0

	#Obtengo tiempo de utilización del cpu
	typeset -i CPU_TIME1=`cat /proc/uptime | cut -f1 -d " " | sed 's/\.//'` #sed -> reemplazo el . con nada

	for PID in `ps auxh | grep $USER | grep -v grep | awk '{ print $2 }'`
	do
		#Verifico que el proceso exista
		if [ -f /proc/${PID}/stat ];then
			#Obtengo el tiempo de uso del cpu por el proceso
	  		typeset -i PROCESS_TIME1=`cat /proc/${PID}/stat | awk '{t = $14 + $15;print t}'`
				#14 -> utime (Tiempo que el proceso se ejecuta en modo usuario
				#15 -> stime (Tiempo que el proceso se ejecuta en modo kernel
				#14+15 -> Tiempo total de uso del CPU por parte del proceso
			SUMA_TIME1=`expr $SUMA_TIME1 + $PROCESS_TIME1`
		fi
	done

	#Espero 1 segundo
	sleep 1

	#Obtengo el nuevo tiempo de utilización del cpu
	typeset -i CPU_TIME2=`cat /proc/uptime | cut -f1 -d " " | sed 's/\.//'` #Saca el .

	for PID in `ps auxh | grep utnso | grep -v grep | awk '{ print $2 }'`
	do
		#Verifico que el proceso exista
		if [ -f /proc/${PID}/stat ];then
			#Obtengo el nuevo tiempo de uso del cpu por el proceso
	  		typeset -i PROCESS_TIME2=`cat /proc/${PID}/stat | awk '{t = $14 + $15;print t}'`
				#14 -> utime (Tiempo que el proceso se ejecuta en modo usuario
				#15 -> stime (Tiempo que el proceso se ejecuta en modo kernel
				#14+15 -> Tiempo total de uso del CPU por parte del proceso
			SUMA_TIME2=`expr $SUMA_TIME2 + $PROCESS_TIME2`
		fi
	done
	
	#Calculo que porcentaje de tiempo del segundo esperado se le dedico a los procesos del usuario
		#USO_TOTAL_DEL_CPU 	 -> 100%
		#USO_DEL_USUARIO_DEL_CPU -> ?%
	typeset -i CPU=$((($SUMA_TIME2-$SUMA_TIME1)*100/($CPU_TIME2-$CPU_TIME1)))
	
return $CPU		
}




