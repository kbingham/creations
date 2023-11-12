include <BOSL2/std.scad>

height=20.0;
top=25.0;
bottom=36.0;

depth=50.0;

sideWidth=1.8;

sideHeight=5.0;


//trapezoid(height, top, bottom) show_anchors();
//up(5)
down(height+sideHeight)
left((bottom+sideHeight)/2)
rotate([90, 0, 0])
    cube([bottom+sideHeight, height+sideHeight, sideWidth]);

down(height) back(depth/2) {
    prismoid(size1=[bottom,depth],
             size2=[top,depth], h=height);

    % up(height) difference() {
        prismoid(size1=[top,depth], size2=[5,depth], h=height);
        up(5) back(0.5)
        prismoid(size1=[top-10,depth+2],
                 size2=[5,depth+2], h=height-10);
    }
}

back(depth+sideWidth)
down(height+sideHeight)
left((bottom+sideHeight)/2)
rotate([90, 0, 0])
    cube([bottom+sideHeight, height+sideHeight, sideWidth]);