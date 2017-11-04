Vec3 color(Ray ray, {Hitable*} world) {
    if (exists hit = hitAnything(ray, 0.001, runtime.maxFloatValue, world)) {
        value target = hit.p + hit.normal + randomInUnitSphere();
        
        return 0.5**color(Ray(hit.p, target - hit.p), world);
    }
    else {
        value unitDirection = unitVector(ray.direction);
        value t = 0.5 * (unitDirection.y + 1.0);
        
        return (1.0-t)**Vec3(1.0, 1.0, 1.0) + t**Vec3(0.5, 0.7, 1.0);
    }
}
