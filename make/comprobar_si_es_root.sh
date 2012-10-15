#!/bin/bash
SOY=`whoami`

if [ "$SOY" == "root" ];then
	exit 0
else
	echo "Solo el root puede ejecutar el makefile"
	exit 1
fi
