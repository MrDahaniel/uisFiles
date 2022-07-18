#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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

int is_prime(int test_num) {
    int is_prime = 1;

    for (int j = 2; j < test_num; j++) {
        if (test_num % j == 0 && test_num != j) {
            is_prime = 0;
            break;
        }
    }

    return is_prime;
}

int main(int argc, char** argsv) {
    int rank, size;
    int test_num = get_flag_value(argc, argsv, "-n");

    MPI_Status status;

    // Inicializar MPI
    MPI_Init(&argc, &argsv);
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    // if (rank == 0) {
    //     printf("We've got %d ranks.\n", size);
    // }

    // printf("Hello! Rank #%d here!\n", rank);

    // for (int curr_num = 2; curr_num <= test_num; curr_num++) {
    //     if (is_prime(curr_num)) {
    //         printf("Prime found: %d\n", curr_num);
    //     }
    // }

    int current_rank = 1;

    printf("rank %d is up.\n", rank);

    if (rank == 0) {
        for (int curr_num = 2; curr_num <= test_num; curr_num++) {
            MPI_Send(&curr_num, 1, MPI_INT, current_rank, 10, MPI_COMM_WORLD);

            current_rank++;

            if (current_rank >= size) {
                current_rank = 1;
            }
        }

        for (int rank_id = 1; rank_id < size; rank_id++) {
            int end_signal = -1;
            MPI_Send(&end_signal, 1, MPI_INT, rank_id, 10, MPI_COMM_WORLD);
        }

        printf("Rank #%d is out.\n", rank);

    } else {
        int curr_num;

        do {
            MPI_Recv(&curr_num, 1, MPI_INT, MPI_ANY_SOURCE, MPI_ANY_TAG, MPI_COMM_WORLD, &status);

            if (curr_num == -1) {
                printf("Rank #%d is out.\n", rank);
                break;
            }

            // printf("Testing if %d is prime...\n", curr_num);

            if (is_prime(curr_num)) {
                printf("Prime found: %d\n", curr_num);
            }
        } while (1);
    }

    // Y bai mpi
    MPI_Finalize();
    return 0;
}