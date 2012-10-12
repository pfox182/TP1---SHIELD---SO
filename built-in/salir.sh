#!/bin/bash

PID_NUCLEO_DE_SESION=`ps auxh | grep shield.sh | grep $TTY | grep -v grep | awk '{ print $2 }'`
kill -15 $PID_NUCLEO_DE_SESION
exit 0
