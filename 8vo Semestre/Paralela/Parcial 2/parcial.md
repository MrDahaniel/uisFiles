# Introducción A La Computación Paralela: Parcial II

## 1. Calculando $e^{x\pi}$ de manera serial

Lo primero a realizar está en dividir el problema con el fin de realizar el cálculo de la manera más eficiente posible. Gracias a las propiedades de la potenciación, podemos plantear lo siguiente:

$$e^{x\pi} = (e^x)^\pi$$

Siendo así, podemos realizar el cálculo de $e^x$ y $\pi$ de manera separada y luego operarlas con el fin de calcular el valor de $e^{x\pi}$. Para lograr eso, se plantearon las siguientes funciones, la primera se encarga del cálculo de $\pi$ a partir de la serie de Leibniz:

```c=
double calculate_pi(int iterations) {
    double const operator=(-1);
    double denominator = 1;

    double pi = 0;

    for (int i = 0; i < iterations; i++) {
        pi += pow(operator, i) * (4 / denominator);
        denominator += 2;
    }

    return pi;
}
```

Y la segunda se encarga del cálculo de $e^x$ a partir de la serie dada en el enunciado:

```c=
double calculate_e_pow_x(double x, int iterations) {
    double e_x = 0;

    for (int k = 0; k < iterations; k++) {
        e_x += pow(x, k) / tgamma(k + 1);
    }

    return e_x;
}
```

Seguidamente, usamos estas funciones, al igual que una función auxiliar que se encarga de la lectura de los parámetros dados por terminal; para poder realizar el cálculo de $e^{x\pi}$.

```c=
int main(int argc, char** argsv) {
    clock_t start, end;

    int e_iter = get_flag_value(argc, argsv, EULER_FLAG);
    int pi_iter = get_flag_value(argc, argsv, PI_FLAG);
    int x = get_flag_value(argc, argsv, X_FLAG);

    start = clock();

    double e_x = calculate_e_pow_x(x, e_iter);
    double pi = calculate_pi(pi_iter);
    double e_x_pi = pow(e_x, pi);

    end = clock();

    double std_val = pow(exp(1), M_PI * x);

    printf("Parameters: \n  x: %d\n  pi_iter: %d\n  e_iter: %d\n", x, pi_iter, e_iter);
    printf("Results: \n  pi: %f\n  e_x: %f\n  final: %f\n", pi, e_x, e_x_pi);
    printf("Time Elapsed: %d\n", end - start);
    printf("%%Error: %.15f\n", fabs((e_x_pi - std_val)) / std_val);

    return 0;
}
```

Tras compilar y ejecutar tendremos el siguiente resultado:

```shell
$ gcc -lm serial.c -o serial.out
$ ./serial.out -e 170 -p 10000000 -x 5
```

```
Parameters:
    x: 5
    pi_iter: 10000000
    e_iter: 170
Results:
    pi: 3.141593
    e_x: 148.413159
    final: 6635620.681530
Time Elapsed: 205129
%Error: 0.000000499999883
```

Ya teniendo estos valores, tendremos nuestros valores de referencia en términos de porcentaje de error y tiempo de ejecución. Será a partir de estos por los cuales podremos comparar nuestra ejecución serial con nuestra versión paralelizada.

Se ha de resaltar que las _flags_ `-e`, `-p`y `-x` se refieren a los parámetros de los términos de la serie de $e^x$, $\pi$ y el valor de $x$ respectivamente.

Así mismo, algo que puede parecer arbitrario, es el `170` usando como parámetro para la cantidad de términos de la serie de $e^x$. En este caso, esto se debe a la limitación propia de `C` en cuanto al máximo tamaño que se puede guardar en un `double`. En el caso de pasar un valor superior a este, retornará `inf`, y a su vez, evitará el cálculo de $e^x$.

## 2. Paralelizando el cálculo

Lo primero a realizar está en el identificar las partes del problema que podemos paralelizar. Para este problema en específico, aunque existen varias maneras en las que podríamos atacar el problema, solo trabajaremos con una de estas.

Partiendo del hecho de que para realizar el cálculo de cada una de las partes del problema, es decir $e^x$ y $\pi$; estamos usando series matemáticas. Partiendo de esto, podemos realizar el cálculo de estas en cualquier orden, y por extensión de manera paralela.

Esto puede observarse en el siguiente diagrama:

![](https://i.imgur.com/pGXca3l.png)

De esta manera, es posible realizar el cálculo de manera paralela de cada una de las series que necesitamos para nuestro valor final. Siendo así, es cuestión de realizar la respectiva implementación.

## 3. Implementando lo planteado

Lo primero a realizar es el modificar nuestras funciones `calculate_pi` y `calculate_e_pow_x` para que realicen únicamente el cálculo parcial de la serie dentro de un rango definido. Esto se realizó de la siguiente manera:

```c=
double partial_pi_calculation(int from, int to) {
    double const operator=(-1);
    double partial_pi = 0;

    for (int i = from; i < to; i++) {
        partial_pi += pow(operator, i) * (4 / (1 + (2 * (double)i)));
    }

    return partial_pi;
}
```

```c=
double partial_e_x_calculation(double x, int from, int to) {
    double partial_e_x = 0;

    for (int k = from; k < to; k++) {
        partial_e_x += pow(x, k) / tgamma(k + 1);
    }

    return partial_e_x;
}
```

Estas operan de manera identica a nuestras funciones originales, sin embargo toman como valores de entrada el rango de términos a calcular de la serie dada.

Ahora, teniendo la posibilidad de calcular las series por partes, es cuestión de encontrar una manera de repartir de manera equitativa el rango de términos a calcular. Esto lo podemos realizar con la función [`evenly_divide`](https://stackoverflow.com/questions/65329850/evenly-distribute-number-into-array-of-n-elements-with-equal-values) que nos retorna la lista de estos splits.

```c=
int* evenly_divide(int size, int nth) {
    int i = 1;
    int total = 0;
    int partitions = size + 1;

    int* splits = (int*)malloc(partitions * sizeof(int));

    splits[0] = 0;

    for (; i < nth % partitions; i++) {
        // printf("%d ", nth / partitions + 1);
        total += (nth / size) + 1;
        splits[i] = total;
    }
    for (; i < partitions; i++) {
        // printf("%d ", nth / partitions);
        total += (nth / size);
        splits[i] = total;
    }

    return splits;
}
```

Ya con la cantidad de términos distribuidos de manera uniforme para los ranks, será cuestión de indicarle a cada uno de los ranks, que parte de la serie ha de calcular. Primero, definamos el comportamiento de nuestro rank _maestro_.

```c=
if (rank == 0) {
    // Arrancamos nuestro reloj
    clock_t start = clock();

    // Determinamos el número de splits para los ranks y el parámetro
    // dado por la terminal
    pi_splits = evenly_divide(size, pi_iter);

    // Enviamos a todos los ranks, el rango de la serie a calcular
    for (int rank_id = 1; rank_id < size; rank_id++) {
        MPI_Send(
            &pi_splits[rank_id],
            1,
            MPI_INT,
            rank_id,
            PI_PHASE,
            MPI_COMM_WORLD
        );
        MPI_Send(
            &pi_splits[rank_id + 1],
            1,
            MPI_INT,
            rank_id,
            PI_PHASE,
            MPI_COMM_WORLD
        );
    }

    // Repetimos el mismo proceso para la otra serie
    e_splits = evenly_divide(size, e_iter);

    for (int rank_id = 1; rank_id < size; rank_id++) {
        MPI_Send(&e_splits[rank_id],
        	1,
        	MPI_INT,
        	rank_id,
        	E_PHASE,
        	MPI_COMM_WORLD);
        MPI_Send(&e_splits[rank_id + 1],
        	1,
        	MPI_INT,
        	rank_id,
        	E_PHASE,
        	MPI_COMM_WORLD);
        MPI_Send(&x,
        	1,
        	MPI_INT,
        	rank_id,
        	E_PHASE,
        	MPI_COMM_WORLD);
    }


    // Para ahorrar recursos, ponemos a nuestro rank 0 a calcular
    // una parte de las series. En este caso el primer intervalo
    partial_pi[0] = partial_pi_calculation(
        pi_splits[rank],
    	pi_splits[rank + 1]
    );
    partial_e[0] = partial_e_x_calculation(
        x,
    	e_splits[rank],
    	e_splits[rank + 1]
    );

    // Recuperamos lo calculado por todos los demás ranks
    for (int rank_id = 1; rank_id < size; rank_id++) {
        MPI_Recv(
            &partial_pi[rank_id],
            1,
            MPI_DOUBLE,
            MPI_ANY_SOURCE,
            PI_PHASE,
            MPI_COMM_WORLD,
            &status
        );
        MPI_Recv(
            &partial_e[rank_id],
            1,
            MPI_DOUBLE,
            MPI_ANY_SOURCE,
            E_PHASE,
            MPI_COMM_WORLD,
            &status
        );
    }

    // Sumamos todos los valores calculados por cada uno de
    // los ranks para tener el valor completo de cada una de
    // las series
    double e_x = 0;
    double pi = 0;

    for (int i = 0; i < size; i++) {
        e_x += partial_e[i];
        pi += partial_pi[i];
    }


    // Realizamos el cálculo final de la serie
    double e_x_pi = pow(e_x, pi);

    // Paramos el reloj
    clock_t end = clock();

    double std_val = pow(exp(1), M_PI * x);

    printf(
        "Parameters: \n  x: %d\n  pi_iter: %d\n  e_iter: %d\n",
        x, pi_iter, e_iter
    );
    printf(
        "Results: \n  pi: %f\n  e_x: %f\n  final: %f\n",
        pi, e_x, e_x_pi
    );
    printf("Time Elapsed: %d\n", end - start);
    printf("%%Error: %.15f\n", fabs((e_x_pi - std_val)) / std_val);

    }
```

Ya teniendo este comportamiento definido, podemos definir el comportamiento de los ranks _esclavos_. En este caso, estos no hacen más cosa que realizar el cálculo de cada una de las partes de las series. Primero la serie de $\pi$, y luego la serie $e^x$.

```c=
else {
    // Recibimos el rango de valores para la serie de pi
    MPI_Recv(&pi_from, 1, MPI_INT, MAIN_RANK, PI_PHASE, MPI_COMM_WORLD, &status);
    MPI_Recv(&pi_to, 1, MPI_INT, MAIN_RANK, PI_PHASE, MPI_COMM_WORLD, &status);

    // Se realizar el cálculo parcial de la serie
    double partial_pi = partial_pi_calculation(pi_from, pi_to);

    // Se recibe el rango y 'x' para calcular de manera parcial la serie
    MPI_Recv(&e_from, 1, MPI_INT, MAIN_RANK, E_PHASE, MPI_COMM_WORLD, &status);
    MPI_Recv( &e_to, 1, MPI_INT, MAIN_RANK, E_PHASE, MPI_COMM_WORLD, &status
    );
    MPI_Recv(
    	&x,
    	1,
    	MPI_INT,
    	MAIN_RANK,
    	E_PHASE,
    	MPI_COMM_WORLD,
    	&status
    );

    // se realiza el cálculo parcial de la serie
    double partial_e = partial_e_x_calculation(
    	x,
    	e_from,
    	e_to
    );

    // Se envían los valores calculados al rank maestro
    MPI_Send(
    	&partial_pi,
    	1,
    	MPI_DOUBLE,
    	MAIN_RANK,
    	PI_PHASE,
    	MPI_COMM_WORLD
    );
    MPI_Send(
    	&partial_e,
    	1,
    	MPI_DOUBLE,
    	MAIN_RANK,
    	E_PHASE,
    	MPI_COMM_WORLD
    );
}
```

<div style="text-align: right"> Daniel David Delgado Cervantes - 2182066 </div>
