
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define M_PI 3.14159265358979323846  // Esto está definido en el math.h así, no se puede acceder a esto desde C porque ????? entonces, sí
#define EULER_FLAG "-e"
#define PI_FLAG "-p"
#define X_FLAG "-x"

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

double calculate_pi(int iterations) {
    double const operator=(-1);
    double denominator = 1;

    double pi = 0;

    for (int i = 0; i < iterations; i++) {
        pi += pow(operator, i) * (4 / denominator);
        denominator += 2;
    }

    return pi;
}

double calculate_e_pow_x(double x, int iterations) {
    double e_x = 0;

    for (int k = 0; k < iterations; k++) {
        e_x += pow(x, k) / tgamma(k + 1);
    }

    return e_x;
}

int main(int argc, char** argsv) {
    clock_t start, end;

    int e_iter = get_flag_value(argc, argsv, EULER_FLAG);
    int pi_iter = get_flag_value(argc, argsv, PI_FLAG);
    int x = get_flag_value(argc, argsv, X_FLAG);

    start = clock();

    double e_x = calculate_e_pow_x(x, e_iter);
    double pi = calculate_pi(pi_iter);
    double e_x_pi = pow(e_x, pi);

    end = clock();

    double std_val = pow(exp(1), M_PI * x);

    printf("Parameters: \n  x: %d\n  pi_iter: %d\n  e_iter: %d\n", x, pi_iter, e_iter);
    printf("Results: \n  pi: %f\n  e_x: %f\n  final: %f\n", pi, e_x, e_x_pi);
    printf("Time Elapsed: %d\n", end - start);
    printf("%%Error: %.15f\n", fabs((e_x_pi - std_val)) / std_val);

    return 0;
}