#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

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

int is_prime(int test_num) {
    int is_prime = 1;

    for (int j = 2; j < test_num; j++) {
        if (test_num % j == 0 && test_num != j) {
            is_prime = 0;
            break;
        }
    }

    return is_prime;
}

int main(int argc, char** argsv) {
    int test_num = get_flag_value(argc, argsv, "-n");
    // int test_num = 17;
    // int is_prime;

    // clock_t begin = clock();

    for (int curr_num = 2; curr_num <= test_num; curr_num++) {
        if (is_prime(curr_num)) {
            printf("Prime found: %d\n", curr_num);
        }
    }

    // clock_t end = clock();
    // double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;

    // printf("Time elapsed: %f ms\n", time_spent);

    return 0;
}