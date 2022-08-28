#include <math.h>
#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define M_PI 3.14159265358979323846  // Esto está definido en el math.h así, no se puede acceder a esto desde C porque ????? entonces, sí
#define EULER_FLAG "-e"
#define PI_FLAG "-p"
#define X_FLAG "-x"

#define MAIN_RANK 0
#define PI_PHASE 10
#define E_PHASE 20

int get_flag_value(int argc, char** argsv, char* flag) {
    int n;

    for (int i = 0; i < argc; i++) {
        if (strcmp(argsv[i], flag) == 0) {
            n = atoi(argsv[i + 1]);
            break;
        }
    }

    return n;
}

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

double partial_pi_calculation(int from, int to) {
    double const operator=(-1);
    double partial_pi = 0;

    for (int i = from; i < to; i++) {
        partial_pi += pow(operator, i) * (4 / (1 + (2 * (double)i)));
    }

    return partial_pi;
}

double partial_e_x_calculation(double x, int from, int to) {
    double partial_e_x = 0;

    for (int k = from; k < to; k++) {
        partial_e_x += pow(x, k) / tgamma(k + 1);
    }

    return partial_e_x;
}

int main(int argc, char** argsv) {
    int rank, size;

    MPI_Status status;

    int e_iter = get_flag_value(argc, argsv, EULER_FLAG);
    int pi_iter = get_flag_value(argc, argsv, PI_FLAG);
    int x = get_flag_value(argc, argsv, X_FLAG);

    int pi_from, pi_to, e_from, e_to;

    double* partial_pi = (double*)malloc(size * sizeof(double));
    double* partial_e = (double*)malloc(size * sizeof(double));

    int* pi_splits = (int*)malloc((size + 1) * sizeof(int));
    int* e_splits = (int*)malloc((size + 1) * sizeof(int));

    // Inicializar MPI
    MPI_Init(&argc, &argsv);
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    if (rank == 0) {
        // Arrancamos nuestro reloj
        clock_t start = clock();

        // Determinamos el número de splits para los ranks y el parámetro
        // dado por la terminal
        pi_splits = evenly_divide(size, pi_iter);

        // Enviamos a todos los ranks, el rango de la serie a calcular
        for (int rank_id = 1; rank_id < size; rank_id++) {
            MPI_Send(&pi_splits[rank_id], 1, MPI_INT, rank_id, PI_PHASE, MPI_COMM_WORLD);
            MPI_Send(&pi_splits[rank_id + 1], 1, MPI_INT, rank_id, PI_PHASE, MPI_COMM_WORLD);
        }

        // Repetimos el mismo proceso para la otra serie
        e_splits = evenly_divide(size, e_iter);

        for (int rank_id = 1; rank_id < size; rank_id++) {
            MPI_Send(&e_splits[rank_id], 1, MPI_INT, rank_id, E_PHASE, MPI_COMM_WORLD);
            MPI_Send(&e_splits[rank_id + 1], 1, MPI_INT, rank_id, E_PHASE, MPI_COMM_WORLD);
            MPI_Send(&x, 1, MPI_INT, rank_id, E_PHASE, MPI_COMM_WORLD);
        }

        // Para ahorrar recursos, ponemos a nuestro rank 0 a calcular
        // una parte de las series. En este caso el primer intervalo
        partial_pi[0] = partial_pi_calculation(pi_splits[rank], pi_splits[rank + 1]);
        partial_e[0] = partial_e_x_calculation(x, e_splits[rank], e_splits[rank + 1]);

        // Recuperamos lo calculado por todos los demás ranks
        for (int rank_id = 1; rank_id < size; rank_id++) {
            MPI_Recv(&partial_pi[rank_id], 1, MPI_DOUBLE, MPI_ANY_SOURCE, PI_PHASE, MPI_COMM_WORLD, &status);
            MPI_Recv(&partial_e[rank_id], 1, MPI_DOUBLE, MPI_ANY_SOURCE, E_PHASE, MPI_COMM_WORLD, &status);
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
            x, pi_iter, e_iter);
        printf(
            "Results: \n  pi: %f\n  e_x: %f\n  final: %f\n",
            pi, e_x, e_x_pi);
        printf("Time Elapsed: %d\n", end - start);
        printf("%%Error: %.15f\n", fabs((e_x_pi - std_val)) / std_val);

    } else {
        // Recibimos el rango de valores para la serie de pi
        MPI_Recv(&pi_from, 1, MPI_INT, MAIN_RANK, PI_PHASE, MPI_COMM_WORLD, &status);
        MPI_Recv(&pi_to, 1, MPI_INT, MAIN_RANK, PI_PHASE, MPI_COMM_WORLD, &status);

        // Se realizar el cálculo parcial de la serie
        double partial_pi = partial_pi_calculation(pi_from, pi_to);

        // Se recibe el rango y 'x' para calcular de manera parcial la serie
        MPI_Recv(&e_from, 1, MPI_INT, MAIN_RANK, E_PHASE, MPI_COMM_WORLD, &status);
        MPI_Recv(&e_to, 1, MPI_INT, MAIN_RANK, E_PHASE, MPI_COMM_WORLD, &status);
        MPI_Recv(&x, 1, MPI_INT, MAIN_RANK, E_PHASE, MPI_COMM_WORLD, &status);

        // se realiza el cálculo parcial de la serie
        double partial_e = partial_e_x_calculation(x, e_from, e_to);

        // Se envían los valores calculados al rank maestro
        MPI_Send(&partial_pi, 1, MPI_DOUBLE, MAIN_RANK, PI_PHASE, MPI_COMM_WORLD);
        MPI_Send(&partial_e, 1, MPI_DOUBLE, MAIN_RANK, E_PHASE, MPI_COMM_WORLD);
    }

    MPI_Finalize();
    return 0;
}