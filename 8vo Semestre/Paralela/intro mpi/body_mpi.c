#include <math.h>
#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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

void calculate_accelerations(struct space_body* bodies) {
    for (int i = 0; i < TOTAL_BODIES; i++) {
        bodies[i].acceleration.x = 0;
        bodies[i].acceleration.y = 0;
        bodies[i].acceleration.z = 0;

        for (int j = 0; j < TOTAL_BODIES; j++) {
            if (i == j) continue;

            double F = (bodies[j].mass /
                        pow(calculate_magnitude(
                                bodies[i].position,
                                bodies[j].position),
                            2));

            struct vector3d unit_vector = calculate_unitary_vector(
                bodies[i].position,
                bodies[j].position);

            bodies[i].acceleration.x += -G * F * unit_vector.x;
            bodies[i].acceleration.y += -G * F * unit_vector.y;
            bodies[i].acceleration.z += -G * F * unit_vector.z;
        }
    }

    return;
}

void update_speeds(struct space_body* bodies) {
    for (int i = 0; i < TOTAL_BODIES; i++) {
        bodies[i].speed.x = bodies[i].acceleration.x * DELTA_T + bodies[i].speed.x;
        bodies[i].speed.y = bodies[i].acceleration.y * DELTA_T + bodies[i].speed.y;
        bodies[i].speed.z = bodies[i].acceleration.z * DELTA_T + bodies[i].speed.z;
    }
}

void update_positions(struct space_body* bodies) {
    for (int i = 0; i < TOTAL_BODIES; i++) {
        bodies[i].position.x = bodies[i].speed.x * DELTA_T + bodies[i].position.x;
        bodies[i].position.y = bodies[i].speed.y * DELTA_T + bodies[i].position.y;
        bodies[i].position.z = bodies[i].speed.z * DELTA_T + bodies[i].position.z;
    }
}

void pass_time(struct space_body* bodies, int n_delta_ts) {
    for (int i = 0; i < n_delta_ts; i++) {
        calculate_accelerations(bodies);
        update_speeds(bodies);
        update_positions(bodies);
    }
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

    pass_time(bodies, N_STEPS);

    printf("\nCondiciones Finales:\n");
    print_bodies(bodies);

    return 0;
}