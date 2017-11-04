HitRecord? hitAnything(Ray ray, Float tMin, Float tMax, {Hitable*} world) {
    variable HitRecord? hitRecord = null;
    variable Float closestSoFar = tMax;
    
    for (hitable in world) {
        if (exists hit = hitable.hit(ray, tMin, closestSoFar)) {
            hitRecord = hit;
            closestSoFar = hit.t;
        }
    }
    
    return hitRecord;
}
