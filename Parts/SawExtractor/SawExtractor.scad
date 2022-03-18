include <BOSL2/std.scad>

$fn=120;

thickness=2;

connections = [


//   h   id1  od1          id2   od2
    [25, [64.0, 64.0+4], [61.0-0.5, 61.0+4]], // 61 measured. 63->60.5
    [25, [61.0, 61.0+4], [34.8-2, 34.8+4+2]], // Angled Join
    [25, [34.8, 34.8+4+2], [35.2, 35.2+4]], // Small Connector
];


union() {

    z=0;
    for (c = [ 0 : len(connections) - 1 ]) {
        size=connections[c];
        
        h=size[0];
        a=size[1];
        b=size[2];
        
        echo("Z: ", z);
        up (c*25)
        tube(h=h, id1=a[0], od1=a[1],
                  id2=b[0], od2=b[1]);
    }
}

/*
// height, thickness, d1, d2
largeConnector=[30, thickness, 61.5, 60.5];

excess=0; // fixme...

join=[20, thickness+excess, 61-excess, 35-excess];
smallConnector=[35, 25, thickness, 34.8, 35.2];

vacuum_height=35;

module connector(sizes)
{

    h=sizes[0];
    t=sizes[1]*2;
    d1=sizes[2];
    d2=sizes[3];

    difference() {
        // outer edge
        cylinder(d1=d1+t,
                 d2=d2+t,
                 h=h);
        // inner edge
        down(0.5) cylinder(d1=d1, d2=d2, h=h+1);
    }
}



union() {
    connector(largeConnector);

    up(largeConnector[0])
        connector(join);

    up(largeConnector[0] + join[0])
        connector(smallConnector);
}

*/