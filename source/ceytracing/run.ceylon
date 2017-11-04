import ceylon.collection {
    ArrayList
}

import ceylon.random {
    DefaultRandom
}

shared void run() {
    value width = 200;
    value height = 100;
    value samples = 100;
    
    print("P3");
    print("``width`` ``height``");
    print("255");
    
    value world = ArrayList<Hitable>();
    
    world.add(Sphere(Vec3(0.0, 0.0, -1.0), 0.5));
    world.add(Sphere(Vec3(0.0, -100.5, -1.0), 100.0));
    
    value camera = Camera();
    value random = DefaultRandom();
    
    for (y in height-1..0) {
        for (x in 0:width) {
            variable value color = Vec3(0.0, 0.0, 0.0);
            
            for (sample in 0:samples) {
                value u = (x + random.nextFloat()) / width;
                value v = (y + random.nextFloat()) / height;
                value ray = camera.ray(u, v);
                
                color += package.color(ray, world);
            }
            
            color = (1.0 / samples)**color;
            
            function toInt(Float val) => (255.99 * val).integer;
            
            print("``toInt(color.r)`` ``toInt(color.g)`` ``toInt(color.b)``");
        }
    }

}