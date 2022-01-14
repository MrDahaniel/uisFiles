# Trabajo 4: DHCP, NAT y PAT en IPv4 e IPv6

## DHCP en IPv4 e IPv6

### ¿Qué es DHCP?

DHCP, o Dynamic Host Configuration Protocol por sus siglas en inglés, hace referencia a uno de los protocolos de red más usados en en cuanto al manejo y la asignación de las direcciones de IP. En esencia, este protocolo se encarga de realizar la asignación de las direcciones IP dentro de una red a cada uno de los dispositivos los cuales necesiten dicha dirección IP, junto con la configuración correspondiente, con el fin de conectarse a la red.

### ¿Cómo funciona DHCP?

El protocolo de DHCP, funciona como una serie de pasos que un cliente DHCP y un servidor DHCP llevan a cabo dentro de una red. Es a partir de estos pasos por los cuales se realiza la asignación de la dirección de IP al igual que la configuración de los datos de la red.

#### Protocolo DHCP: Los pasos a seguir

1. DHCPDiscover
    > Lo primero que se realiza para realizar la ejecución del protocolo de DHCP, el cliente DHCP, que en este caso sería nuestro host o dispositivo, en el caso de no tener una IP asignada, realizará un broadcast a toda la red en búsqueda del servidor DHCP dentro de la red.
2. DHCPOffer
    > En el caso de que exista un servidor DHCP dentro de la red, y este haya recibido el mensaje del cliente DHCP, el servidor DHCP responde con una dirección IP disponible dentro de la red que pueda ser usada por el dispositivo.
3. DHCPRequest
    > Tras recibir la respuesta del servidor, el cliente DHCP responde con una petición de la IP que fue ofrecida por el servidor.
4. DHCPACK
    > Finalmente, tras recibir el request del cliente, el servidor le envía nuevamente la dirección IP asignada, al igual que la máscara de red, la _gateway_ default y la dirección del servidor DNS.

### Cosas a resaltar

Dentro de este mismo protocolo hay que resaltar algunas de las cosas que suceden de manera interna dentro del protocolo de DHCP.

#### DHCPOffer

Dentro de este paso del protocolo DHCP, pueden darse situaciones en las que el servidor, por algún u otro motivo, se presenten más de una oferta de dirección IP. En estos casos, el cliente DHCP, tomará la primera oferta que le fue realizada.

#### DHCPACK

Tras la asignación de la IP al host, internamente dentro del servidor DHCP, existe un registro de todas las direcciones que han sido "prestadas" por el servidor a los diferentes clientes. Este registro contiene la dirección asignada, la dirección MAC del cliente y la fecha máxima del préstamo. Tras el cumplimiento de la fecha, la dirección IP asignada es regresada nuevamente a la lista de las direcciones IPs disponibles dentro de la red.

### ¿Cómo se configura DHCP?

Para realizar la configuración de una red con un servidor DHCP, hay que tener en cuenta varios factores los cuales afectaran el comportamiento de nuestra red.

#### Rango de IP

Lo primero a definir para nuestro servidor de DHCP, es el rango de IPs disponibles dentro de la red. Con esto, se refiere a las IPs con las cuales nuestro servidor DHCP puede usar para responder a los mensajes DHCPDiscover. Este rango está definido a partir de la máscara de red que se esté usando para la respectiva red a trabajar.

#### Direcciones IP reservadas

Lo siguiente a definir son las direcciones IP reservadas o exclusivas dentro de la red. Esto principalmente se hace con el fin de evitar asignar direcciones IP que no debieron ser asignadas debido que son de uso exclusivo dentro de la red por alguna u otra razón.

#### Default Gateway

Debido a la capacidad del protocolo DHCP de dar la configuración correspondiente de manera automática a los dispositivos que lo soliciten, es necesario definir la gateway por defecto dentro de la red que se está trabajando. De esta manera, nuestro servidor DHCP podrá dar la configuración correcta a los dispositivos que se estén conectando dentro de nuestra red.

#### Dirección DNS

Así mismo, es necesario que el servidor DHCP conozca la dirección del servidor DNS que se estará usando en el momento de pasar de nombres de dominio a las direcciones IP.

#### Duración de Préstamo

Otra de las configuraciones necesarias para poder usar un servidor DHCP es el tiempo de la duración del préstamo de las direcciones IP que fueron asignadas por el servidor.

## NAT y PAT en IPv4

### Network Address Translation

#### ¿Qué es NAT?

Network Address Translation, o NAT por sus siglas, es un método utilizado con el fin de traducir las de direcciones de red locales a direcciones de red globales o de direcciones globales a locales. Este proceso se realiza a partir del enmascaramiento de las direcciones de red privadas, o locales; a direcciones de red públicas.

#### Funcionamiento de NAT

En esencia, NAT traduce las direcciones de red locales en direcciones de red públicas las cuales pueden ser accedidas fuera de la red. Esto lo hace a partir del uso de los diferentes puertos de la red con el fin de identificar cada una de las direcciones de red privadas. Es decir, cada dirección de red privada tiene un puerto asignado dentro de la dirección de red pública la cual le permite al router identificar los diferentes direcciones de red privadas de manera interna.

El como se realiza esta comparación entre las diferentes direcciones de red entre privadas y públicas, es a partir de una tabla, llamada tabla NAT, la cual contiene las equivalencias de cada unos de las direcciones de red que requieran de una dirección de red pública.

#### Tipos de NAT

##### NAT estática

La NAT estática se refiere principalmente al como está definida la tabla de NAT dentro de nuestro router. En este caso, como su nombre lo indica, estas equivalencias dentro de la tabla son estáticas y por lo tanto definidas de manera manual dentro de la configuración del router.

Aunque este procedimiento puede realizarse de dentro de redes relativamente pequeñas, el problema de la administración de estas tablas al igual que el tiempo empleado en la realización de esta configuración no es particularmente práctico en cuanto más escala el tamaño de la red.

##### NAT Dinámica

En el caso de el tipo de NAT dinámico, la única configuración que hay que realizar está en establecer el rango de direcciones de red públicas que pueden ser usadas por el router. En este caso, estas direcciones de red tienen que ser adquiridas por lo que esta traducción es 1:1, es decir, por cada dirección de red privada, se tiene una dirección de red pública con la cual se identifica.

Este tipo de NAT es particularmente cara de manejar debido a la cantidad de direcciones de red que hay que adquirir. Nuevamente el problema está en el gran costo que este tipo de NAT maneja.

##### PAT: Nat Avanzado

PAT, o Port Address Translation, es un tipo de NAT especial el cual emplea una única dirección de red pública con la cual realiza la traducción hacia y desde las direcciones locales. En este caso, se emplea uno de los puertos de la dirección de red pública la cual identifica tanto el dispositivo como la aplicación a la cual está realizando la transacción dentro de la red. Todas estas equivalencias se guardan en la tabla de NAT con la cual se realizarán las futuras traducciones.

PAT es el tipo de NAT más popular debido a su eficiencia debido al uso de una única dirección de red pública la cual permite a traducir una gran cantidad de direcciones de red privadas. En este sentido, nos referimos a una equivalencia de 1:n.

#### Configuración de NAT

La principal configuración a realizar para NAT, está en la definición de la dirección de red pública, o las direcciones de red públicas en el caso de usar NAT dinámico; que pueden ser usadas por el router. En el caso de usar NAT estático, está la necesidad de definir de manera manual cada una de las equivalencias para cada unas de las diferentes direcciones de red.

## Bibliografía

-   Tanenbaum, A. S. (1996). Computer networks. Upper Saddle River, N.J: Prentice Hall PTR.
-   https://docs.microsoft.com/en-us/windows-server/networking/technologies/dhcp/dhcp-top
-   https://www.youtube.com/watch?v=S43CFcpOZSI
-   https://www.computernetworkingnotes.com/ccna-study-guide/dhcp-configuration-parameters-and-settings-explained.html
-   https://www.youtube.com/watch?v=qij5qpHcbBk
-   https://www.geeksforgeeks.org/network-address-translation-nat/

<div style="text-align: right"> Daniel David Delgado Cervantes - 2182066 </div>
