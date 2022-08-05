use super::vector3d::Vector3d;

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
}
