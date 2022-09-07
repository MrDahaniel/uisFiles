#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define SAMPLES_FLAG "-s"
#define LOWER_BOUND_FLAG "-l"
#define UPPER_BOUND_FLAG "-u"

double get_flag_value(int argc, char** argsv, char* flag) {
    for (int i = 0; i < argc; i++) {
        if (strcmp(argsv[i], flag) == 0) {
            return atof(argsv[i + 1]);
        }
    }

    return -1;
}

double fn(double x) {
    return powf(x, 2);
}

double frand(double lower, double upper) {
    return (rand() / (double)RAND_MAX) * (upper - lower) + lower;
}

double monte_carlo(double (*fn)(double), int n_samples, double lower, double upper) {
    double sum_evaluated = 0.0;

    for (int i = 0; i < n_samples; i++) {
        double rand_n = frand(lower, upper);
        sum_evaluated += fn(rand_n);
    }

    return sum_evaluated / n_samples;
}

int main(int argc, char** argsv) {
    // Initialize the random number generator
    srand(time(NULL));

    int n_samples = (int)get_flag_value(argc, argsv, SAMPLES_FLAG);
    double lower_bound = get_flag_value(argc, argsv, LOWER_BOUND_FLAG);
    double upper_bound = get_flag_value(argc, argsv, UPPER_BOUND_FLAG);

    printf("Monte Carlo: %f\n", monte_carlo(&fn, n_samples, lower_bound, upper_bound));
}