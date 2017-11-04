Vec3 color(Ray ray, {Hitable*} world) {
    if (exists hit = hitAnything(ray, 0.0, runtime.maxFloatValue, world)) {
        return 0.5**Vec3(hit.normal.x + 1, hit.normal.y + 1, hit.normal.z + 1);
    }
    else {
        value unitDirection = unitVector(ray.direction);
        value t = 0.5 * (unitDirection.y + 1.0);
        
        return (1.0-t)**Vec3(1.0, 1.0, 1.0) + t**Vec3(0.5, 0.7, 1.0);
    }
}
