#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "mpi.h"

int main(int argc, char** argsv) {
    // Inicializar MPI
    MPI_Init(&argc, &argsv);

    MPI_Finalize();
    return 0;
}