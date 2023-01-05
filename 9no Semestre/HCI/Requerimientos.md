# Requerimientos: DRP

## Requerimientos de usuario:

1.  Especificidad de la localización

    Unas de las necesidades para poder realizar su trabajo es el saber dónde se encuentra lo que presenta el problema. Siendo así, tener la posibilidad de especificar a las personas encargadas dónde se encuentra lo que requiere atención.

2.  Fácil acceso al historial de trabajo

    Una de las cosas importantes cuando se realizan reparaciones, es saber qué se ha hecho antes. Es necesario que se tengan los reportes de los tickets que antes se hayan resuelto al igual que estos sean fáciles de acceder dentro desde las mismas órdenes de trabajo.

3.  Seguimiento a tickets de servicio

    En casos donde salen problemas extra después de un reporte inicial, debe ser posible, bajo el mismo reporte inicial, poder crear subtickets en los cuales poder darle un seguimiento en el caso de ser necesario.

4.  Registro del trabajo

    El reconcimiento del trabajo realizado es importante para todas las personas pertenecientes a la división de mantenimiento tecnológico; es necesario que sin importar por qué sistema se trabaje, queden reportadas las acciones realizadas.

5.  Usabilidad Móvil

    El poder consultar información del sistema de información desde dispositivos móvil como tablets y celulares es una necesidad de primera clase. En la mayoría de los casos el acceso a un computador durante las reparaciones no es posible y el sistema de información debe poder consultarse desde cualquier lado.

6.  Auditoría interna

    Como parte del proceso de auditorías, las personas en roles administrativos deben poder consultar y revisar los tiempos de servicio, tickets cerrados, número de seguimientos, al igual que otras estadísticas necesarias.

## Requerimientos Técnicos:

1.  Autenticación y autorización

    El manejo de roles y perfiles dentro de la solución planteada es necesario para poder mantener la estructura interna al igual que para asegurar el flujo de trabajo de la división de mantenimiento tecnológico. Es necesario poder asignar roles al igual que autenticar a las personas dentro del sistema.

2.  Disponibilidad

    La solución planteada debe estar disponible para su consulta, idealmente, todo el tiempo. Siendo así, se necesita que tenga una disponibilidad del 99.99% (Un fallo cada 10000 peticiones).

3.  Interoperabilidad

    Debido a la gran cantidad de dispositivos que se manejan, es necesario que la solución planteada funcione en cualquiera de los navegadores de computador al igual que los de dispositivos móviles.

4.  Mantenibilidad

    Debe tenerse un sistema que se engargue de realizar una auditoría interna dentro de la solución planteada la cual permita darle un siguimiento interno con el fin de resolver errores en el caso de que se presenten.

5.  Orientado a Microservicios

    Con el fin de tener flexibilidad en cuanto al despliegue de la aplicación propuesta al igual que asegurar la disponibilidad del mismo, se debe trabajar una arquitectura orientada a microservcios flexible la cual pueda darle soporte a todos los picos de servicio al igual que facilitar el mantenimiento de la solución propuesta.
