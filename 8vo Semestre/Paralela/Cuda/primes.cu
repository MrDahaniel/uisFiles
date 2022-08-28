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

__global__ void testIfPrimeKernel(int number, bool* result_matrix) {
    int x_idx = BLOCK_SIZE * blockIdx.x + threadIdx.x;
    int y_idx = BLOCK_SIZE * blockIdx.y + threadIdx.y;

    int i = x_idx + 2;
    int j = y_idx + 2;

    result_matrix[x_idx * number + y_idx] = true;

    if (i > j && i % j == 0) {
        result_matrix[i * number + j] = false;
    } else {
        return;
    }
}

void test_numbers(int number) {
    int new_number = (double)(ceil((double)number / BLOCK_SIZE)) * 32;
    int grid_size = (double)(ceil((double)number / BLOCK_SIZE));

    dim3 threadsPerBlock(BLOCK_SIZE, BLOCK_SIZE);
    dim3 blocksPerGrid(grid_size, grid_size);

    size_t result_matrix_size = sizeof(bool) * pow(new_number, 2);
    bool* d_result_matrix;

    cudaMalloc(&d_result_matrix, result_matrix_size);

    testIfPrimeKernel<<<blocksPerGrid, threadsPerBlock>>>(new_number, d_result_matrix);

    bool* result_matrix = (bool*)malloc(result_matrix_size);

    cudaMemcpy(result_matrix, d_result_matrix, result_matrix_size, cudaMemcpyDeviceToHost);

    for (int i = 2; i <= new_number; i++) {
        bool is_prime = true;

        for (int j = 2; j <= i; j++) {
            if (!result_matrix[i * new_number + j]) {
                is_prime = false;
                break;
            }
        }

        if (is_prime) {
            printf("%d is prime\n", i);
        }
    }
}

int main(int argc, char** argsv) {
    int max_test_num = get_flag_value(argc, argsv, N_FLAG);

    test_numbers(max_test_num);
}
