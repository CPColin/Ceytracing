class Camera() {
    value lowerLeftCorner = Vec3(-2.0, -1.0, -1.0);
    value horizontal = Vec3(4.0, 0.0, 0.0);
    value vertical = Vec3(0.0, 2.0, 0.0);
    value origin = Vec3(0.0, 0.0, 0.0);
    
    shared Ray ray(Float u, Float v)
            => Ray(origin, lowerLeftCorner + u**horizontal + v**vertical);
}
