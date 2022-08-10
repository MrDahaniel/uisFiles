#include <cmath>

#include "stdio.h"
#include "stdlib.h"

namespace aux {
// Returns the magnitude between 2 points
__device__ double magnitude_between_points(double3 a, double3 b) {
    return sqrt(pow(a.x - b.x, 2) + pow(a.y - b.y, 2) + pow(a.z - b.z, 2));
}

// Returns unitary vector between 2 points
__device__ double3 get_unitary_vector(double3 a, double3 b) {
    double magnitude = magnitude_between_points(a, b);
    return double3{
        (a.x - b.x) / magnitude,
        (a.y - b.y) / magnitude,
        (a.z - b.z) / magnitude,
    };
}

__device__ void printd3(double3 a) {
    printf("x %e y %e z %e\n", a.x, a.y, a.z);
}

}  // namespace aux