#include <string>

#include "aux.cuh"
#include "stdio.h"
#include "stdlib.h"

using namespace std;

// Definimos las constantes globales
#define G 6.67e-11
#define DELTA_T 86400
#define N_STEPS 3649
#define TOTAL_BODIES 2

// Definimos las constantes globales de CUDA
#define BLOCK_SIZE 1

typedef struct SpaceBody {
    int name;
    double3 acceleration;
    double3 speed;
    double3 position;
    double mass;

    void print() {
        printf("%d\n", name);
        printf("    Acceleration: %e, %e, %e\n",
               acceleration.x,
               acceleration.y,
               acceleration.z);
        printf("    Speed: %e, %e, %e\n",
               speed.x,
               speed.y,
               speed.z);
        printf("    Position: %e, %e, %e\n",
               position.x,
               position.y,
               position.z);
        printf("    Mass: %e\n", mass);
    }
} SpaceBody;

// Is this the kernel? Not sure...

__global__ void bodyNextStepKernel(SpaceBody* space_bodies, int num_bodies) {
    int id = blockDim.x * blockIdx.x + threadIdx.x;

    for (int i = 0; i < num_bodies; i++) {
        if (space_bodies[id].name == space_bodies[i].name) {
            continue;
        }

        double3 acc = (double3){0, 0, 0};

        double f =
            space_bodies[i].mass / pow(aux::magnitude_between_points(space_bodies[id].position, space_bodies[i].position), 2);
        double3 unit_vec = aux::get_unitary_vector(space_bodies[id].position, space_bodies[i].position);

        acc.x += -G * f * unit_vec.x;
        acc.y += -G * f * unit_vec.y;
        acc.z += -G * f * unit_vec.z;

        space_bodies[id].acceleration = acc;
    }

    space_bodies[id].speed.x += space_bodies[id].acceleration.x * DELTA_T;
    space_bodies[id].speed.y += space_bodies[id].acceleration.y * DELTA_T;
    space_bodies[id].speed.z += space_bodies[id].acceleration.z * DELTA_T;

    space_bodies[id].position.x += space_bodies[id].speed.x * DELTA_T;
    space_bodies[id].position.y += space_bodies[id].speed.y * DELTA_T;
    space_bodies[id].position.z += space_bodies[id].speed.z * DELTA_T;
}

SpaceBody* init_bodies() {
    SpaceBody* bodies = new SpaceBody[TOTAL_BODIES];

    bodies[0] = SpaceBody{
        0,
        double3{0, 0, 0},
        double3{0, 0, 0},
        double3{0, 0, 0},
        1.989e30,
    };

    bodies[1] = SpaceBody{
        1,
        double3{0, 0, 0},
        double3{0, 47.36e3, 0},
        double3{57.909e9, 0, 0},
        3.3011e23,
    };

    return bodies;
}

SpaceBody* simulate(SpaceBody* space_bodies) {
    // Sacamos la cantidad de cuerpos
    // size_t space_body_size = sizeof(SpaceBody);
    size_t space_bodies_size = sizeof(SpaceBody) * TOTAL_BODIES;

    // Definiendo cosas de cuda, esto no es lo más eficiente pero sólo
    // tenemos 5 cuerpos y eso no es divisible bonito
    dim3 threadsPerBlock(TOTAL_BODIES);
    dim3 numBlocks(1);

    // cargamos los cuerpos en el device, ¿creo?
    SpaceBody* d_space_bodies;
    cudaMalloc(&d_space_bodies, space_bodies_size);
    cudaMemcpy(d_space_bodies, space_bodies, space_bodies_size, cudaMemcpyHostToDevice);

    for (int step = 0; step <= N_STEPS; step++) {
        bodyNextStepKernel<<<numBlocks, threadsPerBlock>>>(d_space_bodies, TOTAL_BODIES);
    }

    // Recuperamos los valores calculados
    SpaceBody* new_bodies = new SpaceBody[TOTAL_BODIES];

    cudaMemcpy(new_bodies, d_space_bodies, space_bodies_size, cudaMemcpyDeviceToHost);

    return new_bodies;
}

int main(int argc, char const* argv[]) {
    SpaceBody* space_bodies = init_bodies();
    SpaceBody* new_body = simulate(space_bodies);

    for (int i = 0; i < TOTAL_BODIES; i++) {
        new_body[i].print();
    }

    return 0;
}
