
# Creamos los directorios
mkdir -p /var/www/html/appWeb/libros
cd /var/www/html/appWeb

# Y ahora los archivos
touch text1.txt text2.txt text3.txt libros/pdf1.pdf libros/pdf2.pdf



# Se comprime el archivo usando tar 
cd ~
tar -cvJf appWeb.tar.xz /var/www/html/appWeb


ls ~ -lShc
