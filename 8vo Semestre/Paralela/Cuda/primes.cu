#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <cmath>
#include <string>
#include <tuple>

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

__global__ void testIfPrimeKernel(int number, bool* result_matrix) {
    int x_idx, y_idx;
    int position = threadIdx.x + blockIdx.x * BLOCK_SIZE + 1;

    float p = (sqrtf(1 + 8 * position) - 1) / 2;
    double i0 = floor(p);

    if (i0 == p) {
        x_idx = i0;
        y_idx = i0;
    } else {
        x_idx = i0 + 1;
        y_idx = position - i0 * (i0 + 1) / 2;
    }

    x_idx -= 1;
    y_idx -= 1;

    // int kp = (BLOCK_SIZE * (BLOCK_SIZE + 1) / 2) - position;
    // int p = floor((sqrtf(1 + 8 * kp) - 1) / 2);
    // x_idx = BLOCK_SIZE - (kp - p * (p + 1) / 2);
    // y_idx = x_idx + 1 - (BLOCK_SIZE - p);

    printf("%d - (%d, %d)\n", position, x_idx, y_idx);

    result_matrix[x_idx * BLOCK_SIZE + y_idx] = true;

    if (x_idx > y_idx && y_idx != 1 && y_idx != 0 && x_idx % y_idx == 0) {
        result_matrix[x_idx * number + y_idx] = false;
    }
}

void test_numbers(int number) {
    int new_number = (int)(ceil((double)number / BLOCK_SIZE)) * BLOCK_SIZE;
    int tringular_size = (new_number * (new_number + 1) / 2);
    int grid_size = (int)(ceil((double)tringular_size / BLOCK_SIZE));

    printf("num: %d, t size: %d, grid: %d\n", new_number, tringular_size, grid_size);

    dim3 threadsPerBlock(BLOCK_SIZE);
    dim3 blocksPerGrid(grid_size);

    size_t result_matrix_size = sizeof(bool) * (tringular_size);
    bool* d_result_matrix;

    cudaMalloc(&d_result_matrix, result_matrix_size);

    testIfPrimeKernel<<<blocksPerGrid, threadsPerBlock>>>(new_number, d_result_matrix);

    bool* result_matrix = (bool*)malloc(result_matrix_size);

    cudaMemcpy(result_matrix, d_result_matrix, result_matrix_size, cudaMemcpyDeviceToHost);

    for (int i = 0; i < new_number; i++) {
        for (int j = 0; j < i; j++) {
            printf("%d ", result_matrix[i * new_number + j]);
        }
        printf(" - %d \n", i);
    }

    for (int i = 0; i <= number; i++) {
        bool is_prime = true;

        for (int j = 0; j <= i; j++) {
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
