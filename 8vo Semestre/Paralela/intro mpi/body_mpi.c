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

typedef struct vector3d {
    double x;
    double y;
    double z;
} vector3d;

typedef struct space_body {
    int id;
    struct vector3d position;
    struct vector3d speed;
    struct vector3d acceleration;
    double mass;
} space_body;

void print_body(space_body body) {
    printf("%d\n", body.id);
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

double calculate_magnitude(vector3d vec_A, vector3d vec_B) {
    double i = vec_A.x - vec_B.x;
    double j = vec_A.y - vec_B.y;
    double k = vec_A.z - vec_B.z;

    return sqrt(pow(i, 2) + pow(j, 2) + pow(k, 2));
}

vector3d calculate_unitary_vector(vector3d vec_A, vector3d vec_B) {
    double magnitude = calculate_magnitude(vec_A, vec_B);

    return (vector3d){
        (vec_A.x - vec_B.x) / magnitude,
        (vec_A.y - vec_B.y) / magnitude,
        (vec_A.z - vec_B.z) / magnitude,
    };
}

space_body calculate_body_prop(space_body* bodies, int body_id) {
    vector3d new_acceleration = (vector3d){0, 0, 0};

    for (int j = 0; j < TOTAL_BODIES; j++) {
        if (body_id == j) continue;

        double F = bodies[j].mass /
                   pow(calculate_magnitude(
                           bodies[body_id].position,
                           bodies[j].position),
                       2);
        vector3d unit_vector = calculate_unitary_vector(
            bodies[body_id].position,
            bodies[j].position);

        new_acceleration.x += -G * F * unit_vector.x;
        new_acceleration.y += -G * F * unit_vector.y;
        new_acceleration.z += -G * F * unit_vector.z;
    }

    vector3d new_speed = (vector3d){
        new_acceleration.x * DELTA_T + bodies[body_id].speed.x,
        new_acceleration.y * DELTA_T + bodies[body_id].speed.y,
        new_acceleration.z * DELTA_T + bodies[body_id].speed.z,
    };

    vector3d new_position = (vector3d){
        new_speed.x * DELTA_T + bodies[body_id].position.x,
        new_speed.y * DELTA_T + bodies[body_id].position.y,
        new_speed.z * DELTA_T + bodies[body_id].position.z,
    };

    return (space_body){
        bodies[body_id].id,
        new_position,
        new_speed,
        new_acceleration,
        bodies[body_id].mass,
    };
}

void print_bodies(space_body* bodies) {
    for (int i = 0; i < TOTAL_BODIES; i++) {
        print_body(bodies[i]);
    }
}

void print_from_center(space_body* bodies) {
    for (int i = 1; i < TOTAL_BODIES; i++) {
        printf("%d\n", bodies[i].id);
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

    // if (size < MIN_RANKS) {
    //     fprintf(stderr, "Error: Minimun number of ranks is not met.\n%d needed, %d available.\n", MIN_RANKS, size);
    //     exit(-1);
    // }

    const int n_items_vector = 3;
    int blocklength_vector[3] = {1, 1, 1};

    MPI_Datatype types_vector[3] = {MPI_DOUBLE, MPI_DOUBLE, MPI_DOUBLE};
    MPI_Datatype MPI_vector_3d;

    MPI_Aint offsets_vector[3];
    offsets_vector[0] = offsetof(vector3d, x);
    offsets_vector[1] = offsetof(vector3d, y);
    offsets_vector[3] = offsetof(vector3d, z);

    MPI_Type_create_struct(n_items_vector, blocklength_vector, offsets_vector, types_vector, &MPI_vector_3d);
    MPI_Type_commit(&MPI_vector_3d);

    const int n_items_body = 5;
    int blocklength_body[5] = {1, 1, 1, 1, 1};

    MPI_Datatype types_body[5] = {MPI_INT, MPI_vector_3d, MPI_vector_3d, MPI_vector_3d, MPI_DOUBLE};
    MPI_Datatype MPI_space_body;

    MPI_Aint offsets_body[5];
    offsets_body[0] = offsetof(space_body, id);
    offsets_body[1] = offsetof(space_body, position);
    offsets_body[2] = offsetof(space_body, speed);
    offsets_body[3] = offsetof(space_body, acceleration);
    offsets_body[4] = offsetof(space_body, mass);

    MPI_Type_create_struct(n_items_body, blocklength_body, offsets_body, types_body, &MPI_space_body);
    MPI_Type_commit(&MPI_space_body);

    // Usamos el rank 0 para hacer de coordinador de todo lo que está pasando
    space_body* bodies = (space_body*)malloc(sizeof(space_body) * TOTAL_BODIES);
    space_body body;

    // printf("rank %d is active!\n", rank);

    if (rank == 0) {
        bodies[0] = (space_body){
            0,                    // id
            (vector3d){0, 0, 0},  // Position
            (vector3d){0, 0, 0},  // Speed
            (vector3d){0, 0, 0},  // Acceleration
            1.989e30,             // Mass
        };

        bodies[1] = (space_body){
            1,                           // id
            (vector3d){57.909e9, 0, 0},  // Position
            (vector3d){0, 47.36e3, 0},   // Speed
            (vector3d){0, 0, 0},         // Acceleration
            0.33011e24,                  // Mass
        };

        bodies[2] = (space_body){
            2,                            // id
            (vector3d){108.209e9, 0, 0},  // Position
            (vector3d){0, 35.02e3, 0},    // Speed
            (vector3d){0, 0, 0},          // Acceleration
            4.8675e24                     // Mass
        };

        bodies[3] = (space_body){
            3,                            // id
            (vector3d){149.596e9, 0, 0},  // Position
            (vector3d){0, 29.78e3, 0},    // Speed
            (vector3d){0, 0, 0},          // Acceleration
            5.9724e24                     // Mass
        };

        bodies[4] = (space_body){
            4,                            // id
            (vector3d){227.923e9, 0, 0},  // Position
            (vector3d){0, 24.07e3, 0},    // Speed
            (vector3d){0, 0, 0},          // Acceleration
            0.64171e24                    // Mass
        };

        // printf("\nCondiciones Iniciales:\n");

        // print_bodies(bodies);

        int current_rank = 1;

        for (int time = 1; time < N_STEPS; time++) {
            // printf("Sending stage...\n");

            for (body_id = 0; body_id < TOTAL_BODIES; body_id++) {
                MPI_Send(&body_id, 1, MPI_INT, current_rank, 10, MPI_COMM_WORLD);

                // printf("\n\nRank %d sent Rank %d body_id %d\n\n", rank, current_rank, body_id);

                MPI_Send(bodies, TOTAL_BODIES, MPI_space_body, current_rank, 10, MPI_COMM_WORLD);

                current_rank++;

                if (current_rank >= size) {
                    current_rank = 1;
                }
            }

            // printf("Reciving stage...\n");
            for (body_id = 1; body_id < TOTAL_BODIES; body_id++) {
                MPI_Recv(&body, 1, MPI_space_body, MPI_ANY_SOURCE, MPI_ANY_TAG, MPI_COMM_WORLD, &status);

                bodies[body.id] = body;
            }
        }

        for (int rank_id = 1; rank_id < size; rank_id++) {
            const int end_signal = -1;

            MPI_Send(&end_signal, 1, MPI_INT, rank_id, 10, MPI_COMM_WORLD);
        }

        printf("\nCondiciones Finales:\n");
        print_bodies(bodies);
    } else {
        do {
            MPI_Recv(&body_id, 1, MPI_INT, 0, MPI_ANY_TAG, MPI_COMM_WORLD, &status);

            if (body_id == -1) {
                // printf("Rank #%d is out.\n", rank);
                break;
            }

            MPI_Recv(bodies, TOTAL_BODIES, MPI_space_body, 0, MPI_ANY_TAG, MPI_COMM_WORLD, &status);

            // printf("\n\nRank %d recv body_id = %d\n\n", rank, bodies[body_id].id);

            body = calculate_body_prop(bodies, body_id);

            MPI_Send(&body, 1, MPI_space_body, 0, 10, MPI_COMM_WORLD); } while (1); }

    // Chado MPI
    MPI_Finalize();
    return 0;
}