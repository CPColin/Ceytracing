Vec3 randomInUnitSphere() {
    variable Vec3 p;
    
    while ((p = 2.0 ** Vec3(random.nextFloat(), random.nextFloat(), random.nextFloat())
                    - Vec3(1.0, 1.0, 1.0))
            .length > 1.0) {
    }
    
    return p;
}
