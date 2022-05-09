#include <chrono>
#include <ctime>
#include <iostream>
#include <stdexcept>
#include <string>
#include <variant>
#include <vector>

// Esto es algo curseado, sí, pero es para hacer overload
// básicamente los estoy usando como atoms de Elixir

enum Malloc {};
enum New {};
enum Vec {};
enum VecVec {};

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

std::string get_implementation(int argc, char *argsv[]) {
    const std::string i_flag = "-i";

    bool i_arg = false;
    std::string imp;

    for (int i = 0; i < argc; i++) {
        if (i_flag.compare(argsv[i]) == 0 && !i_arg) {
            imp = argsv[i + 1];
            i_arg = true;
        } else {
            continue;
        }
    }

    return imp;
}

// We overloading bois
// Yes, I know this is cursed

int *generate_matrix(int size, Malloc _) {
    int *matrix = (int *)malloc(size * size * sizeof(int));

    for (int i = 0; i < size * size; i++) {
        matrix[i] = std::rand() % 10;
    }

    return matrix;
}

int *generate_matrix(int size, New _) {
    int *matrix = new int[size * size];

    for (int i = 0; i < size * size; i++) {
        matrix[i] = std::rand() % 10;
    }

    return matrix;
}

std::vector<int> generate_matrix(int size, Vec _) {
    std::vector<int> matrix(size * size, 0);

    for (int i = 0; i < size * size; i++) {
        matrix[i] = std::rand() % 10;
    }

    return matrix;
}

std::vector<std::vector<int>> generate_matrix(int size, VecVec _) {
    std::vector<std::vector<int>> matrix(size, std::vector<int>(size, 0));

    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            matrix[i][j] = std::rand() % 10;
        }
    }

    return matrix;
}

int *multiply_matrix(int *matrix_a, int *matrix_b, int size, Malloc _) {
    int *result_matrix = (int *)malloc(size * size * sizeof(int));

    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            for (int k = 0; k < size; k++) {
                result_matrix[i + j * size] += matrix_a[i + k * size] * matrix_b[k + j * size];
            }
        }
    }

    return result_matrix;
}

int *multiply_matrix(int *matrix_a, int *matrix_b, int size, New _) {
    int *result_matrix = new int[size * size];

    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            for (int k = 0; k < size; k++) {
                result_matrix[i + j * size] += matrix_a[i + k * size] * matrix_b[k + j * size];
            }
        }
    }

    return result_matrix;
}

std::vector<int> multiply_matrix(std::vector<int> matrix_a, std::vector<int> matrix_b, int size, Vec _) {
    std::vector<int> result_matrix(size * size, 0);

    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            for (int k = 0; k < size; k++) {
                result_matrix[i + j * size] += matrix_a[i + k * size] * matrix_b[k + j * size];
            }
        }
    }

    return result_matrix;
}

std::vector<std::vector<int>> multiply_matrix(std::vector<std::vector<int>> matrix_a, std::vector<std::vector<int>> matrix_b, int size, VecVec _) {
    std::vector<std::vector<int>> result_matrix(size, std::vector<int>(size, 0));

    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            for (int k = 0; k < size; k++) {
                result_matrix[i][j] += matrix_a[i][k] * matrix_b[k][j];
            }
        }
    }

    return result_matrix;
}

void print_matrix(int *matrix, int size) {
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            printf("%d  ", matrix[i + j * size]);
        }
        printf("\n");
    }
    printf("\n");
}

void print_matrix(std::vector<int> matrix, int size) {
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            printf("%d  ", matrix[i + j * size]);
        }
        printf("\n");
    }
    printf("\n");
}

void print_matrix(std::vector<std::vector<int>> matrix, int size) {
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            printf("%d  ", matrix[i][j]);
        }
        printf("\n");
    }
    printf("\n");
}

int main(int argc, char *argsv[]) {
    std::srand((unsigned int)time(NULL));

    auto t1 = std::chrono::high_resolution_clock::now();
    /* Getting number of milliseconds as an integer. */

    if (argc <= 1) {
        throw std::invalid_argument("Missing flags on call");
    }

    int matrix_size = get_matrix_size(argc, argsv);
    std::string impl_str = get_implementation(argc, argsv);

    // Te maldigo std::variant por ser la cosa más curseada de esta vida y
    // no funcionar como los wrappers de Rust

    if (impl_str.compare("malloc") == 0) {
        Malloc impl;

        multiply_matrix(
            generate_matrix(matrix_size, impl),
            generate_matrix(matrix_size, impl),
            matrix_size,
            impl);

    } else if (impl_str.compare("new") == 0) {
        New impl;

        multiply_matrix(
            generate_matrix(matrix_size, impl),
            generate_matrix(matrix_size, impl),
            matrix_size,
            impl);

    } else if (impl_str.compare("vec") == 0) {
        Vec impl;

        multiply_matrix(
            generate_matrix(matrix_size, impl),
            generate_matrix(matrix_size, impl),
            matrix_size,
            impl);

    } else if (impl_str.compare("vecvec") == 0) {
        VecVec impl;

        multiply_matrix(
            generate_matrix(matrix_size, impl),
            generate_matrix(matrix_size, impl),
            matrix_size,
            impl);
    }

    auto t2 = std::chrono::high_resolution_clock::now();

    auto ms_int = std::chrono::duration_cast<std::chrono::milliseconds>(t2 - t1);

    printf("Execution time: %d\n", ms_int);

    return 0;
}
