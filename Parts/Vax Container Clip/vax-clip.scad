// Vax Clip

$fn=180;

// Main parts:
//
// Tower/rotation insertion
// base, length
// side, tracks base as 'handle'
// clip, arc which holds the item in place.


// V1. Rough edges, but should validate sizes and scales.


base_height=2.1;
base_cube_width=12.0;
base_cube_length=12.0;

// Width of tower which supports the clip and rotates.
tower_external_diameter=12.6;
tower_external_radius=tower_external_diameter/2;
tower_internal_diameter=tower_external_diameter-4.0;

tower_height=33.2;

// Cut out the ... cutout
cutout_width=3.0;
cutout_height=8.0;

// Small noggin that locks the positions
tower_noggin_diameter=2.0;
tower_noggin_extends_out=1.0;
tower_large_noggin_diameter=5.7;

// Measured from outer edge of the tower, so remove radius of tower
clip_arc_outer_radius=37.5-tower_external_radius;
clip_arc_width=3.2;
clip_arc_inner_radius=clip_arc_outer_radius-clip_arc_width;
clip_height=17.3;

side_height=18.3;
side_thickness=2.7;

// Total Width
total_width=47.0;

module pieSlice(a, r, h){
  // a:angle, r:radius, h:height
  rotate_extrude(angle=a) square([r,h]);
}

module clip() {
    angle=40;
    rotation=162.5;
    
    rotate(rotation)
    difference() {
        pieSlice(angle,clip_arc_outer_radius,clip_height);
        translate([0,0,-0.01])
        rotate(-1) pieSlice(angle+2,clip_arc_inner_radius,clip_height+0.02);
    }
}

module tower() {
    // Clip positioning is derived from the tower center
    clip();
    
    difference() {
        // Build up the components of the tower
        union() {
            // outer tower
            cylinder(d1=tower_external_diameter,
                     d2=tower_external_diameter+0.5,
                     h=tower_height);

            // Small noggin on right (only above the side height)
            noggin_height=tower_height - side_height;
            translate([tower_external_radius-0.5,0,side_height])
            cylinder(d=tower_noggin_diameter, h=noggin_height);

            // large noggin on left
            translate([-tower_external_radius+2,0,0])
            cylinder(d=tower_large_noggin_diameter, h=tower_height);
        }

        // Cut out the internal tube
        translate([0,0,base_height+0.01])
        cylinder(d=tower_internal_diameter, h=tower_height-base_height);


        // Move the cut to be centrally aligned on the tower,
        // and cut from the top
        translate([-cutout_width/2,
                   -tower_external_radius-1.5,
                   tower_height-cutout_height])
           cube([cutout_width,tower_external_diameter+3,cutout_height+0.01]);
    }
}

module base() {
    offset=2.5;

    hull()
    {
        cube([base_cube_width, base_cube_length, base_height]);
    
        // Place a square aligned to the top of the tower location
        // to be able to hull the base down in line with the tower.
        translate([total_width-(tower_external_diameter),0,0])
            cube([tower_external_radius,
                  tower_external_radius*14/10,
                  base_height]);
    }

    // Track the location of the tower
    translate([total_width-tower_external_radius, offset,0])
        tower();
}


module side_end() {
    angle=40;
    rotation=162.5;
    
    rotate(rotation)
    difference() {
        pieSlice(angle,clip_arc_outer_radius,clip_height);
        translate([0,0,-0.01])
        rotate(-1) pieSlice(angle+2,clip_arc_inner_radius,clip_height+0.02);
    }
}


module side() {
    //hull()
    translate([0,base_cube_length-side_thickness,0])
    union()
    {


        // Connect to the 
        cube([base_cube_width,
              side_thickness,
              side_height]);
        
        hull() {
            translate([base_cube_width-0.2,,0])
            cube([1,
                  side_thickness,
                  side_height]);

          // How do I put in this side piece??
          //  translate([total_width-tower_external_radius+3,-3.3,0])
          //      side_end();
            translate([total_width-tower_external_radius,-2.5,0])
               cube([1, // a flat plane
                     2, // thickness of the tower?
                     side_height]);

        }
    }
    
}


union() {
    base();
    side();
}