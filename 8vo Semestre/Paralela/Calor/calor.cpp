#include <iostream>
#include <string>
#include <tuple>

int SIZE, STEPS, TIME;
int NEIGHBOURS = 2;

int get_flag_value(int argc, char* argsv[], std::string flag) {
    bool arg = false;
    int n = -1;

    for (int i = 0; i < argc; i++) {
        if (flag.compare(argsv[i]) == 0 && !arg) {
            n = std::stoi(argsv[i + 1]);
            arg = true;
        } else {
            continue;
        }
    }

    if (n == -1) {
        throw std::invalid_argument("Missing size flag");
    }

    return n;
}

double* generate_bar(double (*fn)(int, double)) {
    double* bar = (double*)malloc(SIZE * sizeof(double));

    for (int i = 0; i < SIZE; i++) {
        bar[i] = fn(i, 0);
    }

    return bar;
}

double* calculate_next_bar(double* bar) {
    double* new_bar = (double*)malloc(SIZE * sizeof(double));

    for (int i = 0; i < SIZE; i++) {
        new_bar[i] = (bar[i - 1] + bar[i + 1]) / NEIGHBOURS;
    }

    free(bar);

    return new_bar;
}

double* simulate_bar(double* bar, double (*fn)(int, double)) {
    double* simu_bar = bar;

    const double delta = TIME / STEPS;
    double cur_time = 0;

    for (int i = 0; i < STEPS; i++) {
        cur_time += delta;

        simu_bar = calculate_next_bar(simu_bar);

        for (int j = 0; j < SIZE; j++) {
            double fn_defd = fn(j, cur_time);
            if (fn_defd > 0) {
                simu_bar[j] = fn_defd;
            }
        }
    }

    return simu_bar;
}

double T(int length, double _time) {
    const int MAX_TEMP = 100;
    const int MIN_TEMP = 0;

    if (length == 0 || length == SIZE - 1) {
        // returns the max temp
        return MAX_TEMP;
    } else {
        // returns the min temp, in this case 0
        return MIN_TEMP;
    }
}

void print_bar(double* bar) {
    for (int i = 0; i < SIZE; i++) {
        printf("%f ", bar[i]);
    }
    printf("\n");
}

int main(int argc, char* argsv[]) {
    const std::string size_flag = "-n";
    const std::string time_flag = "-t";
    const std::string steps_flag = "-s";

    SIZE = get_flag_value(argc, argsv, size_flag);
    TIME = get_flag_value(argc, argsv, time_flag);
    STEPS = get_flag_value(argc, argsv, steps_flag);

    double* bar = generate_bar(&T);

    printf("%s\n    ", "Initial Bar:");
    print_bar(bar);

    printf("%s\n    ", "Final Bar");
    print_bar(simulate_bar(bar, &T));

    return 0;
}