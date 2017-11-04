import ceylon.math.float {
    sqrt
}

class Sphere(Vec3 center, Float radius, Material material) satisfies Hitable {
    shared actual HitRecord? hit(Ray ray, Float tMin, Float tMax) {
        value oc = ray.origin - center;
        value a = dot(ray.direction, ray.direction);
        value b = dot(oc, ray.direction);
        value c = dot(oc, oc) - radius*radius;
        value discriminant = b*b - a*c;
        
        function checkHit(Float t) {
            if (t>tMin && t<tMax) {
                value p = ray.pointAtParameter(t);
                
                return HitRecord(t, p, (1.0 / radius) ** (p - center), material);
            } else {
                return null;
            }
        }
        
        if (discriminant > 0.0) {
            value rootPart = sqrt(b*b - a*c);
            
            if (exists hitRecord = checkHit((-b - rootPart) / a)) {
                return hitRecord;
            }
            
            if (exists hitRecord = checkHit((-b + rootPart) / a)) {
                return hitRecord;
            }
        }
        
        return null;
    }
}
