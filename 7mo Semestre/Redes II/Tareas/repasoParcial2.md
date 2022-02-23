# Estudiando Para El Parcial Culo de Redes

Desarrollado por Daniel David Delgado Cervantes, un estudiante en pena.

### Temas del segundo corte

-   Encaminamiento: Dinámico y estático
-   Métricas
-   Quién Sabe

## Encaminamiento: Estático y Dinámico

### ¿Qué es el encaminamiento?

El encaminamiento, a veces conocido como enrutamiento o ruteo, se refiere al proceso de definir los caminos que deben ser tomados para poder llegar a cada uno de los elementos dentro de una red determinada. En el caso de las redes de computadores, este enrutamiento puede realizarse de dos maneras, de manera manual, en el caso del enrutamiento estático; o de manera automática, en el caso del enrutamiento dinámico.

### Enrutamiento Estático

En el caso del encaminamiento estático, este se debe realizar de manera manual, es decir, dentro de la configuración de los diferentes routers, se deberá definir el camino por el cual cual los diferentes paquetes deberán seguir para así llegar a la red destino. Estas definiciones se guardan dentro de la tabla de enrutamiento.

El principal problema que presenta este tipo de encaminamiento está en el hecho de que es estático, es decir, no cambia a través del tiempo. Aunque esto en redes pequeñas donde es relativamente sencillo el realizar estas configuraciones en el caso de cambios en la topología de la red, se pueden presentar más problemas en redes de mayor tamaño. En este sentido, la escalabilidad del encaminamiento estático no es particularmente buena.

#### Configuración de encaminamiento estático en PacketTracer

La configuración de rutas estáticas en Packet Tracer es relativamente sencilla. Parar poder realizarla debemos posicionarnos, en el _router_ al cual queremos agregarle las rutas estáticas. Ya estando en la terminal de este, tendremos que ejecutar lo siguientes comandos.

```
> enable
> configure terminal
> ip route [Red Destino] [Máscara] [Dirección de entrada] [# de saltos]
```

De esta manera, podremos configurar cualquier tipo de enrutamiento estático para routers cisco. Cabe resaltar de que esa ruta es direccional, es decir, sólo va de A a B. En este sentido, quedaría pendiente el configurar el encaminamiento de B a A.

### Enrutamiento dinámico

El enrutamiento dinámico, se refiere al enrutamiento que es realiza de manera automática a partir de diferentes tipos de protocolos de red ya establecidos. Estos buscan el encontrar el mejor camino disponible a partir de diferentes métricas definidas.

A diferencia del encaminamiento estático, este presenta la ventaja de poder realizar cambios en cualquier momento que la topología de la red sea alterada por cualquier tipo de motivo. Así mismo, realiza la determinación de diferentes rutas alternativas en los casos en los que se pierdan nodos usados para el movimiento de los diferentes paquetes dentro de la red.

#### Protocolos de Vector Distancia

Los protocolos de vector distancia, como su nombre lo indican, tienen como métrica principal la cantidad de saltos entre cada uno de los nodos dentro de la red. En este sentido, el tiempo de ejecución de este protocolos es relativamente lento en comparación con otro tipo de protocolos, especialmente en el caso de redes de gran tamaño en las cuales tendrá que recorrer nodo por nodo para la poder determinar los caminos más óptimos para el protocolo.

Otras de las características relevantes dentro del protocolo, se encuentran:

-   En caso de una actualización, se envía completa de la tabla de enrutamiento en un broadcast o multicast.
-   Los mensajes para la actualización de la topología son relativamente lentos, se envían mensajes cada 30 segundos en el caso del protocolo `RIP`.
-   Pueden generarse bucles debido al envío completo de la tabla de enrutamiento y la escasez de los mensajes de actualización.
    -   Para evitar los bucles dentro de la red, se tienen algunos mecanismos de seguridad
        -   Distancia máxima
        -   Envenenamiento de ruta (Ruta inalcanzable)
        -   Actualización acelerada (Aumento de la cantidad de mensajes dentro de la red)
        -   Horizonte Dividido (No enviar actualizaciones por la misma ruta por la que la recibió)
        -   Tiempo de espera (Bloquea la actualización de una ruta en el caso de que esta sea detectada como caída)

Dentro de esta categoría se encuentran `RIP` y `IGRP`.

#### Protocolos de Estado de Enlace

En el caso de los protocolos de estado enlace, estos funcionan a partir de relaciones entre los diferentes routers. Gracias a esto, puede decirse que los protocolos conocen en su totalidad la red. Esto se debe a las actualizaciones que se dan en cuanto se agrega o elimina un nodo a la red. En cuanto a la métrica que estos protocolos emplean, usan el camino más corto en términos de latencia.

En este tipo de protocolos, los routers forman relaciones entre si usando el protocolo _hello_. De esta manera, los routers pueden conocer a sus vecinos y, eventualmente, conocer la topología entera de la red. De esta manera, podrán realizar actualizaciones en cuanto uno de los routers no encuentre a su vecino correspondiente.

Algunas de las características de los protocolos de estado de enlace son:

-   No existen bucles (La existencia de las relaciones entre routers y el mapa resultante evita que se presenten bucles)
-   Gran escalabilidad (Debido a la que la métrica que emplean es la latencia de los paquetes enviados, la escalabilidad de estos es mucho mejor)
-   Costo Computacional Alto (Debido a la necesidad del manejo de la creación y actualización de los mensajes, el costo computacional es mayor)
-   Dentro de esta categoría se encuentran `OSPF` y `IS-IS`.

#### Protocolos Híbridos

Es una mezcla entre ambos empleada de manera propietaria por los routers de Cisco. Este procedimiento se llama `EIGRP` y emplea una métrica en la que tiene en cuenta tanto la latencia como el vector de distancia en routers.
