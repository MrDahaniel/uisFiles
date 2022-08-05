pub struct Vector3d {
    x: f64,
    y: f64,
    z: f64,
}

impl Vector3d {
    pub fn new(x: f64, y: f64, z: f64) -> Vector3d {
        Vector3d { x, y, z }
    }

    pub fn get_magnitude(&self) -> f64 {
        return self.x.powi(2) + self.y.powi(2) + self.z.powi(2);
    }

    pub fn get_unit_vector(&self) -> Vector3d {
        let magnitude = self.get_magnitude();
        return Vector3d {
            x: self.x / magnitude,
            y: self.y / magnitude,
            z: self.z / magnitude,
        };
    }
}
