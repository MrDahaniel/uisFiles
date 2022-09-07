#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <string>

#define T_FLAG "-t"
#define BLOCK_SIZE 1024

int get_flag_value(int argc, char** argsv, std::string flag) {
    for (int i = 0; i < argc; i++) {
        if (flag.compare(argsv[i]) == 0) {
            return std::stoi(argsv[i + 1]);
        }
    }

    return -1;
}

__global__ void piKernel(double* result) {
    int position = threadIdx.x + BLOCK_SIZE * blockIdx.x;
    double const symbol = -1;

    printf("f(rand_n): %d\n", position);

    result[position] = pow(symbol, position) * (4 / (1 + (2 * (double)position)));
}

void calculate_pi(int n_terms) {
    int t_blocks = (int)(ceil(n_terms / BLOCK_SIZE));
    int ceil_terms = t_blocks * BLOCK_SIZE;

    dim3 threadsPerBlock(BLOCK_SIZE);
    dim3 blocksPerGrid(t_blocks);

    size_t result_size = sizeof(double) * ceil_terms;
    double* result = (double*)malloc(result_size);
    double* d_result;

    cudaMalloc(&d_result, result_size);
    piKernel<<<blocksPerGrid, threadsPerBlock>>>(d_result);

    cudaMemcpy(result, d_result, result_size, cudaMemcpyDeviceToHost);

    double pi = 0;
    for (int i = 0; i < ceil_terms; i++) {
        pi += result[i];
    }

    printf("pi: %.20f\n", pi);
}

int main(int argc, char** argsv) {
    calculate_pi(get_flag_value(argc, argsv, T_FLAG));
}
