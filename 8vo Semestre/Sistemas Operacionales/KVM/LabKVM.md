# Lab KVM

## Introducción

De manera general, la virtualización, está definida como un tipo de tecnología el cual permite la creación de uno o múltiples entornos simulados o emulados desde una única computadora (Red Hat, s.f.). Esta tecnología presente cientos de casos de uso los cuales van desde el simple hecho de poder trabajar con software antigüo, a través de sistemas operativos virtualizados que ya no presentan soporte (Como es el caso de Windows XP), al igual que la posibilidad de usarlo como herramienta en el desarrollo de aplicaciones web (Como servidores virtualizados en estado headless).

Partiendo de las diferentes aplicaciones que presenta esta tecnología, al igual que la gran importancia que esta ha traído a en la industria dentro de lo que se conoce como el cloud computing, hace que sea de gran importancia el estudio y el acercamiento a la virtualización al igual que algunas de las aplicaciones de software que nos permiten el usarla.

## Autoevaluación

-   ¿Qué se entiende por computador Host?, ¿qué se entiende por computador Guest?

    -   De manera general, se entiende como computador Host a aquel computador sobre el cual se están ejecutando máquinas virtuales. En otras palabras, este puede verse como la máquina la cual presta sus recursos, o host, a las máquinas virtuales, o guest.

-   ¿Qué clase de software es KVM según clasificación de los VMM?, ¿Qué clase de software es QEMU?

    -   El software KVM, dentro de la clasificación de hípervisores, es un hípervisor de tipo I. Esto se debe a que, como tal, su módulo de kernel, le permite tener acceso a nivel bajo de los recursos de la CPU. Por el contrario, QEMU por si sólo, es un hípervisor de tipo II el cual corre sobre el sistema operativo host la virtualización.

-   ¿Qué función cumple KVM cuando se usa en conjuto con QEMU?

    -   KVM, cuando se usa junto con QEMU, comple la función de darle acceso de manera directa a la CPU para los procesos de la virtualización. Es decir, en el caso de usar el combo KVM/QEMU, se está empleando un hípervisor tipo I.

-   ¿Qué es INTEL VT-X Y AMD-V?

    -   Intel VT-X y AMD-V son tecnologías que hacen parte de los procesadores Intel y AMD respectivamente. Esta tecnología, en escencia, permite que parte de la CPU del computador host, sea diréctamente asignada a las máquinas virtuales que se estén ejecutando. De esta manera, se acelera en gran medida el rendimiento de las máquinas virtuales debido a que se saltan la necesidad de la _traducción_ que presente en un hípervisor de tipo II.

-   ¿Cómo se verifica en la BIOS si su equipo tiene hardware de virtualización?

    -   La manera más sencilla de vertificar nuestra CPU tiene hardware de virtualización está en simplemente entrar a la BIOS y verficar si la opción está encendida. Sin embargo el dónde se encuentre de manera específica esta opción depende del fabricante de la tarjeta madre y la versión de la BIOS que se tenga. Un ejemplo de esto puede verse a continuación:
        ![lnOW0](https://i.imgur.com/DyRcZBE.jpg)

-   ¿Qué significa virtualización por software?

    -   La virtualización por software, o virtualización con un hipervisor tipo II, se refiere a la virtualización que se efectua sobre un sistema operativo host el cual presta parte de sus recursos para poder permitir la ejecución de los sistemas operativos guest. Cabe resaltar de que este tipo de virtualización tiende a tener problemas de rendimiento debido a la competencia de recursos entre el host y guest al igual que la necesidad de _traducir_ entre el hardware simulado y el hardware real.

-   ¿En qué sistemas operativos anfitriones se puede instalar KVM/QEMU?

    -   En el caso de KVM/QEMU, este software puede ser instalado de manera nativa únicamente en los sistemas operativos Linux. Es decir, distribuciones como Ubunto, Manjaro, Arch, Gentoo y otras pueden trabajar con KVM/QEMU pero otros como Windows o Macintosh no.

-   Mencione cinco sistemas operativos clientes que soporta KVM/QEMU

    -   Windows 95
    -   CentOS 6.5
    -   Ubuntu 22.04
    -   Fedora 18
    -   Manjaro 21.2.6

-   ¿Es posible compartir la USB, un directorio o un archivo entre el sistema anfitrión y la máquina virtual? Describa el procedimiento

    -   Sí es posible realizar un passthrough de USB el cual nos permita interactuar directamente con el dispositivos que se conecten a esta interfaz. Este proceso puede realizarse de varias maneras pero, en este caso, se mostrará a partir de los comandos de terminal:

        1. Lo primero a hacer, es identificar el puerto, o el dispositivo al cual le queremos hacer passthrough, esto se puede hacer con el comando `lsusb`

            ```rust
            foo@bar:~$ lsusb
            ...
            Bus 001 Device 003: ID 320f:5055 Evision AKKO Keyboard
            ...
            ```

        2. Y ahora, ejecutamos el siguiento comando para hacer el passthrough. El `hostbus` y `hostaddr`, son el número de bus y device que se muestran en el reporte de `lsusb`.

            ```rust
            foo@bar:~# /usr/bin/qemu-kvm -m 1024 -name [nombre del guest] -drive file=[imagen del guest],if=virtio -usb -device usb-host,hostbus=1,hostaddr=3
            ```

        3. Listo, ahora el dispositivo debería estar disponible para la máquina virtual guest que se escogió.

    -   En cuanto el compartir archivos y directorios desde el host al guest, esto se puede hacer de varias maneras, sin embargo, la manera más sencilla es por la terminal

        1. Ejecutamos el siguiente comando:

            ```rust
            /usr/bin/qemu-kvm -m 1024-name [nombre del guest] -drive file=[imagen del guest],if=virtio -fsdev local,security_model=passthrough,id=fsdev0,path=/tmp/share -device virtio-9p-pci,id=fs0,fsdev=fsdev0,mount_tag=hostshare
            ```

        2. Pasando a la máquina virtual, creamos el directorio el cual vamos a recibir los archivos desde el host al guest.

            ```rust
            guest@bar:~# mkdir /tmp/host_files
            ```

        3. Y finalmente montamos el directorio recién creado:

            ```rust
            guest@bar:~# mount -t 9p -o trans=virtio,version=9p2000.L hostshare /tmp/host_files
            ```

-   ¿Es posible ampliar la capacidad de almacenamiento de los discos anexando otros discos virtuales? Explique el procedimiento

    -   Es posible y es relativamente sencillo de hacer.

    1.  Lo primero es crear un nuevo disco virtual, esto se puede hacer de la siguiente manera:

            ```rust
            foo@bar:~# cd /var/lib/libvirt/images/
            foo@bor:../images/# qemu-img create -f raw new-disk-5G 5G
            ```

    2.  Ahora, ya con el disco virtual creado, es cuestión de agregarlo:

            ```rust
            foo@bar:~# virsh attach-disk [nombre del guest] /var/lib/libvirt/images/new-disk-5G vd[letra] --cache none
            ```

    Ya con esto, es cuestión de realizar la configuración del disco desde el guest para poder usarlo.

-   ¿Es posible compartir el portapapeles de la MV con la máquina anfitriona? Explique el procedimiento.

    Aunque hay multiples maneras de hacer esto, la manera más sencilla de realizar esto entre máquinas linux, está en simplemente instalar el paquete `spice-vdagent` en el sistema operativo del guest, permitirá esta función.

    En el caso de que se quiera hacer desde linux a una máquina Windows, esto puede hacerse de la misma manera instalando `spice-guest-tools`.
