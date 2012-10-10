#!/bin/bash

PATH_COMANDOS="/home/utnso/TP1---SHIELD---SO/modulos_de_comando.config"
PATH_PERIODICOS="/home/utnso/TP1---SHIELD---SO/modulos_periodicos.config"

for paths_comandos in `cat $PATH_COMANDOS`
  do	
    SEPARACION=`expr index "$paths_comandos" ":"`
    ESTADO=`echo ${paths_comandos:SEPARACION}`    
    if [ "$ESTADO" == "on" ];then
	echo `expr substr "$paths_comandos" "1" "$SEPARACION"`	
    fi
  done

for paths_periodicos in `cat $PATH_PERIODICOS`
  do	
    SEPARACION=`expr index "$paths_periodicos" ":"`
    ESTADO=`echo ${paths_periodicos:SEPARACION}`
    if [ "$ESTADO" == "on" ];then
	echo `expr substr "$paths_periodicos" "1" "$SEPARACION"`
    fi
  done
exit 1



