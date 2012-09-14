#!/bin/bash

OUTPUT_FILE="/home/utnso/output_auditoria"

if [ $1 = "procesar" ];then
  if [ -s "$OUTPUT_FILE" ]; then
    echo $2 >> $OUTPUT_FILE
  else
    echo $2 > $OUTPUT_FILE
  fi
  exit 0 
fi


