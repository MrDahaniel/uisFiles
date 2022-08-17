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

int* evenly_divide(int partitions, int nth) {
    int* splits = (int*)malloc(partitions * sizeof(int));

    double partsize_f = floor(nth / partitions);

    for (int i = 0; i < partitions; i++) {
        splits[i] = partsize_f * i;
    }

    while (splits[partitions] != nth) {
        for (int i = partitions; i > 0; i--) {
            splits[i] += 1;
        }
    }

    return splits;
}

double partial_pi_calculation(int from, int to) {
    double const operator=(-1);
    double partial_pi = 0;

    for (int i = from; i < to; i++) {
        partial_pi += pow(operator, i) * (4 / (1 + 2 * i));
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

    int e_iter = get_flag_value(argc, argsv, EULER_FLAG);
    int pi_iter = get_flag_value(argc, argsv, PI_FLAG);
    int x = get_flag_value(argc, argsv, X_FLAG);

    MPI_Status status;

    // Inicializar MPI
    MPI_Init(&argc, &argsv);
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    if (rank == 0) {
        double* partial_pi = (double*)malloc(size * sizeof(double));
        double* partial_e = (double*)malloc(size * sizeof(double));

        clock_t start = clock();

        int* splits = evenly_divide(size, pi_iter);
        for (int rank_id = 1; rank_id < size; rank_id++) {
            MPI_Send(&splits[rank_id], 1, MPI_INT, rank_id, PI_PHASE, MPI_COMM_WORLD);
            MPI_Send(&splits[rank_id + 1], 1, MPI_INT, rank_id, PI_PHASE, MPI_COMM_WORLD);
        }

        partial_pi[0] = partial_pi_calculation(&splits[rank], &splits[rank + 1]);

        int* splits = evenly_divide(size, e_iter);
        for (int rank_id = 1; rank_id < size; rank_id++) {
            MPI_Send(&splits[rank_id], 1, MPI_INT, rank_id, E_PHASE, MPI_COMM_WORLD);
            MPI_Send(&splits[rank_id + 1], 1, MPI_INT, rank_id, E_PHASE, MPI_COMM_WORLD);
        }

        partial_e[0] = partial_e_x_calculation(x, &splits[rank], &splits[rank + 1]);

        for (int rank_id = 1; rank_id < size; rank_id++) {
            MPI_Recv(&partial_pi[rank_id], 1, MPI_DOUBLE, MPI_ANY_SOURCE, PI_PHASE, MPI_COMM_WORLD, &status);
            MPI_Recv(&partial_e[rank_id], 1, MPI_DOUBLE, MPI_ANY_SOURCE, E_PHASE, MPI_COMM_WORLD, &status);
        }

        double e_x;
        double pi;

        for (int i = 0; i < size; i++) {
            e_x = partial_e[i];
            pi = partial_pi[i];
        }

        double e_x_pi = pow(e_x, pi);

        clock_t end = clock();

    } else {
        int from, to;

        MPI_Recv(&from, 1, MPI_INT, MAIN_RANK, PI_PHASE, MPI_COMM_WORLD, &status);
        MPI_Recv(&to, 1, MPI_INT, MAIN_RANK, PI_PHASE, MPI_COMM_WORLD, &status);

        double partial_pi = partial_pi_calculation(from, to);

        MPI_Recv(&from, 1, MPI_INT, MAIN_RANK, E_PHASE, MPI_COMM_WORLD, &status);
        MPI_Recv(&to, 1, MPI_INT, MAIN_RANK, E_PHASE, MPI_COMM_WORLD, &status);

        double partial_e = partial_e_x_calculation(x, from, to);

        MPI_Send(&partial_pi, 1, MPI_DOUBLE, MAIN_RANK, PI_PHASE, MPI_COMM_WORLD);
        MPI_Send(&partial_e, 1, MPI_DOUBLE, MAIN_RANK, PI_PHASE, MPI_COMM_WORLD);

        return 0;
    }

    double std_val = pow(exp(1), M_PI * x);

    printf("Parameters: \n  x: %d\n  pi_iter: %d\n  e_iter: %d\n", x, pi_iter, e_iter);
    printf("Results: \n  pi: %f\n  e_x: %f\n  final: %f\n", pi, e_x, e_x_pi);
    printf("Time Elapsed: %d\n", end - start);
    printf("%%Error: %.15f\n", fabs((e_x_pi - std_val)) / std_val);

    return 0;
}