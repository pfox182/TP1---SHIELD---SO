#!/bin/bash
PID_NUCLEO=`pgrep nucleo.sh`
kill -15 $PID_NUCLEO
exit 0
