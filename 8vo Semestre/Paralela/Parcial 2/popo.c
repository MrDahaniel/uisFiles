#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

int main(int argc, char** argsv) {
    int k, x = 1;
    float sum, sum2, div, pi, pif;

    sum = 0;
    clock_t start, end;

    for (k = 0; k <= 1000; k++) {
        div = pow(x, k) / tgamma(k + 1);
        sum = sum + div;
    }

    double eulerx = sum;
    pi = 0;
    sum2 = 0;

    for (k = 0; k <= 1000; k++) {
        sum2 = pow(-1, k) * (1 / ((2 * k) + 1));
        pi = pi + sum2;
    }

    pif = 4 * pi;

    double eulerxpi = pow(eulerx, pif);

    printf("%f\n", eulerxpi);
}