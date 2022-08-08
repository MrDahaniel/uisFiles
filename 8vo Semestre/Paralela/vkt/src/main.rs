use std::str::FromStr;

mod space_body;
mod vector3d;

use space_body::SpaceBody;
use vector3d::Vector3d;

const TOTAL_BODIES: usize = 2;
const DELTA_T: usize = 86400;
const N_STEPS: usize = (365 * 10) - 1;

fn initialize_bodies() -> Vec<SpaceBody> {
    let mut space_bodies: Vec<SpaceBody> = Vec::with_capacity(TOTAL_BODIES);

    space_bodies.push(space_body::SpaceBody::new(
        String::from_str("Sun").unwrap(),
        Vector3d::new(0.0, 0.0, 0.0),
        Vector3d::new(0.0, 0.0, 0.0),
        Vector3d::new(0.0, 0.0, 0.0),
        1.989e30,
    ));

    space_bodies.push(space_body::SpaceBody::new(
        String::from_str("Mercury").unwrap(),
        Vector3d::new(57.909e9, 0.0, 0.0),
        Vector3d::new(0.0, 47.36e3, 0.0),
        Vector3d::new(0.0, 0.0, 0.0),
        0.33011e24,
    ));

    space_bodies
}

fn simulate(space_bodies: &mut Vec<SpaceBody>) -> Vec<SpaceBody> {
    let mut t_step: usize = 0;
    while t_step < N_STEPS {
        let tmp_bodies = space_bodies.clone();

        for space_body in space_bodies.into_iter() {
            space_body.update_acceleration(&tmp_bodies);
        }

        for space_body in space_bodies.into_iter() {
            space_body.update_speed(DELTA_T as f64);
            space_body.update_position(DELTA_T as f64);
        }

        t_step += 1;
    }

    space_bodies.to_vec()
}

fn main() {
    println!("Hello, world!");

    let mut space_bodies = initialize_bodies();

    for space_body in simulate(&mut space_bodies) {
        println!("{}\n", space_body);
    }
}
