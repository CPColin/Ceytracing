class Ray(shared Vec3 origin, shared Vec3 direction) {
    shared Vec3 pointAtParameter(Float t) => origin + t**direction;
}
