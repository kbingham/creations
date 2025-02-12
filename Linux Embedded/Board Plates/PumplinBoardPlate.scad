// (MediaTek) Pumpkin Board Plate
$fn= $preview ? 32 : 64;


module plate(length, width, height) {
    radius = 3.0;
    length = length - (radius*2);
    width = width - (radius*2);

    translate([radius, radius, 0])
    hull() {
        translate([0, 0, 0]) cylinder(h=height, r=3.0);
        translate([length, 0, 0]) cylinder(h=height, r=3.0);
        translate([0, width, 0]) cylinder(h=height, r=3.0);
        translate([length, width, 0]) cylinder(h=height, r=3.0);
    };
}

module pillars(length, width, height, radius) {
    translate([0, 0, 0]) cylinder(h=height, r=radius);
    translate([length, 0, 0]) cylinder(h=height, r=radius);
    translate([0, width, 0]) cylinder(h=height, r=radius);
    translate([length, width, 0]) cylinder(h=height, r=radius);
};

module mounts(length, width, height) {
    offset=3.5;

    translate([offset, offset, 0]) {
        // Resting pillars
        pillars(length, width, height, 6.0/2);

        // Fit through pillars (through hole)
        pillars(length, width, height + 1.0, 2.6/2);
    };
};


module outline_plate(length, width, height=2)
{
    difference() {
        union() {
            plate(length, width, height);
        };
    
        // Large cut in the middle to reduce material
        // (This doesn't actually save much print time though)
        translate([10, 10, -0.01])
            plate(length-20, width-20, height+1);
    };
};

translate([0,71-7-49,0])
    mounts(58, 49, 6);

outline_plate(/*85*/58+7, 71 /*49+7*/);

outline_plate(103, 71);
// Additional Pillar supports

offset=3.5;
translate([offset, offset, 0])
    pillars(103-7, 71-7, 6, 6.0/2);


/*
difference() {
    union() {
        /* Pumpkin Extension *
        plate(103, 71, 2);

        plate(85, 56, 2);
        mounts(58, 49, 6);


    };
    
    // Large cut in the middle to reduce material
    // (This doesn't actually save much print time though)
    translate([10, 10, -0.01]) plate(65, 36, 2.2);
};
*/

        