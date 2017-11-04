interface Material {
    shared formal [Vec3, Ray]? scatter(Ray ray, HitRecord hit);
}

Vec3 reflect(Vec3 v, Vec3 n) => v - 2 * dot(v, n) ** n;

class Lambertian(Vec3 albedo) satisfies Material {
    shared actual [Vec3, Ray] scatter(Ray ray, HitRecord hit) {
        value target = hit.p + hit.normal + randomInUnitSphere();
        
        return [albedo, Ray(hit.p, target - hit.p)];
    }
}

class Metal(Vec3 albedo, Float fuzz) satisfies Material {
    assert (fuzz <= 1.0);
    
    shared actual [Vec3, Ray]? scatter(Ray ray, HitRecord hit) {
        value reflected = reflect(unitVector(ray.direction), hit.normal);
        value scattered = Ray(hit.p, reflected + fuzz**randomInUnitSphere());
        
        return dot(scattered.direction, hit.normal) > 0.0
            then [albedo, scattered]
            else null;
    }
}
