#!bin/bash

mkdir hwDir
cd hwDir

#1) Hacer un script shell que genere un archivo con los números del 1 al 1000

echo `seq -s " " 1 1000 | tr " " "\n"` > numbers.txt

#2) A partir del archivo anterior escriba un comando que genere un archivo con dos columnas de números: la primera con del 1 al 500 y la segunda con los números del 501 al 1000

split -l 500 numbers.txt
File=`paste xaa xab`
for Line in $File
do
    echo "$Line\n" > numbersSplit.txt
done 

#3) Agregue dos decimales a cada columna del archivo anterior

sed -i "s/[[:space:]]/.00 /g" listSplit.txt
sed -z -i "s/\n/.00\n /g" listSplit.txt
sed -i '$d' listSplit.txt
sed -i '$d' listSplit.txt

#4) Agregue una tercera columna que siga la siguiente expresión aritmética

#   valor1 + raizCuadrada(valor2)

echo `awk '{print $1 + sqrt($2)}' listSplit.txt | bc` > results.txt 
sed -z -i "s/[[:space:]]/\n/g" results.txt  

result=`paste listSplit.txt results.txt`
sed -i '1,$d' listSplit.txt

for Line in $result
do 
    echo "$Line\n" > listSplit.txt
done

sed -i 's/^ *//' listSplit.txt 
sed -i "s/[[:space:]]/\ /g" listSplit.txt

#5) Escriba un script shell que haga automáticamente todos los archivos anteriores.

mkdir hwDir
cd hwDir

echo `seq -s " " 1 1000` | tr " " "\n" > list.txt

split -l 500 list.txt
Lines=`paste xaa xab`
for Line in $Lines
do
    echo "$Line\n" > listSplit.txt
done 

rm xaa
rm xab

sed -i "s/[[:space:]]/.00 /g" listSplit.txt
sed -z -i "s/\n/.00\n /g" listSplit.txt
sed -i '$d' listSplit.txt
sed -i '$d' listSplit.txt

echo `awk '{print $1 + sqrt($2)}' listSplit.txt | bc` > results.txt 
sed -z -i "s/[[:space:]]/\n/g" results.txt  

result=`paste listSplit.txt results.txt`
sed -i '1,$d' listSplit.txt

for Line in $result
do 
    echo "$Line\n" > listSplit.txt
done

sed -i 's/^ *//' listSplit.txt 
sed -i "s/[[:space:]]/\ /g" listSplit.txt