use std::fmt;

use super::vector3d::Vector3d;

const G: f64 = 6.67e-11;

#[derive(Clone)]
pub struct SpaceBody {
    pub name: String,
    pub position: Vector3d,
    pub speed: Vector3d,
    pub acceleration: Vector3d,
    pub mass: f64,
}

impl SpaceBody {
    pub fn new(
        name: String,
        position: Vector3d,
        speed: Vector3d,
        acceleration: Vector3d,
        mass: f64,
    ) -> SpaceBody {
        SpaceBody {
            name,
            position,
            speed,
            acceleration,
            mass,
        }
    }

    pub fn update_acceleration(&mut self, space_bodies: &Vec<SpaceBody>) {
        for space_body in space_bodies {
            self.acceleration = Vector3d::zero();

            if self.name == space_body.name {
                continue;
            };

            println!("Updated {}", self.name);

            let force = space_body.mass
                / Vector3d::get_magnitude(&space_body.position, &self.position).powi(2);
            let unit_vector = Vector3d::get_unit_vector(&space_body.position, &self.position);

            println!("Force: {}", force);
            println!("U. Vector: {}", unit_vector);

            self.acceleration.x += -G * force * unit_vector.x;
            self.acceleration.y += -G * force * unit_vector.y;
            self.acceleration.z += -G * force * unit_vector.z;

            println!("New Acceleration: {}\n", self.acceleration);
        }
    }

    pub fn update_speed(&mut self, t_interval: f64) {
        self.speed.x += t_interval * self.acceleration.x;
        self.speed.y += t_interval * self.acceleration.y;
        self.speed.z += t_interval * self.acceleration.z;
    }

    pub fn update_position(&mut self, t_interval: f64) {
        self.position.x += t_interval * self.speed.x;
        self.position.y += t_interval * self.speed.y;
        self.position.z += t_interval * self.speed.z;
    }
}

impl fmt::Display for SpaceBody {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(
            f,
            "\
            name: {} \n \
            acceleration: {} \n \
            speed: {} \n \
            position: {} \n \
            mass: {:e}",
            self.name, self.acceleration, self.speed, self.position, self.mass
        )
    }
}
