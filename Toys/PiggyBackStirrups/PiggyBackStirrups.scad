
module prism(l, w, h){
       polyhedron(
               //         0        1        2        3        4        5
               points=[[0,0,0], [0,w,0], [0,0,h], [0,w,h], [l,0,h], [l,w,h]],
               faces=[[0,1,3,2],[2,3,5,4],[0,1,5,4],[0,2,4],[5,3,1]]
               );
       
}  

module FootPlate(l, w, h){
   prism(l,w,h);
}
 


module BodySupport(l, w, h) {
    // The bulk
    translate([-l, 0, 0])
        cube([l, w, h]);

}
 
// Hugo's Foot width (with shoe) 60 ~ 75

module stirrup(length, depth, width, shoewidth, height)
{
    FootPlate(shoewidth, depth, height);
    BodySupport(length, depth, height);
}


// width : Width into the body.
// Shoewidth = Expected width to support the shoe
// height overall z axis - vertical rise

module complete(length = 60, depth = 140, width=60, shoewidth=60, height=90) {
    difference() {
        stirrup(length, depth, width, shoewidth, height);

        // A body cutout    
        translate([-depth/2-1, depth/2, 0])
           cylinder(height, d=depth);
    }
}

complete();