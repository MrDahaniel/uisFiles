#include <ctime>
#include <iostream>
#include <string>
#include <vector>

void print_matrix(std::vector<int> matrix, int size) {
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            printf("%d  ", matrix[i + j * size]);
        }
        printf("\n");
    }

    printf("\n");
}

std::vector<int> generate_matrix(int size) {
    int line_size = size * size;

    std::vector<int> matrix(line_size, 0);

    for (int i = 0; i < line_size; i++) {
        matrix[i] = std::rand() % 10;
    }

    return matrix;
}

int get_matrix_size(int argc, char *argsv[]) {
    const std::string n_flag = "-n";

    bool n_arg = false;
    int n = -1;

    for (int i = 0; i < argc; i++) {
        if (n_flag.compare(argsv[i]) == 0 && !n_arg) {
            n = std::stoi(argsv[i + 1]);
            n_arg = true;
        } else {
            continue;
        }
    }

    return n;
}

int main(int argc, char *argsv[]) {
    std::srand((unsigned int)time(NULL));

    int n = get_matrix_size(argc, argsv);

    std::vector<int> matrix_a = generate_matrix(n);
    std::vector<int> matrix_b = generate_matrix(n);

    print_matrix(matrix_a, n);
    print_matrix(matrix_b, n);
}
