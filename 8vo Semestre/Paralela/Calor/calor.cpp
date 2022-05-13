#include <iostream>
#include <string>
#include <tuple>

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

double* generate_bar(int size, double (*fn)(int, int)) {
    double* bar = (double*)malloc(size * sizeof(double));

    for (int i = 0; i < size; i++) {
        bar[i] = fn(i, 0);
    }

    return bar;
}

double T(int length, int time) {
}

void calculate_step(double* bar) {
}

int main(int argc, char* argsv[]) {
    const std::string size_flag = "-n";
    const std::string time_flag = "-t";
    const std::string steps_flag = "-s";

    int size = get_flag_value(argc, argsv, size_flag);
    int delta = get_flag_value(argc, argsv, time_flag) / get_flag_value(argc, argsv, steps_flag);

    double* bar = generate_bar(size, &T);

    return 0;
}