import ceylon.math.float {
    sqrt
}

Float hitSphere(Vec3 center, Float radius, Ray ray)
        =>
            let (oc = ray.origin - center,
                a = dot(ray.direction, ray.direction),
                b = 2.0 * dot(oc, ray.direction),
                c = dot(oc, oc) - radius*radius,
                discriminant = b*b - 4*a*c)
                if (discriminant < 0.0)
                then -1.0
                else (-b - sqrt(discriminant)) / (2.0 * a);
