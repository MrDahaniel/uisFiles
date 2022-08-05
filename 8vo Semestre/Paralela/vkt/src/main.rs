use std::str::FromStr;

mod space_body;
mod vector3d;

use space_body::SpaceBody;
use vector3d::Vector3d;

fn main() {
    println!("Hello, world!");

    let mut sun: SpaceBody = space_body::SpaceBody::new(
        String::from_str("Sun").unwrap(),
        Vector3d::new(0.0, 0.0, 0.0),
        Vector3d::new(0.0, 0.0, 0.0),
        Vector3d::new(0.0, 0.0, 0.0),
        1.989e30,
    );
}
