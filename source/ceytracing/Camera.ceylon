import ceylon.math.float {
    pi,
    tan
}

class Camera {
    Vec3 lowerLeftCorner;
    Vec3 horizontal;
    Vec3 vertical;
    Vec3 origin;
    
    shared new (
        Vec3 lookFrom,
        Vec3 lookAt,
        Vec3 vup,
        "vertical field-of-view, in degrees"
        Float vfov,
        Float aspectRatio) {
        value theta = vfov * pi / 180;
        value halfHeight = tan(theta / 2);
        value halfWidth = aspectRatio * halfHeight;
        value w = unitVector(lookFrom - lookAt);
        value u = unitVector(cross(vup, w));
        value v = cross(w, u);
        
        print("# w: ``w``");
        print("# u: ``u``");
        print("# v: ``v``");
        
        origin = lookFrom;
        lowerLeftCorner = origin - (halfWidth**u) - (halfHeight**v) - w;
        horizontal = (2 * halfWidth) ** u;
        vertical = (2 * halfHeight) ** v;
        
        print("# origin: ``origin``");
        print("# llc: ``lowerLeftCorner``");
        print("# hor: ``horizontal``");
        print("# ver: ``vertical``");
    }
    
    shared Ray ray(Float u, Float v)
            => Ray(origin, lowerLeftCorner + u**horizontal + v**vertical - origin);
}
