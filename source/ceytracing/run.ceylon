import ceylon.collection {
    ArrayList
}

shared void run() {
    value width = 200;
    value height = 100;
    
    print("P3");
    print("``width`` ``height``");
    print("255");
    
    value lowerLeftCorner = Vec3(-2.0, -1.0, -1.0);
    value horizontal = Vec3(4.0, 0.0, 0.0);
    value vertical = Vec3(0.0, 2.0, 0.0);
    value origin = Vec3(0.0, 0.0, 0.0);
    value world = ArrayList<Hitable>();
    
    world.add(Sphere(Vec3(0.0, 0.0, -1.0), 0.5));
    world.add(Sphere(Vec3(0.0, -100.5, -1.0), 100.0));
    
    for (y in height-1..0) {
        for (x in 0:width) {
            value u = x.float / width;
            value v = y.float / height;
            value ray = Ray(origin, lowerLeftCorner + u**horizontal + v**vertical);
            value color = package.color(ray, world);
            function toInt(Float val) => (255.99 * val).integer;
            
            print("``toInt(color.r)`` ``toInt(color.g)`` ``toInt(color.b)``");
        }
    }

}