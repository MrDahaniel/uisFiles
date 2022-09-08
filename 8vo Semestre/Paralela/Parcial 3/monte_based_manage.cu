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

#define BLOCK_SIZE 256
#define THREAD_LIMIT 43008
#define BLOCKS_ON_THREAD_LIMIT THREAD_LIMIT / BLOCK_SIZE

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

__global__ void setupKernel(curandState* state, int seed) {
    int position = threadIdx.x + blockDim.x * blockIdx.x;
    curand_init(seed, position, 0, &state[position]);
}

template <class Function>
__global__ void monteCarloKernel(
    int n_samples, int lower, int upper, Function fn,
    float* d_result, curandState* states) {
    int position = threadIdx.x + blockDim.x * blockIdx.x;
    d_result[position] = fn(frand(lower, upper, position, states));
}

template <class Function>
float monte_carlo(int samples, int lower, int upper, Function fn) {
    /*
        Lo primero a realizar está en redondear la cantidad de números
        de la muestra a un número divisible por el tamaño de los bloques,
        a partir de esto también calcularemos loops. Esto de loops se hace
        con el fin de evadir una limitación respecto a la máxima cantidad
        de threads que podían ser usadas en cada ejecución.

        Básicamente, en el caso de superar las 43008 threads, la ejecución
        del programa daría como resultado 0. No estoy muy seguro de por qué
        pero lo hacía de manera local y en el colab. Entonces, para poder
        realizar la aproximación con más de 43008 threads, tengo que realiar
        el calculo por partes la aproximación. Es decir, de 43008 valores en
        43008 valores hasta alcanzar la sample size deseada. Esto implica un
        overhead terrible debido a la necesidad de lanzar múltiples veces el
        kernel pero es la única manera que encontré de "solucionar" este
        problema. Jaj
    */
    int t_blocks = (int)(ceil((float)samples / BLOCK_SIZE));
    int ceil_terms = t_blocks * BLOCK_SIZE;
    int loops = 1;

    if (ceil_terms > THREAD_LIMIT) {
        loops = (int)(ceil((float)ceil_terms / THREAD_LIMIT));
        t_blocks = BLOCKS_ON_THREAD_LIMIT;
        ceil_terms = THREAD_LIMIT;
    }

    float* aproxMonte = (float*)malloc(sizeof(float) * loops);

    dim3 threadsPerBlock(BLOCK_SIZE);
    dim3 blocksPerGrid(t_blocks);

    /*
        Ya dentro de este for es donde realizo el cálculo de los números
        al igual que al aproximación.
    */

    for (int loop = 0; loop < loops; loop++) {
        curandState* d_state;
        cudaMalloc(&d_state, sizeof(curandState));

        size_t result_size = sizeof(float) * ceil_terms;

        float* d_result;
        cudaMallocManaged(&d_result, result_size);

        /*
            Se definen general los números aleatorios a usar para la
            aproximación.
        */
        setupKernel<<<blocksPerGrid, threadsPerBlock>>>(d_state, rand());

        /*
            Y se evaluan y guardan en este kernel
        */
        monteCarloKernel<<<blocksPerGrid, threadsPerBlock>>>(
            samples, lower, upper, fn, d_result, d_state);

        cudaDeviceSynchronize();

        /*
            se realiza la aproximación de monte carlo
            para esa iteración del loop
        */
        float monteSum = 0;
        for (int i = 0; i < ceil_terms; i++) {
            monteSum += d_result[i];
        }

        cudaFree(d_state);
        cudaFree(d_result);

        aproxMonte[loop] = monteSum / ceil_terms;
    }

    /*
        Y finalmente suman todas los valores de las iteraciones y
        se divide en la cantidad de loops.
    */
    float monteCarlo = 0.0;
    for (int i = 0; i < loops; i++) {
        monteCarlo += aproxMonte[i] / loops;
    }

    double total_terms = loops * ceil_terms;
    printf(
        "loops: %d, blocksPerGrid: %d, threadsPerBlock: %d, totalTerms: %.0f\n",
        loops, t_blocks, BLOCK_SIZE, total_terms);
    return monteCarlo;
}

int main(int argc, char** argsv) {
    srand(time(NULL));

    int n_samples = (int)get_flag_value(argc, argsv, SAMPLES_FLAG);
    int lower_bound = (int)get_flag_value(argc, argsv, LOWER_BOUND_FLAG);
    int upper_bound = (int)get_flag_value(argc, argsv, UPPER_BOUND_FLAG);

    auto fn = [] __device__(float x) { return powf(x, 2); };

    float monteCarlo = monte_carlo(n_samples, lower_bound, upper_bound, fn);

    float theoric = (powf(upper_bound, 3) / 3) - (powf(lower_bound, 3) / 3);
    float error = fabsf(theoric - monteCarlo) / theoric;

    printf("Monte Carlo: %.20f\nError: %.20f\n", monteCarlo, error);
}
