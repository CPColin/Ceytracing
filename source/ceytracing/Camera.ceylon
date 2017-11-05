import ceylon.math.float {
    pi,
    tan
}

class Camera {
    Vec3 lowerLeftCorner;
    Vec3 horizontal;
    Vec3 vertical;
    Vec3 origin;
    Vec3 u;
    Vec3 v;
    Vec3 w;
    Float lensRadius;
    
    shared new (
        Vec3 lookFrom,
        Vec3 lookAt,
        Vec3 vup,
        "vertical field-of-view, in degrees"
        Float vfov,
        Float aspectRatio,
        Float aperture,
        Float focusDistance) {
        value theta = vfov * pi / 180;
        value halfHeight = tan(theta / 2);
        value halfWidth = aspectRatio * halfHeight;
        
        w = unitVector(lookFrom - lookAt);
        u = unitVector(cross(vup, w));
        v = cross(w, u);
        
        print("# w: ``w``");
        print("# u: ``u``");
        print("# v: ``v``");
        
        origin = lookFrom;
        lowerLeftCorner = origin
                - (halfWidth*focusDistance ** u)
                - (halfHeight*focusDistance ** v)
                - focusDistance**w;
        horizontal = (2 * halfWidth * focusDistance) ** u;
        vertical = (2 * halfHeight * focusDistance) ** v;
        
        print("# origin: ``origin``");
        print("# llc: ``lowerLeftCorner``");
        print("# hor: ``horizontal``");
        print("# ver: ``vertical``");
        
        lensRadius = aperture / 2;
    }
    
    shared Ray ray(Float s, Float t)
            => let (rd = lensRadius ** randomInUnitDisk(),
                offset = rd.x**u + rd.y**v)
                Ray(origin + offset, lowerLeftCorner + s**horizontal + t**vertical - origin - offset);
}
