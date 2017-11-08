import ceylon.collection {
    ArrayList
}

{Hitable*} randomScene {
    value scene = ArrayList<Hitable>();
    
    scene.add(Sphere(Vec3(0.0, -1000.0, 0.0), 1000.0, Lambertian(Vec3(0.5, 0.5, 0.5))));
    scene.add(Sphere(Vec3(0.0, 1.0, 0.0), 1.0, Dielectric(1.5)));
    scene.add(Sphere(Vec3(-4.0, 1.0, 0.0), 1.0, Lambertian(Vec3(0.4, 0.2, 0.1))));
    scene.add(Sphere(Vec3(4.0, 1.0, 0.0), 1.0, Metal(Vec3(0.7, 0.6, 0.5), 0.0)));
    
    for (a in -2..2) {
        for (b in -2..2) {
            value center = Vec3(a + 0.9 * random.nextFloat(), 0.2, b + 0.9 * random.nextFloat());
            
            if ((center - Vec3(4.0, 0.2, 0.0)).length > 0.9) {
                Material material;
                value materialChoice = random.nextFloat();
                
                if (materialChoice < 0.8) {
                    material = Lambertian(Vec3(random.nextFloat() * random.nextFloat(), random.nextFloat() * random.nextFloat(), random.nextFloat() * random.nextFloat()));
                }
                else if (materialChoice < 0.95) {
                    material = Metal(Vec3(0.5 * (1 + random.nextFloat()), 0.5 * (1 + random.nextFloat()), 0.5 * (1 + random.nextFloat())), 0.5 * random.nextFloat());
                }
                else {
                    // TODO: tweak randomly
                    material = Dielectric(1.5);
                }
                
                scene.add(Sphere(center, 0.2, material));
            }
        }
    }
    
    return scene;
}