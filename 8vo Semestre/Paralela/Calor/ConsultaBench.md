# Consulta Divertida Sobre Herramientas De Análisis De Desempeño

## Herramientas De Análisis De Desempeño

Como su nombre lo indica, las herramientas de análisis de desempeño, son, pues, herramientas empleadas para la obtención de métricas las cuales puedan ser usadas para evaluar el desempeño de algo (Bizneo, s.f.). Dentro del contexto que estamos trabajando, estas herramientas reportan datos relacionados con el desempeño de diferentes componentes de hardware (Computer Hope, 2018).

### Características Principales

La característica principal dentro de este tipo de herramientas, está el que presentan algún tipo de métrica la cual permita realizar la comparación entre dos sistemas. Siendo así, normalmente estas herramientas emplean diferentes tipos de cargas, a veces sintéticas, con las cuales se pueda evaluar el rendimiento del sistema (cpu-monkey, 2022).

Así mismo, en multiples herramientas, tras la realización de la evaluación del desempeño, los resultados de estos son reportados de diferentes maneras. Lo más común, es que se presenten como gráficas o tablas las cuales pueden ser usadas para poder realizar comparaciones del rendimiento de 2 sistemas de manera más específica al igual que la posibilidad de identificar anomalías o cambios drásticos que tomaron lugar durando el desarrollo de la prueba (PassMark Software, s.f.).

### Tipos De Herramientas De Análisis De Desempeño

Existen varios tipos de herramientas de análisis de desempeño las cuales cumplen diferentes tareas en el momento de realizar la evaluación de un sistema. Dentro de las más comunes, tenemos los que se encargan el realizar pruebas al hardware como pueden ser pruebas de rendimiento de CPU, GPU, memoria o almacenamiento (UserBenchmark, s.f.).

Seguidamente, tenemos las herramientas que están orientadas al desempeño del software como tal. Este tipo de herramientas buscan el realizar pruebas de estrés, resistencia, de picos y de punto de quiebre al software. Normalmente estas herramientas son empleadas por equipos de desarrollos con el fin de identificar problemas y fortalezas dentro del software desarrollado (CastSoftware, s.f.).

El último a nombrar están particularmente orientados hacia la computación en paralelo. Este tipo de pruebas están diseñadas principalmente para poder evaluar el desempeño de computadores los cuales usan tecnología de paralelismo. Dentro de las herramientas más importantes de esta categoría se tienen las pruebas NAS desarrolladas por la NASA para la evaluación de súper computadoras paralelas (NASA, s.f.).

### Ejemplos De Estas Herramientas

-   NAS Parallel Benchmarks: Como fue anteriormente presentado, las NAS Parallel Benchmarks, son una serie de pruebas desarrolladas por la NASA con las cuales se hacen, principalmente, evaluaciones de rendimiento a computadoras las cuales trabajan con paralelismo (NASA, s.f.).
-   CineBench: Esta herramienta está orientada principalmente a los análisis de desempeño de CPU en computadoras de todo tipo. Esta herramienta es comúnmente usada para realizar pruebas a soluciones de enfriamiento al igual que flujo de aire al igual que directamente al rendimiento de CPU (Maxon, s.f.).
-   Uniengine: Principalmente para la evaluación del desempeño de GPUs al igual que estabilidad de la configuración, esta herramienta es más orientada para pruebas sintéticas para evaluar el rendimiento (Uniengine, s.f.).

## Medición Del Desempeño

El medir el desempeño no es exclusivo a los sistemas computacionales. Siendo así, veamos como se mide el desempeño en otras áreas como lo son las redes y los procesos de los sistemas operativos.

### Redes

En el caso de las redes, existen diferentes maneras en las cuales se puede realizar la medición del desempeño. En la mayoría de los casos estas pruebas están orientadas principalmente hacia la medición de velocidad de transferencia entre dispositivos, conexiones TCP/IP, al igual que la integridad de los paquetes enviados dentro de la red (PassMark, s.f.). Estas pruebas realizan la medición, y generan los puntales, a partir del tiempo de duración de la prueba, la cantidad de datos enviados durante esta al igual que la cantidad de errores que se hayan presentado durante el desarrollo de la misma. Así mismo, se tienen en cuenta factores como la latencia al igual que la fluctuación.

### Procesos De Los Sistemas Operativos

En el caso de los procesos de los sistemas operativos, la medición del desempeño está más orientada a la cantidad de recursos que se usando durante la ejecución de los mismos. Siendo así, normalmente se trabajan métricas relacionadas con el uso de la red, manejo de los recursos de almacenamiento, CPU, GPU, memoria entre otros. Las herramientas empleadas para este tipo de mediciones de desempeño normalmente son las conocidas como los monitores de sistema y son considerados como mediciones de desempeño primitivas (Marcus Geelnard, 2018).

## Perfilador Y Trazador

Los perfiladores y los trazadores, son herramientas dentro de la computación usadas principalmente durante el desarrollo de software con el fin de arreglar problemas de rendimiento o de uso de recursos. En el caso de los perfiladores, estos proporcionan un análisis dinámico el cual se recolecta información sobre la ejecución de una aplicación o programa. Así mismo, los trazadores, son más como un registro de los eventos en orden cronológico que es están tomando durante la ejecución del aplicativo.

Estas herramientas cumplen la función de reportar datos que pueden ser usados para diagnosticar problemas durante la ejecución del software para su posterior optimización. Siendo así, en el caso de ser usadas en conjunto, son herramientas poderosas para la solución de problemas de desempeño.

Un ejemplo que me robé de github (benebo22, 2021):

```
Trace:
[2021-06-12T11:22:09.815479Z] [INFO] [Thread-1] Request started
[2021-06-12T11:22:09.935612Z] [INFO] [Thread-1] Request finished
[2021-06-12T11:22:59.344566Z] [INFO] [Thread-1] Request started
[2021-06-12T11:22:59.425697Z] [INFO] [Thread-1] Request finished

Profile:
2 "Request finished" Events
2 "Request started" Events
```

## Bibliografía

-   Bizneo. (s.f.) Herramientas de evaluación del desempeño: cómo elegir la más adecuada. Recuperado de [aquí](https://www.bizneo.com/blog/herramientas-de-evaluacion-del-desempeno/).
-   Computer Hope. (2018). Benchmark. Recuperado de [aquí](https://www.computerhope.com/jargon/b/benchmar.htm).
-   cpu-monkey. (2022). Compare CPU 2022. Recuperado de [aquí](https://www.cpu-monkey.com/en/).
-   PassMark Software. (s.f.). Notes on the Graphs. Recuperado de [aquí](https://www.cpubenchmark.net/graph_notes.html).
-   UserBenchmark. (s.f.). Software. Recuperado de [aquí](https://www.userbenchmark.com/page/about).
-   CastSoftware. (s.f.). Software Performa
-   nce Benchmarking. Recuperado de [aquí](https://www.castsoftware.com/glossary/software-performance-benchmarking-modeling).
-   NASA. (s.f.). NAS Parallel Benchmarks. Recuperado de [aquí](https://www.nas.nasa.gov/software/npb.html).
-   Uniengine. (s.f.). About us. Recuperado de [aquí](https://benchmark.unigine.com/about).
-   Maxon. (s.f.). CineBench. Recuperado de [aquí](https://www.maxon.net/en/cinebench).
-   PassMark Software. (s.f.). Network benchmark - test your network speed. Recuperado de [aquí](https://www.passmark.com/products/performancetest/pt_advnet.php).
-   Marcus Geelnard. (2018). Benchmarking OS primitives. Recuperado de [aquí](https://www.bitsnbites.eu/benchmarking-os-primitives/).
-   benebo22. (2021). Definition of debugging, profiling and tracing. Recuperado de [aquí](https://stackoverflow.com/questions/41725613/definition-of-debugging-profiling-and-tracing).

<div style="text-align: right"> Daniel David Delgado Cervantes - 2182066 </div>
