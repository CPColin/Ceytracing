interface Hitable {
    shared formal HitRecord? hit(Ray ray, Float tMin, Float tMax);
}
