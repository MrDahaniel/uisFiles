#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <string>

// Definimos las constantes globales de CUDA

#define N_FLAG "-n"
#define BLOCK_SIZE 32

int get_flag_value(int argc, char** argsv, std::string flag) {
    bool arg = false;
    int n = -1;

    for (int i = 0; i < argc; i++) {
        if (flag.compare(argsv[i]) == 0 && !arg) {
            n = std::stoi(argsv[i + 1]);
            arg = true;
        } else {
            continue;
        }
    }

    return n;
}

// __global__ void test

__global__ void testIfPrimeKernel(int number, bool** result_matrix) {
    // int div = 1;
    // int i = 1;
    bool is_prime = true;
    int i = threadIdx.y + 1;
    int j = threadIdx.x + 1;

    if (j < i && i % j == 0) {
        is_prime = false;
    }

    printf("darn");

    result_matrix[threadIdx.x][threadIdx.y] = is_prime;
}

void test_numbers(int number) {
    int new_number = ceil(number % BLOCK_SIZE) * BLOCK_SIZE;
    int grid_size = ceil(number / BLOCK_SIZE);

    dim3 threadsPerBlock(BLOCK_SIZE, BLOCK_SIZE);
    dim3 blocksPerGrid(grid_size, grid_size);

    size_t result_matrix_size = sizeof(bool) * pow(number, 2);
    bool** d_result_matrix;

    cudaMalloc(&d_result_matrix, result_matrix_size);

    testIfPrimeKernel<<<blocksPerGrid, threadsPerBlock>>>(new_number, d_result_matrix);

    bool** result_matrix = (bool**)malloc(result_matrix_size);
    cudaMemcpy(result_matrix, d_result_matrix, result_matrix_size, cudaMemcpyDeviceToHost);

    for (int i = 0; i < new_number; i++) {
        bool is_prime = true;

        for (int j = 0; j <= i; j++) {
            if (!result_matrix[j][i]) {
                is_prime = false;
                break;
            }
        }

        if (is_prime) {
            printf("%d is prime", i + 1);
        }
    }
}

int main(int argc, char** argsv) {
    int max_test_num = get_flag_value(argc, argsv, N_FLAG);

    test_numbers(max_test_num);
}
