#include <curand.h>
#include <curand_kernel.h>

#include <cmath>
#include <cstdlib>
#include <ctime>
#include <string>

#define SAMPLES_FLAG "-s"
#define LOWER_BOUND_FLAG "-l"
#define UPPER_BOUND_FLAG "-u"

#define BLOCK_SIZE 64

int get_flag_value(int argc, char **argsv, std::string flag) {
    for (int i = 0; i < argc; i++) {
        if (flag.compare(argsv[i]) == 0) {
            return std::stoi(argsv[i + 1]);
        }
    }

    return -1;
}

__device__ float frand(float lower, float upper, int index, curandState *states) {
    return curand_uniform(&(states[index])) * (upper - lower) + lower;
}

__device__ float fn(float x) {
    return powf(x, 2);
}

__global__ void aproxMonteCarloKernel(int n_samples, float *d_result) {
    float integral_aprx = 0;
    for (int i = 0; i < n_samples; i++) {
        if (isnan(d_result[i])) {
            printf("Estalló!!!... %d %f \n", i, d_result[i]);
        } else {
            integral_aprx += d_result[i];
        }
    }
    __syncthreads();
    printf("Monte Carlo: %f", integral_aprx / (float)n_samples);
}

__global__ void setupKernel(curandState *state) {
    int position = threadIdx.x + blockDim.x * blockIdx.x;
    curand_init(1234, position, 0, &state[position]);
}

__global__ void monteCarloKernel(int n_samples, float (*fn)(float), float lower, float upper, float *d_result, curandState *states) {
    int position = threadIdx.x + blockDim.x * blockIdx.x;

    float rand_n = curand_uniform(&(states[position])) * (upper - lower) + lower;

    d_result[position] = powf(rand_n, 2);

    if (isnan(d_result[position])) {
        // printf("Estalló!!!... %d %f \n", i, d_result[i]);
        printf("Postion: %d, rand_n: %f, f(rand_n): %f\n", position, rand_n, d_result[position]);
    }
}

void monte_carlo(int n_samples, float lower, float upper) {
    int grid_size = (int)(ceil((float)n_samples / BLOCK_SIZE));
    n_samples = grid_size * BLOCK_SIZE;

    dim3 threadsPerBlock(BLOCK_SIZE);
    dim3 blocksPerGrid(grid_size);

    curandState *d_state;
    cudaMalloc(&d_state, sizeof(curandState));

    size_t result_size = sizeof(float) * n_samples;
    float *result = (float *)malloc(result_size);
    float *d_result;

    cudaMalloc(&d_result, result_size);

    setupKernel<<<blocksPerGrid, threadsPerBlock>>>(d_state);

    cudaDeviceSynchronize();

    monteCarloKernel<<<blocksPerGrid, threadsPerBlock>>>(n_samples, &fn, lower, upper, d_result, d_state);

    cudaDeviceSynchronize();

    aproxMonteCarloKernel<<<1, 1>>>(n_samples, d_result);

    cudaDeviceSynchronize();

    // cudaMemcpy(result, d_result, result_size, cudaMemcpyDeviceToHost);

    // float integral_aprx = 0;

    // for (int i = 0; i < n_samples; i++) {
    //     integral_aprx += result[i];
    //     printf("result[%d]: %f\n", i, result[i]);
    // }

    // printf("Blocks: %d, Threads: %d\n", grid_size, n_samples);

    // return integral_aprx / (float)n_samples;
}

int main(int argc, char **argsv) {
    int n_samples = (int)get_flag_value(argc, argsv, SAMPLES_FLAG);
    float lower_bound = get_flag_value(argc, argsv, LOWER_BOUND_FLAG);
    float upper_bound = get_flag_value(argc, argsv, UPPER_BOUND_FLAG);

    monte_carlo(n_samples, lower_bound, upper_bound);
}