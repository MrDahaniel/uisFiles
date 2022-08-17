#!/bin/bash

if test -e "$1"; then

    file_name=$(echo $1 | rev | cut -d'/' -f 1 | rev)

    echo "El archivo $file_name existe"
    echo Tiene `wc -l ./usuarios.txt | awk '{print $1}'` lineas
else
    echo "El archivo no existe. Paila."
fi