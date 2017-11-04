import ceylon.math.float {
    sqrt
}

class Vec3(shared Float element1, shared Float element2, shared Float element3)
        satisfies Numeric<Vec3> & Scalable<Float, Vec3> {
    shared Float x => element1;
    shared Float y => element2;
    shared Float z => element3;
    
    shared Float r => element1;
    shared Float g => element2;
    shared Float b => element3;
    
    divided(Vec3 other) => Vec3(element1 / other.element1, element2 / other.element2, element3 / other.element3);
    
    negated => Vec3(-element1, -element2, -element3);
    
    plus(Vec3 other) => Vec3(element1 + other.element1, element2 + other.element2, element3 + other.element3);
    
    scale(Float scalar) => Vec3(element1 * scalar, element2 * scalar, element3 * scalar);
    
    times(Vec3 other) => Vec3(element1 * other.element1, element2 * other.element2, element3 * other.element3);
    
    shared Float length => sqrt(element1 * element1 + element2 * element2 + element3 * element3);
}
