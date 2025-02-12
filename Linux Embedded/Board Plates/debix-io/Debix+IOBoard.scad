// Debix + IO Plate
$fn= $preview ? 32 : 64;

// Size, 85.0 x 56.0mm

// Todo: Make push throughs slightly larger diameter to
// make a snug fit.

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
        pillars(length, width, height + 2.0, 2.5/2);
    };
};

module full_plate(extra_height=0) {
    difference() {
        union() {
            plate(85, 56, 2);
            mounts(58, 49, 6+extra_height);
        };

        // Large cut in the middle to reduce material
        // (This doesn't actually save much print time though)
        translate([10, 10, -0.01]) plate(65, 36, 2.2);
    };
};

// A full plate for the main board
full_plate();

// Plus an additional one adjacent to it to hold the IO board
// The IO board is raised 8mm by the IO interface.
translate([0,56,0]) full_plate(8);
