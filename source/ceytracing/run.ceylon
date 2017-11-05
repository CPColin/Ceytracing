import ceylon.collection {
    ArrayList
}
import ceylon.math.float {
    sqrt
}

shared void run() {
    value width = 200;
    value height = 100;
    value samples = 100;
    
    print("P3");
    print("``width`` ``height``");
    print("255");
    
    value world = ArrayList<Hitable>();
    
    world.add(Sphere(Vec3(0.0, 0.0, -1.0), 0.5, Lambertian(Vec3(0.1, 0.2, 0.5))));
    world.add(Sphere(Vec3(0.0, -100.5, -1.0), 100.0, Lambertian(Vec3(0.8, 0.8, 0.0))));
    world.add(Sphere(Vec3(1.0, 0.0, -1.0), 0.5, Metal(Vec3(0.8, 0.6, 0.2), 0.0)));
    world.add(Sphere(Vec3(-1.0, 0.0, -1.0), 0.5, Dielectric(1.5)));
    world.add(Sphere(Vec3(-1.0, 0.0, -1.0), -0.45, Dielectric(1.5)));
    
    value lookFrom = Vec3(3.0, 3.0, 2.0);
    value lookAt = Vec3(0.0, 0.0, -1.0);
    
    value camera = Camera {
        lookFrom = lookFrom;
        lookAt = lookAt;
        vup = Vec3(0.0, 1.0, 0.0);
        vfov = 20.0;
        aspectRatio = width.float / height;
        aperture = 2.0;
        focusDistance = (lookFrom - lookAt).length;
    };
    
    for (y in height-1 .. 0) {
        for (x in 0:width) {
            variable value color = Vec3(0.0, 0.0, 0.0);
            
            for (sample in 0:samples) {
                value u = (x + random.nextFloat()) / width;
                value v = (y + random.nextFloat()) / height;
                value ray = camera.ray(u, v);
                
                color += package.color(ray, world, 0);
            }
            
            color = (1.0 / samples) ** color;
            
            function toInt(Float val) => (255.99 * sqrt(val)).integer;
            
            print("``toInt(color.r)`` ``toInt(color.g)`` ``toInt(color.b)``");
        }
    }
}
