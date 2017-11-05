import ceylon.math.float {
    sqrt
}

interface Material {
    shared formal [Vec3, Ray]? scatter(Ray ray, HitRecord hit);
}

Vec3 reflect(Vec3 v, Vec3 n) => v - 2 * dot(v, n) ** n;

Vec3? refract(Vec3 v, Vec3 n, Float niOverNt) {
    value uv = unitVector(v);
    value dt = dot(uv, n);
    value discriminant = 1.0 - niOverNt*niOverNt * (1.0 - dt*dt);
    
    return discriminant > 0.0
            then niOverNt ** (uv - dt**n) - sqrt(discriminant) ** n;
}

Float schlick(Float cosine, Float refractiveIndex) {
    value r0 = (1 - refractiveIndex) / (1 + refractiveIndex);
    value r2 = r0 * r0;
    
    return r2 + (1 - r2) * (1 - cosine).power(5.0);
}

class Dielectric(Float refractiveIndex) satisfies Material {
    shared actual [Vec3, Ray] scatter(Ray ray, HitRecord hit) {
        value cosinePart = dot(ray.direction, hit.normal) / ray.direction.length;
        value [outwardNormal, niOverNt, cosine] = dot(ray.direction, hit.normal) > 0.0
                then [-hit.normal, refractiveIndex, refractiveIndex * cosinePart]
                else [hit.normal, 1.0 / refractiveIndex, -cosinePart];
        value attenuation = Vec3(1.0, 1.0, 1.0);
        value refracted = refract(ray.direction, outwardNormal, niOverNt);
        value reflectProbability = refracted exists then schlick(cosine, refractiveIndex) else 1.0;
        
        if (exists refracted, random.nextFloat() >= reflectProbability) {
            return [attenuation, Ray(hit.p, refracted)];
        } else {
            value reflected = reflect(ray.direction, hit.normal);
            
            return [attenuation, Ray(hit.p, reflected)];
        }
    }
}

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
        value scattered = Ray(hit.p, reflected + fuzz ** randomInUnitSphere());
        
        return dot(scattered.direction, hit.normal) > 0.0
                then [albedo, scattered];
    }
}
