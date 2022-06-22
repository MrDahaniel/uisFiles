#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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
    int test_num = get_flag_value(argc, argsv, "-n");
    // int test_num = 17;
    int is_prime;

    for (int i = 2; i < test_num; i++) {
        is_prime = 1;

        for (int j = 2; j < test_num; j++) {
            if (i % j == 0 && i != j) {
                is_prime = 0;
                break;
            }
        }

        if (is_prime) {
            printf("%d\n", i);
        }
    }

    return 0;
}