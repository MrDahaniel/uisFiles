#include <curand.h>
#include <curand_kernel.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <string>

#define SAMPLES_FLAG "-s"
#define LOWER_BOUND_FLAG "-l"
#define UPPER_BOUND_FLAG "-u"

#define BLOCK_SIZE 64

int get_flag_value(int argc, char** argsv, std::string flag) {
    for (int i = 0; i < argc; i++) {
        if (flag.compare(argsv[i]) == 0) {
            return std::stoi(argsv[i + 1]);
        }
    }

    return -1;
}

__device__ float frand(int lower, int upper, int index, curandState* states) {
    return curand_uniform(&(states[index])) * (upper - lower) + lower;
}

__global__ void setupKernel(curandState* state) {
    int position = threadIdx.x + blockDim.x * blockIdx.x;
    curand_init(1234, position, 0, &state[position]);
}

__global__ void monteCarloKernel(int n_samples, int lower, int upper, float* d_result, curandState* states) {
    int position = threadIdx.x + blockDim.x * blockIdx.x;

    // float n_rand = frand(lower, upper, position, states);
    // float n_rand = curand_uniform(&(states[position])) * (upper - lower) + lower;
    float n_rand = curand_uniform(&(states[position]));

    d_result[position] = powf(n_rand, 2);

    printf("Postion: %d, rand_n: %f, f(rand_n): %f\n", position, n_rand, d_result[position]);
}

void monte_carlo(int samples, int lower, int upper) {
    int t_blocks = (int)(ceil((float)samples / BLOCK_SIZE));
    int ceil_terms = t_blocks * BLOCK_SIZE;

    dim3 threadsPerBlock(BLOCK_SIZE);
    dim3 blocksPerGrid(t_blocks);

    curandState* d_state;
    cudaMalloc(&d_state, sizeof(curandState) * 2);

    size_t result_size = sizeof(float) * ceil_terms * 2;
    float* result = (float*)malloc(result_size);
    float* d_result;

    cudaMalloc(&d_result, result_size);

    setupKernel<<<blocksPerGrid, threadsPerBlock>>>(d_state);
    monteCarloKernel<<<blocksPerGrid, threadsPerBlock>>>(samples, lower, upper, d_result, d_state);

    cudaMemcpy(result, d_result, result_size, cudaMemcpyDeviceToHost);

    float aproxMonte = 0;
    for (int i = 0; i < ceil_terms; i++) {
        aproxMonte += result[i];
        printf("Result[%d]: %f\n", i, result[i]);
    }

    printf("Monte Carlo: %.20f\n", aproxMonte / ceil_terms);
}

int main(int argc, char** argsv) {
    int n_samples = (int)get_flag_value(argc, argsv, SAMPLES_FLAG);
    int lower_bound = (int)get_flag_value(argc, argsv, LOWER_BOUND_FLAG);
    int upper_bound = (int)get_flag_value(argc, argsv, UPPER_BOUND_FLAG);

    monte_carlo(n_samples, lower_bound, upper_bound);
}
