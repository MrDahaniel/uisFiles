#!/bin/bash
read -p "Confirme cosas y/n" response
yes=$(expr "$response" : '^[YySs]')
no=`expr "$response" : '^[Nn]'`

case 1 in 
    $yes) echo "confirmado" ;;
    $no) echo "ps no" ;;
    *) echo "sin respuesta" ;;
esac

