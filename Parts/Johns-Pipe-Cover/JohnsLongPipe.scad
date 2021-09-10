// Pipes are 18mm diameter
// up to 160mm length.
// thickness 5mm?
// 

diameter = 18;
length = 160;
thickness = 5;

$fn=120;

outer_diameter = diameter + thickness;

difference() {
    // Build the outer shape
    cylinder(h=length, d=outer_diameter);
    
    // Everything else in difference cuts from the
    // first object, so this cuts out the inner
    // The inner cuts can be made such that the
    // diameter is smaller at one end (in this instance 1mm)
    cylinder(h=length, d1=diameter, d2=diameter-1);
}