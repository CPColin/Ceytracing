Vec3 color(Ray ray, {Hitable*} world, Integer depth) {
    if (exists hit = hitAnything(ray, 0.001, runtime.maxFloatValue, world)) {
        
        if (depth < 50, exists [attenuation, scattered] = hit.material.scatter(ray, hit)) {
            return attenuation * color(scattered, world, depth + 1);
        }
        else {
            return Vec3(0.0, 0.0, 0.0);
        }
    }
    else {
        value unitDirection = unitVector(ray.direction);
        value t = 0.5 * (unitDirection.y + 1.0);
        
        return (1.0-t)**Vec3(1.0, 1.0, 1.0) + t**Vec3(0.5, 0.7, 1.0);
    }
}
