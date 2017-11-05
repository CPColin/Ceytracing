Vec3 randomInUnitDisk() {
    variable Vec3 p;
    
    while (true) {
        p = 2.0 ** Vec3(random.nextFloat(), random.nextFloat(), 0.0) - Vec3(1.0, 1.0, 0.0);
        
        if (dot(p, p) < 1.0) {
            break;
        }
    }
    
    return p;
}