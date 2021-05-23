$fn=360;

module body(width, length, height)
{
    scale([1.0,2.0,1.0])
        cylinder(r=width, h=height);
}

module footplate(shoe_width, length)
{
    height=10;
    radius=40;

    translate([0, -length/2, 0]) {
        hull() {
            //cube([shoe_width-50, length, 10]);
            
            translate([shoe_width-radius, radius, 0])
                cylinder(r=radius, h=10);
            translate([shoe_width-radius, length-radius, 0])
                cylinder(r=radius, h=10);
            
        }
    }
}

module belt1(r=60/2, w=5, h=40s) 
{
    tolerance=1;

    translate([0, 0, 10])
    difference() {
        // Outer edge
        cylinder(r=5+r+w+tolerance, h=(h+tolerance));

        // Inner edge;
        cylinder(r=5+r, h=(h+tolerance));
    }
}

module belt(body_width, length, width, height)
{
    tolerance=1;
    offset=10;

    translate([0, 0, 10]) 
    difference() {
        // Outer edge
        body(offset+body_width+width, length, height);

        // Inner Edge (center the inner)
        body(offset+body_width, length, height);
    }
}

module stirrup(shoe_width, body_width, length, height)
{
    difference()
    {
        hull()
        {
            // Body circumference and total height
            body(body_width, length, height);
     
            footplate(shoe_width+body_width, length);            
        }
        
        // Now cut out the body
        body(body_width, length, height);
        // And the belt
        belt(body_width, length, width=5, height=40);
    }
}


/*
  
    Shoe width 60
    30 depth into body surround
    Total width 90.

    Length (of shoe platform and surround body) 120mm
 */
stirrup(shoe_width=60, body_width=30, length=120, height=80);
