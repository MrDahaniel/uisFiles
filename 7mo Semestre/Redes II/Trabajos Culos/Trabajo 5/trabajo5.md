# Trabajo 5: WLANs

## Redes IEEE 802.11 (WiFi).

De manera general, lo que se conoce como redes wlan, o WLANS en algunos casos; son redes las cuales, a diferencia de las redes LAN, no emplean cables para establecer la conexión entre los diferentes dispositivos que conforman la red. Esto puede apreciarse en la siguiente imagen.

![](https://i.imgur.com/ryQBegV.png)

<p style="text-align: right; font-size: 1.2rem;"> 
    Imagen tomada de 
    <a href="https://www.profesionalreview.com/2020/03/07/wlan-que-es/">
        Profesional Review.
    </a> 
</p>

Como podemos ver, a la izquierda se nos presentan conexiones entre un router inalámbrico y algunos dispositivos presentes en la misma. Es esta la característica principal de las redes pertenecientes a la familia 802.11.

## Aspectos de nivel físico.

A nivel físico, las redes WLAN poseen multiples características. Dentro de las principales características, están la manera en la que estas realizan tanto la transmisión como recepción de los diferentes paquetes que circulan por la red. En el caso de las redes WLAN, esta transmisión se da a partir de ondas de radio cuyo alcance determina el tamaño geográfico de nuestra red.

Estas ondas de radio, más específicamente la frecuencia de las mismas, está definido por el IEEE, más específicamente el IEEE 802.11; en cada uno de los diferentes estándares que se han definido con los años para este tipo de redes. Dentro de estas frecuencias, la que se puede considerar la más común para el manejo de redes WLAN es 2.54GHz (Protocolos 802.11-1997, 802.11b, 802.11g, 802.11n y 802.11ba, seguida de otras frecuencias que van desde 0.054GHz hasta 6GHz dependiendo de la aplicación y el protocolo que se maneje.

De igual manera, se ha de considerar las características relacionadas con el ancho de banda, valor que varía entre 1MHz y 160MHz dependiendo del protocolo y la aplicación; y la tasa de transmisión de datos, que va desde los 62.5Kbit/s hasta 9608Mbit/s en los protocolos más recientes como lo son el estándar WiFi 6 (802.11ax).

## Descripción de la arquitectura de protocolos.

### Basic Service Sets

De manera general, la arquitectura de los protocolos IEEE 802.11 está compuesta de celdas, debido a esto, se le conoce a este tipo de arquitecturas como celulares. Cada una de las celdas, en el caso de 802.11, se les conoce como Basic Service Set, BSS, o Set Básico de Servicio en español. Estas BSS, por motivos prácticos, pueden verse como cada uno de los dispositivos que están conectados a la red (portátiles, celulares, etc.).

### Access Points

Todos los BSS dentro de la red se conectan a un Access Point, AP, o Punto de Acceso. Estos puntos de acceso son los encargados de permitir la comunicación entre las BSS. Siendo así, el ejemplo más análogo a esto podría verse como un switch el cual permite a todos los dispositivos conectados el comunicarse sin problemas. Hay maneras en las que, en el caso de que los dispositivos se conecten directamente entre ellos, se pueda evitar el uso de un AP, sin embargo, esto sólo es verdaderamente útil en aplicaciones muy específicas.

### Distribution System

Finalmente, y en la capa más alta de la arquitectura, se encuentra el Distribution System, o Sistema de Distribución. Este como tal se encarga de conectar todos los AP dentro de la red. De esta manera, es posible expandir el tamaño geográfico de la red al estar conectados cada uno de los AP que la componen. Nuevamente, en el caso de querer compararlos a los dispositivos de las redes LAN, este Sistema de Distribución puede verse como el router el cual integra multiples puntos de acceso dentro de la red. Cabe resaltar que, dentro de este ejemplo específico, los routers inalámbricos pueden verse como tanto como puntos de acceso como sistemas de distribución.

Esta arquitectura puede verse de manera un poco más clara en la siguiente imagen.

![](https://i.imgur.com/e1WL2Xo.png)

<p style="text-align: right; font-size: 1.2rem;"> 
    Imagen tomada de 
    <a href="https://www.researchgate.net/figure/Multiple-basic-service-sets-form-a-extended-service-set_fig2_314449537">
        Research Gate.
    </a> 
</p>

## Formatos de tramas.

Como era de esperarse, las tramas de las redes WLAN, al ser comparadas con las tramas de las redes LAN; son un poco diferentes en cuanto el que las compone. Las principales diferencias a resaltar son el tamaño de la trama al igual que la estructura de la misma.

En primera instancia, y lo más básico, está en el tamaño de las mismas. El tamaño de una trama para redes LAN, se compone de un máximo de 1.542 Bytes; en el caso de las redes WLAN, las tramas tienden a tener un tamaño de 2346 bytes. Esta diferencia en el tamaño de las tramas está principalmente dado por un mayor tamaño en la capacidad de trasporte de los datos, al igual que las diferentes direcciones MAC que se emplean en el manejo de las tramas tanto por la complejidad como la seguridad requerida.

En cuanto a la estructura, hay que resaltar la presencia de las direcciones MAC del:

-   Dirección 1: MAC del emisor.
-   Dirección 2: MAC destino.
-   Dirección 3: MAC del medio que trasmite la trama.
-   Dirección 4: MAC destinada a recibir la transmisión entrante.

![](https://i.imgur.com/G5IoHBH.png)

<p style="text-align: right; font-size: 1.2rem;"> 
    Imagen tomada de 
    <a href="https://www.profesionalreview.com/2020/03/07/wlan-que-es/">
        Profesional Review.
    </a> 
</p>

De esta manera, se puede realizar la transmisión de las tramas de las redes WLAN hacia los diferentes destinos a las cuales estas tengan que ir. De esta manera, se asegura la transmisión correcta de las tramas de manera segura.

## Servicios LLC.

Los servicios LLC, o Logical Link Control, se refiere a la capa intermedia entre las capas Física y Red del modelo OSI. Esta capa intermedia, conocida como la capa de enlace, funciona como interfaz entre estas 2 capas a manera de multiplexor, o demultiplexor, dependiendo de si se está transmitiendo, o recibiendo, respectivamente.

Cabe resaltar que, específicamente los servicios LLC, son empleados en diferentes aplicaciones dentro de las diferentes redes, como lo son las redes LAN. Dentro de estas aplicaciones de LLC, están las redes WLAN las cuales emplean estos durante la transmisión y recepción de las diferentes tramas que se están trabajando.

<p style="text-align:center">
    <img src="https://i.imgur.com/zVelhST.png" >
</p>
<p style="text-align: right; font-size: 1.2rem;"> 
    Imagen tomada de 
    <a href="https://www.sciencedirect.com/topics/computer-science/high-level-data-link-control">
        Science Direct.
    </a> 
</p>

En la anterior imagen, puede verse de manera clara donde se encuentran los servicios LLC dentro de la capa de Enlace del modelo OSI.

## Conjuntos de servicios: DCF y PCF.

Distributed Coordination Function, DCF; y Point Coordination Function, PCF; son protocolos de red los cuales cumplen las funciones de manejar el medio en el que se realizan las transmisiones de los diferentes paquetes manejados dentro de la red. En este sentido, se refiere a la coordinación en la cual se transmiten mensajes hacia los diferentes dispositivos conectados en la misma. Cabe decir que, aunque como tal cumplen la misma función, las implementaciones de las soluciones son diferentes.

### Distributed Coordination Function

El funcionamiento del protocolo DCF puede definirse, en términos simples, como la manera en la que se busca el evitar colisiones dentro de la red con el fin de que todos los paquetes que están viajando por esta puedan llegar a su destino de manera segura.

Básicamente, el protocolo define un tiempo por el cual este habla y un tiempo por el cual este espera con el fin de recibir los datos emitidos por los dispositivos dentro de la red. De esta manera, se evitan colisiones las cuales pueden resultar en una pérdida de datos. En el caso de que se presente una colisión dentro de la red, el dispositivo implementando DCF, esperará un tiempo aleatorio con el fin en espera de nuevos paquetes.

<p style="text-align:center">
    <img src="https://ars.els-cdn.com/content/image/3-s2.0-B9780123744494000040-f07-12-9780123744494.jpg" >
</p>
<p style="text-align: right; font-size: 1.2rem;"> 
    Imagen tomada de 
    <a href="https://www.sciencedirect.com/science/article/pii/B9780123744494000040">
        Science Direct.
    </a> 
</p>

### Point Coordination Function

El protocolo PCF puede verse como una extensión del protocolo DFC en cuanto a las maneras en las que busca evitar la colisión de todos los datos dentro de la red. La diferencia principal está en el como el dispositivo implementando PCF pasa a esperar para la recepción de los diferentes elementos dentro de la red.

En este caso, el dispositivo, normalmente un punto de acceso, espera un tiempo conocido como PIFS el cual indica el tiempo intertrama. Este tiempo es menos que el tiempo aleatorio definido por DCF, lo cual implica que el dispositivo que implementa PCF tiene una prioridad dentro del canal. De esta manera, el punto de acceso puede mediar las comunicaciones dentro de la red y así evitar la pérdida de paquetes dentro de la red.

<p style="text-align:center">
    <img src="https://i.imgur.com/n9g4LNv.png" >
</p>
<p style="text-align: right; font-size: 1.2rem;"> 
    Imagen tomada de 
    <a href="https://www.sciencedirect.com/science/article/pii/B9780123736932000136">
        Science Direct.
    </a> 
</p>

## Estándares de alto desempeño.

Dentro de los diferentes estándares definidos por la IEEE durante la vida de las redes WLAN, algunos de estos han estado especialemente enfocados a mejorar las capacides y características dentro de las redes WLAN. Algunos de estos protocolos, a medida que pasaban los años, implicaron un increíble avance de las capacidades de las redes WLAN.

### 802.11a, 802.11g, 802.11n, 802.11ac y 802.11ax.

Los estándares para las redes WLAN 802.11a, 802.11g, 802.11n, 802.11ac y 802.11ax, han estado orientadas principalmente a la mejora del rendimiento al igual que la adopción de algunas características orientadas al funcionamiento de estas.

#### 802.11a

El primero de estos estándares, 802.11a, también conocido como 802.11a CORE, se refiere a uno de los estándares principales debido a que es apartir de este del cual muchos otros vienen. Lo principal a resaltar de este estádar está en la creación del requerimiento de la implementación de multiplexación por división de frecuencias ortogonales.

Es gracias a la implemtación de este requeriemiento por el cual se le busca darle soporte a las diferentes comunicaciones inalambricas no licenciadas. Es a partir de estas por las cuales busca darle soporte a las bandas entre 5GHz y 6GHz.

#### 802.11g

En esta nueva versión del estándar, se buscaba principalmente un aumento dentro del throughput de las redes WLAN empleando el mismo ancho de banda de 20MHz de las revisiones anteriores. Lo más destacable de esta mejoría está el aumento de throughput hasta 54Mbits/s lo cual permitía mayores velocidades y fluidez en cuanto a la comunicación entre los dispositivos dentro de la red WLAN.

#### 802.11n, 802.11ac y 802.11ax.

Estos estándares, también conocidos comercialmente como WiFi 4, 5 y 6 respectivamente, están orientados a grandes mejoras en cuanto al ancho de banda y el throughput que estas soportan. Estos estándares están especialmente enfocados hacia los consumidores debido a las diferentes mejorías en cuanto al soporte de las diferentes bandas que van desde 1GHz hasta poco más de 7.1 GHz.

Estos estándares búscan especialmente una mejor estabilidad en escenarios de alta densidad de datos como lo son oficinas o centros comerciales.

<p style="text-align:center">
    <img src="https://i.imgur.com/Pohj7lY.png" >
</p>
<p style="text-align: right; font-size: 1.2rem;"> 
    Imagen tomada de 
    <a href="https://www.xataka.com/basics/que-wi-fi-6-que-ventajas-tiene-respecto-a-version-anterior">
        Xacata.
    </a> 
</p>

## Referencias

-   https://www.profesionalreview.com/2020/03/07/wlan-que-es/
-   https://www.etsist.upm.es/estaticos/ingeniatic/index.php/tecnologias/item/668-wlan-wireless-local-area-network%3Ftmpl=component&print=1.html
-   http://jeuazarru.com/wp-content/uploads/2014/10/802.11n.pdf
-   https://www.researchgate.net/publication/314449537_Flexible_Information_Broadcasting_using_Beacon_Stuffing_in_IEEE_80211_Networks
-   https://www.winncom.com/es/glossary/163/llc-(logical-link-control)
-   https://www.sciencedirect.com/topics/computer-science/high-level-data-link-control

<div style="text-align: right"> Daniel David Delgado Cervantes - 2182066 </div>
