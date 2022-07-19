#include <math.h>
#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MIN_RANKS 3

double const G = 6.67e-11;
int const DELTA_T = 86400;
int const N_STEPS = (365 * 10) - 1;
int const TOTAL_BODIES = 5;

struct vector3d {
    double x;
    double y;
    double z;
};

struct space_body {
    char* name;
    struct vector3d position;
    struct vector3d speed;
    struct vector3d acceleration;
    double mass;
};

void print_body(struct space_body body) {
    printf("%s\n", body.name);
    printf("    Position: %e, %e, %e\n",
           body.position.x,
           body.position.y,
           body.position.z);
    printf("    Speed: %e, %e, %e\n",
           body.speed.x,
           body.speed.y,
           body.speed.z);
    printf("    Acceleration: %e, %e, %e\n",
           body.acceleration.x,
           body.acceleration.y,
           body.acceleration.z);
    printf("    Mass: %e\n", body.mass);
}

double calculate_magnitude(struct vector3d vec_A, struct vector3d vec_B) {
    double i = vec_A.x - vec_B.x;
    double j = vec_A.y - vec_B.y;
    double k = vec_A.z - vec_B.z;

    return sqrt(pow(i, 2) + pow(j, 2) + pow(k, 2));
}

struct vector3d calculate_unitary_vector(struct vector3d vec_A, struct vector3d vec_B) {
    double magnitude = calculate_magnitude(vec_A, vec_B);

    return (struct vector3d){
        (vec_A.x - vec_B.x) / magnitude,
        (vec_A.y - vec_B.y) / magnitude,
        (vec_A.z - vec_B.z) / magnitude,
    };
}

struct space_body calculate_body_prop(struct space_body* bodies, int body_id) {
    struct vector3d new_acceleration = (struct vector3d){0, 0, 0};

    for (int j = 0; j < TOTAL_BODIES; j++) {
        if (body_id == j) continue;

        double F = (bodies[j].mass /
                    pow(calculate_magnitude(
                            bodies[body_id].position,
                            bodies[j].position),
                        2));
        struct vector3d unit_vector = calculate_unitary_vector(
            bodies[body_id].position,
            bodies[j].position);

        new_acceleration.x += -G * F * unit_vector.x;
        new_acceleration.y += -G * F * unit_vector.y;
        new_acceleration.z += -G * F * unit_vector.z;
    }

    struct vector3d new_speed = (struct vector3d){
        new_acceleration.x * DELTA_T + bodies[body_id].speed.x,
        new_acceleration.y * DELTA_T + bodies[body_id].speed.y,
        new_acceleration.z * DELTA_T + bodies[body_id].speed.z};

    struct vector3d new_position = (struct vector3d){
        new_speed.x * DELTA_T + bodies[body_id].position.x,
        new_speed.y * DELTA_T + bodies[body_id].position.y,
        new_speed.z * DELTA_T + bodies[body_id].position.z};

    return (struct space_body){
        bodies[body_id].name,
        new_position,
        new_speed,
        new_acceleration,
        bodies[body_id].mass,
    };
}

void print_bodies(struct space_body* bodies) {
    for (int i = 0; i < TOTAL_BODIES; i++) {
        print_body(bodies[i]);
    }
}

void print_from_center(struct space_body* bodies) {
    for (int i = 1; i < TOTAL_BODIES; i++) {
        printf("%s\n", bodies[i].name);
        printf("    Position: %e, %e, %e\n",
               bodies[i].position.x - bodies[0].position.x,
               bodies[i].position.y - bodies[0].position.y,
               bodies[i].position.z - bodies[0].position.z);
        printf("    Speed: %e, %e, %e\n",
               bodies[i].speed.x - bodies[0].speed.x,
               bodies[i].speed.y - bodies[0].speed.y,
               bodies[i].speed.z - bodies[0].speed.z);
        printf("    Acceleration: %e, %e, %e\n",
               bodies[i].acceleration.x,
               bodies[i].acceleration.y,
               bodies[i].acceleration.z);
    }
}

int main(int argc, char** argsv) {
    int rank, size;
    int body_id;

    MPI_Status status;

    // Inicializar MPI
    MPI_Init(&argc, &argsv);
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    if (size < MIN_RANKS) {
        fprintf(stderr, "Error: Minimun number of ranks is not met.\n%d needed, %d available.\n", MIN_RANKS, size);
        exit(-1);
    }

    // Usamos el rank 0 para hacer de coordinador de todo lo que está pasando
    if (rank == 0) {
        struct space_body* bodies = (struct space_body*)malloc(sizeof(struct space_body) * TOTAL_BODIES);

        bodies[0] = (struct space_body){
            "sun",                       // Name
            (struct vector3d){0, 0, 0},  // Position
            (struct vector3d){0, 0, 0},  // Speed
            (struct vector3d){0, 0, 0},  // Acceleration
            1.989e30,                    // Mass
        };

        bodies[1] = (struct space_body){
            "mercury",                          // Name
            (struct vector3d){57.909e9, 0, 0},  // Position
            (struct vector3d){0, 47.36e3, 0},   // Speed
            (struct vector3d){0, 0, 0},         // Acceleration
            0.33011e24,                         // Mass
        };

        bodies[2] = (struct space_body){
            "venus",                             // Name
            (struct vector3d){108.209e9, 0, 0},  // Position
            (struct vector3d){0, 35.02e3, 0},    // Speed
            (struct vector3d){0, 0, 0},          // Acceleration
            4.8675e24                            // Mass
        };

        bodies[3] = (struct space_body){
            "earth",                             // Name
            (struct vector3d){149.596e9, 0, 0},  // Position
            (struct vector3d){0, 29.78e3, 0},    // Speed
            (struct vector3d){0, 0, 0},          // Acceleration
            5.9724e24                            // Mass
        };

        bodies[4] = (struct space_body){
            "mars",                              // Name
            (struct vector3d){227.923e9, 0, 0},  // Position
            (struct vector3d){0, 24.07e3, 0},    // Speed
            (struct vector3d){0, 0, 0},          // Acceleration
            0.64171e24                           // Mass
        };

        printf("\nCondiciones Iniciales:\n");

        print_bodies(bodies);

        int current_rank = 1;

        for (int time = 0; time < N_STEPS; time++) {
            MPI_Send(&body_id, 1, MPI_INT, current_rank, 10, MPI_COMM_WORLD);
        }

        printf("\nCondiciones Finales:\n");
        print_bodies(bodies);
    } else {
        do {
            MPI_Recv(&body_id, 1, MPI_INT, MPI_ANY_SOURCE, MPI_ANY_TAG, MPI_COMM_WORLD, &status);

            if (body_id == -1) {
                printf("Rank #%d is out.\n", rank);
                break;
            }

        } while (1);
    }

    // Chado MPI
    MPI_Finalize();
    return 0;
}