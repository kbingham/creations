
// One shape with corresponding text
module camera() {
  width=20.3;
  height=20.3;
  depth=30;
  union() {
    cube(size=[width, height, depth], center=false);
    //cube(size[width,
  }
}

//camera();

module roundedCube(xlen,ylen,zlen,radius){
  hull(){
    translate([radius,radius,radius]) sphere(r=radius);
    translate([xlen + radius , radius , radius]) sphere(r=radius);
    translate([radius , ylen + radius , radius]) sphere(r=radius);    
    translate([xlen + radius , ylen + radius , radius]) sphere(r=radius);
    translate([radius , radius , zlen + radius]) sphere(r=radius);
    translate([xlen + radius , radius , zlen + radius]) sphere(r=radius);
    translate([radius,ylen + radius,zlen + radius]) sphere(r=radius);
    translate([xlen + radius,ylen + radius,zlen + radius]) sphere(r=radius);
  }
}

module camera(width, height, depth) {

    // The cutout support
    support=[29.8, 1.8, depth];
    
    union() {
        cube(size=[width, height, depth], center=false);
        //roundedCube(width, height, depth, 3);
        translate([-((29.8-width)/2), height-17.8, 0])
        cube(support, center=false);
    }
}

module cameraBoard(qty, margin) {

  camera_width = 20.4;
  camera_height = 20.4;
  full_camera_width = 35.5;

  height = 30;
  rounding = 1; // Affects total depth a lot

  length = qty * full_camera_width + margin;
  depth = 1;

  spacing = length / qty;
  padding = ((spacing-20.3) / 2) + rounding;

  echo(length);

  yspace=rounding + (height-camera_height) / 2;

  difference() {
    // Base
    roundedCube(length, 30, depth, rounding);

    for ( i = [0 : qty-1] ) {
        translate([padding + (i * spacing), yspace, 0])
            camera(camera_width, camera_height, depth+(rounding*2));

    }
  }
}

cameraBoard(qty=4, margin=5);