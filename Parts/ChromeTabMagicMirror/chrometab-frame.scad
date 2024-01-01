$fn=50;

// External Frame Dimensions 235 x 286
external_width=235;
external_depth=286;

// Internal Frame Dimensions 204x250
internal_width=204;
internal_depth=250;


// chrometab 172 x 238
chrometab_width=172;
chrometab_depth=238;
chrometab_height=10;

backplane_thickness=2.5;

// Top Fitting

include <BOSL2/std.scad>

module chrometab(x, y) {
    h=chrometab_height;
    r=7.5;
    d=r*2;

    color("blue")
    right(x+r) back(y+r)

    hull() {
        right(0) back(0)
            cylinder(h, r, r);

        right(chrometab_width-d) back(0)
            cylinder(h, r, r);

        right(chrometab_width-d)
        back(chrometab_depth-d)
            cylinder(h, r, r);

        right(0) back(chrometab_depth-d)
            cylinder(h, r, r);
    };
};

module double_cylinder(radius, width, height)
{
    rotate([90,0,0])
    translate([radius,radius,0])
    hull() {
        cylinder(h=height, r1=radius, r2=radius);

        right(width-(radius*2)) 
        cylinder(h=height, r1=radius, r2=radius);
    };  
}

module usb() {
    r=4;
    w=13;
    rotate([90,0,0])
    translate([r,r,0])
    hull() {
        cylinder(h=20, r1=r, r2=r);

        right(w-(r*2)) 
        cylinder(h=20, r1=r, r2=r);
    };
};

function central(a, b) = ((a - b) / 2);

module middle(outer_width, inner_width,
              outer_depth, inner_depth)
{
    x=central(outer_width, inner_width);
    y=central(outer_depth, inner_depth);

    translate([x, y, 0]) children();
}


module mirror_frame() {

    union() {

        // Back plane / frame attachment
        down(backplane_thickness) {
            // lower base plane
            cube([external_width, external_depth,
                  backplane_thickness]);
        };


        middle(external_width, internal_width,
               external_depth, internal_depth)
        difference() {
            // Internal Frame Size
            cube([internal_width, internal_depth, 10]);

            // Cuts
            middle(internal_width, chrometab_width,
                   internal_depth, chrometab_depth)
            {
                // Chrometab Cutout
                up(0.001) // Make sure cut is visible
                    chrometab(0,0);

                // USB Cutout
                up(1) // Align to the middle height
                back(2.001) // Make sure it cuts through
                right(chrometab_width) // start at the right side
                left(27.5) // then pull left to final position
                    usb();
                
                // Power and Volume
                back(chrometab_depth) // Start from the 'top'
                rotate([0,0,270]) // Correct direction + position
                back(2) // Make sure it cuts through
                up(2.5) // align to middle
                right(20) // Pull 'down' to final position
                #double_cylinder(radius=2.5, width=38, height=20);
            }
        }
    }
}

// Bottom Piece
intersection() {
    mirror_frame();

    down(backplane_thickness)
    cube([external_width, 40, 60]);
}

// Top Piece
intersection() {
    mirror_frame();

    down(backplane_thickness)
    back(external_depth - 40)
    cube([external_width, 40, 60]);
}
