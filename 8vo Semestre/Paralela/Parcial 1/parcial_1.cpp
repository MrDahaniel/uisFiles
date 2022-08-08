#include <stdio.h>

#include <cmath>
#include <string>

double const G = 6.67e-11;
int const DELTA_T = 86400;
int const N_STEPS = (365 * 10) - 1;
int const TOTAL_BODIES = 2;

struct vector3d {
    double x;
    double y;
    double z;
};

struct space_body {
    std::string name;
    vector3d position;
    vector3d speed;
    vector3d acceleration;
    double mass;

    void print() {
        printf("%s\n", name.c_str());
        printf("    Position: %e, %e, %e\n",
               position.x,
               position.y,
               position.z);
        printf("    Speed: %e, %e, %e\n",
               speed.x,
               speed.y,
               speed.z);
        printf("    Acceleration: %e, %e, %e\n",
               acceleration.x,
               acceleration.y,
               acceleration.z);
        printf("    Mass: %e\n", mass);
    }
};

struct n_body_system {
    space_body* bodies;

    double calculate_magnitude(vector3d vec_A, vector3d vec_B) {
        double i = vec_A.x - vec_B.x;
        double j = vec_A.y - vec_B.y;
        double k = vec_A.z - vec_B.z;

        return sqrt(pow(i, 2) + pow(j, 2) + pow(k, 2));
    }

    vector3d calculate_unitary_vector(vector3d vec_A, vector3d vec_B) {
        double magnitude = calculate_magnitude(vec_A, vec_B);

        return vector3d{
            (vec_A.x - vec_B.x) / magnitude,
            (vec_A.y - vec_B.y) / magnitude,
            (vec_A.z - vec_B.z) / magnitude,
        };
    }

    void calculate_accelerations() {
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
                vector3d unit_vector = calculate_unitary_vector(
                    bodies[i].position,
                    bodies[j].position);

                bodies[i].acceleration.x += -G * F * unit_vector.x;
                bodies[i].acceleration.y += -G * F * unit_vector.y;
                bodies[i].acceleration.z += -G * F * unit_vector.z;
            }
        }

        return;
    }

    void update_speeds() {
        for (int i = 0; i < TOTAL_BODIES; i++) {
            bodies[i].speed.x =
                bodies[i].acceleration.x * DELTA_T + bodies[i].speed.x;
            bodies[i].speed.y = bodies[i].acceleration.y * DELTA_T + bodies[i].speed.y;
            bodies[i].speed.z = bodies[i].acceleration.z * DELTA_T + bodies[i].speed.z;
        }
    }

    void update_positions() {
        for (int i = 0; i < TOTAL_BODIES; i++) {
            bodies[i].position.x = bodies[i].speed.x * DELTA_T + bodies[i].position.x;
            bodies[i].position.y = bodies[i].speed.y * DELTA_T + bodies[i].position.y;
            bodies[i].position.z = bodies[i].speed.z * DELTA_T + bodies[i].position.z;
        }
    }

    void pass_time(int n_delta_ts) {
        for (int i = 0; i < n_delta_ts; i++) {
            calculate_accelerations();
            update_speeds();
            update_positions();
        }
    }

    void print_bodies() {
        for (int i = 0; i < TOTAL_BODIES; i++) {
            bodies[i].print();
        }
    }

    void print_from_center() {
        for (int i = 1; i < TOTAL_BODIES; i++) {
            printf("%s\n", bodies[i].name.c_str());
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
};

int main(int argc, char** argsv) {
    space_body* bodies = new space_body[TOTAL_BODIES];

    bodies[0] = space_body{
        "sun",              // Name
        vector3d{0, 0, 0},  // Position
        vector3d{0, 0, 0},  // Speed
        vector3d{0, 0, 0},  // Acceleration
        1.989e30,           // Mass
    };

    bodies[1] = space_body{
        "mercury",                 // Name
        vector3d{57.909e9, 0, 0},  // Position
        vector3d{0, 47.36e3, 0},   // Speed
        vector3d{0, 0, 0},         // Acceleration
        0.33011e24,                // Mass
    };

    // bodies[2] = space_body{
    //     "venus",                    // Name
    //     vector3d{108.209e9, 0, 0},  // Position
    //     vector3d{0, 35.02e3, 0},    // Speed
    //     vector3d{0, 0, 0},          // Acceleration
    //     4.8675e24                   // Mass
    // };

    // bodies[3] = space_body{
    //     "earth",                    // Name
    //     vector3d{149.596e9, 0, 0},  // Position
    //     vector3d{0, 29.78e3, 0},    // Speed
    //     vector3d{0, 0, 0},          // Acceleration
    //     5.9724e24                   // Mass
    // };

    // bodies[4] = space_body{
    //     "mars",                     // Name
    //     vector3d{227.923e9, 0, 0},  // Position
    //     vector3d{0, 24.07e3, 0},    // Speed
    //     vector3d{0, 0, 0},          // Acceleration
    //     0.64171e24                  // Mass
    // };

    printf("\nCondiciones Iniciales:\n");
    n_body_system solar_system{
        bodies,
    };

    solar_system.print_bodies();

    solar_system.pass_time(N_STEPS);

    printf("\nCondiciones Finales:\n");
    solar_system.print_bodies();

    return 0;
}