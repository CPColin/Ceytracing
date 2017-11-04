shared void helloPpm() {
    value width = 200;
    value height = 100;
    
    print("P3");
    print("``width`` ``height``");
    print("255");
    
    for (y in height-1..0) {
        for (x in 0:width) {
            function toInt(Float val) => (255.99 * val).integer;
            
            value color = Vec3(x.float / width, y.float / height, 0.2);
            
            print("``toInt(color.r)`` ``toInt(color.g)`` ``toInt(color.b)``");
        }
    }
}
