use std::fmt;

#[derive(Clone, Copy)]
pub struct Vector3d {
    pub x: f64,
    pub y: f64,
    pub z: f64,
}

impl Vector3d {
    pub fn new(x: f64, y: f64, z: f64) -> Vector3d {
        Vector3d { x, y, z }
    }

    pub fn zero() -> Vector3d {
        Vector3d::new(0.0, 0.0, 0.0)
    }

    pub fn get_magnitude(a: &Vector3d, b: &Vector3d) -> f64 {
        f64::sqrt(((b.x - a.x).powi(2)) + (b.y - a.y).powi(2) + (b.z - a.z).powi(2))
    }

    pub fn get_unit_vector(a: &Vector3d, b: &Vector3d) -> Vector3d {
        let magnitude = Vector3d::get_magnitude(a, b);
        return Vector3d {
            x: (b.x - a.x) / magnitude,
            y: (b.y - a.y) / magnitude,
            z: (b.z - a.z) / magnitude,
        };
    }
}

impl fmt::Display for Vector3d {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "x: {:e} y: {:e} z: {:e}", self.x, self.y, self.z)
    }
}
