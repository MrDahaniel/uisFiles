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
int main(int argc, char** argsv) {
    int k;
    float sum, sum2, div, pi, pif;

    sum = 0;
    clock_t start, end;
    int e_iter = get_flag_value(argc, argsv, EULER_FLAG);
    int pi_iter = get_flag_value(argc, argsv, PI_FLAG);
    int x = get_flag_value(argc, argsv, X_FLAG);
    start = clock();

    for (k = 0; k <= e_iter; k++) {
        div = pow(x, k) / tgamma(k + 1);
        sum = sum + div;
    }

    double eulerx = sum;
    int cons = -1;
    int den = 1;
    pi = 0;
    sum2 = 0;

    for (k = 0; k <= pi_iter; k++) {
        pi += pow(cons, k) * ((double)4 / den);
        den += 2;
    }

    pif = pi;

    double eulerxpi = pow(eulerx, pif);

    printf("%f\n", eulerxpi);
    end = clock();

    double stdVal = pow(exp(1), M_PI * x);

    printf("Parameters: \n  x: %d\n  pi_iter: %d\n  e_iter: %d\n", x, pi_iter, e_iter);
    printf("Results: \n  pi: %f\n  e_x: %f\n  final: %f\n", pif, eulerx, eulerxpi);
    printf("Time Elapsed: %d\n", end - start);
    printf("%%Error: %.15f\n", fabs((eulerxpi - stdVal)) / stdVal);

    printf("fact%f\n", tgamma(172));
    return 0;
}