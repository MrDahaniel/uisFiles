#include <stdio.h>
#include <stdlib.h>

#include <string>

// Definimos las constantes globales de CUDA

#define N_FLAG "-n"

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

// __global__ void test

__global__ void testIfPrimeKernel(int number, bool** result_matrix) {
    // int div = 1;
    // int i = 1;
    bool is_prime = true;
    int i = threadIdx.y;
    int j = threadIdx.x;

    if (j < i && i % j == 0) {
        is_prime = false;
    }

    result_matrix[threadIdx.x][threadIdx.y] = is_prime;
}

bool** test_numbers(int number) {
    bool** result_matrix = (bool**)malloc(sizeof(bool) * pow(number, 2));

    for (int i = 1; i <= 32; i++) {
        
    }

    dim3 threadsPerBlock();
    dim3 blocksPerGrid(number, number);

}

int main(int argc, char** argsv) {
    int max_test_num = get_flag_value(argc, argsv, N_FLAG);
}

