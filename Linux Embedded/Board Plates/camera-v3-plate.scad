// Pi Plate
$fn= $preview ? 32 : 64;

// See https://datasheets.raspberrypi.com/camera/camera-module-3-standard-mechanical-drawing.pdf

module t(t, s = 18, style = "", h) {
   linear_extrude(height = h)
      text(t, size = s, font = str("monospace", style), $fn = 16);
}

module libcamera(ls=20, h=6) {
    translate([0, 2*ls, 0]) t("+-/ \\-+", 15, ":style=Bold", h);
    translate([0, 1*ls, 0]) t("| (o) |", 15, ":style=Bold", h);
    translate([0, 0*ls, 0]) t("+-----+", 15, ":style=Bold", h);
}

module plate(length, width, height) {
    radius = 2.0;
    length = length - (radius*2);
    width = width - (radius*2);
    
    translate([radius, radius, 0])
    hull() {
        translate([0, 0, 0]) cylinder(h=height, r=radius);
        translate([length, 0, 0]) cylinder(h=height, r=radius);
        translate([0, width, 0]) cylinder(h=height, r=radius);
        translate([length, width, 0]) cylinder(h=height, r=radius);
    };
}

module pillars(length, width, height, radius) {
    translate([0, 0, 0]) cylinder(h=height, r=radius);
    translate([length, 0, 0]) cylinder(h=height, r=radius);
    translate([0, width, 0]) cylinder(h=height, r=radius);
    translate([length, width, 0]) cylinder(h=height, r=radius);
};

module mounts(length, width, height) {
    offset=2;

    translate([offset, offset, 0]) {
        // Resting pillars
        pillars(length, width, height, 4/2);
        // Fit through pillars (through hole)
        pillars(length, width, height + 1.5, 2.2/2);
    };
};


difference() {
    union() {
        plate(25, 23.862, 2);
        mounts(21, 12.5, 5);
    };

    s=0.25;
    #translate([1.75, 4, -0.7])
        scale([s, s, s])
             libcamera();

    // Cut outs to support stacking of the through holes
    // Note the hole is (0.1/2) larger than the fit through pillar.
    offset=2;
    translate([offset, 23.862 - 12.5 - offset, 1])
        pillars(21, 12.5, 1.5, (2.2/2)+0.05);
    
};
