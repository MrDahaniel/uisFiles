# Tendencias Actuales en Simulación

## Redes Neuronales para simulación física
[AI Learns To Compute Game Physics In Microseconds!](https://www.youtube.com/watch?v=atcKO15YVD8&t=0s)

El video nos presenta una de las problemáticas relacionadas con la simulación de sistemas físicos, en este caso específico, de videojuegos. Esto, siendo, principalmente relacionado con la gran cantidad de fenómenos físicos que, desgraciadamente, toma una gran cantidad de tiempo la cual no permite que estas sean usadas en tiempo real.

En respuesta a esto, se plantea un nuevo método para la simulación de los diferentes fenómenos físicos con el fin de acelerar los tiempos de cálculo con el fin de conseguir simulaciones de sistemas físicos en tiempo real. Dicho modelo emplea una red neuronal, entrenada a partir de las simulaciones del método antiguo (Es decir, simuladores físicos completos, en los cuales están modelados a partir de las diferentes interacciones físicas del mundo real) con lo cual es posible tener una gran cantidad de datos con la cual trabajar.

A partir de esto, y gracias a la gran cantidad de datos a partir de las simuladores físicos completos, la red neuronal tiene la capacidad de realizar simulaciones físicas completas en una menor cantidad de tiempo en comparación de los métodos antiguos al igual que recursos computacionales en términos de memoria. Esta red neuronal también puede escalar la cantidad de interacciones físicas a simular y aún presenta una considerable mejora de velocidad en comparación con los simuladores físicos completos.

La clave que les permitió el desarrollo de esta red neuronal con increíbles capacidades se debe a la compresión de los datos de simulación los cuales sólo usa en el momento de que algo nuevo, no antes simulado, sucede dentro del juego. Es por ello, que esto le permite mantener un costo computacional bajo con un alto rendimiento en términos de frames por segundo que puede generar.

Daniel David Delgado Cervantes - 2182066
