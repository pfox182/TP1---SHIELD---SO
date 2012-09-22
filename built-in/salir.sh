#!/bin/bash
TERMINAL_DE_LA_SESSION=`tty`
TTY=${TERMINAL_DE_LA_SESSION:5}

PID_NUCLEO_DE_SESION=`ps auxh | grep nucleo.sh | grep $TTY | grep -v grep | awk '{ print $2 }'`
kill -15 $PID_NUCLEO_DE_SESION
exit 0
