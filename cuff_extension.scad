steven=40;
fn=50;

module main() {
  difference() {
    difference() {
      cylinder(r=steven, h=35, $fn=fn);
      translate([0,-8,0]) cylinder(r=steven, h=35, $fn=fn);
    }
    translate([0,-10,0]) cube([45,55,35]);
  }
}

module divot() {
  difference() {
    difference() {
      difference() {
        cylinder(r=steven, h=35, $fn=fn);
        translate([0,-5.0,0]) cylinder(r=steven, h=35, $fn=fn);
      }
      translate([0,-10,0]) cube([45,55,35]);
    }
    // diagonal cut
    rotate([0,-5,0]) {
      translate([-55,-21,-10]) {
        cube([45,65,65]);
      }
    }
  }
}

module biscuit() {

  width = 4.5;
  height = 20.5;
  thickness = 2.2;

  minkowski() {
    cube([height-2, width-2, thickness-2]);
    translate([0,0,thickness/2]) sphere(d=thickness, $fn=5);
  }
}

module whole_thing() {
  difference() {
    difference() {
      union() {
        difference() {
          scale([1.25,1.0,1.0]) {
            difference() {
              main();
              translate([0,-1.5,0]) divot();
            }
          }
          // point cut
          // translate([-90,-20,0]) rotate([0,0,-5]) cube([steven,steven*2,35]);
        }

        translate([-6.5,39.5,25.5]) rotate([90,81,0]) biscuit();
        translate([-7.0,34.5,25.5]) rotate([90,81,0]) biscuit();
      }
      translate([-3,41,10]) rotate([90,0,0]) cylinder(d=2, h=15, $fn=fn);
      translate([-5.5,41,23]) rotate([90,0,0]) cylinder(d=2, h=15, $fn=fn);
    }

    // outside cut
    // translate([-45,9,0]) rotate([0,0,50]) cube([50,10,35]);
    
    // big hole 1
    translate([-24,36,17]) rotate([90,0,30]) cylinder(d=20, h=25, $fn=fn);

    //big hole 2
    translate([-45,20,17]) rotate([90,0,50]) cylinder(d=20, h=25, $fn=fn);

    // cuff v cut top
    translate([-45,-24,10]) rotate([0,18,75]) cube([20,20,40]);

    // cuff v cut bottom
    translate([-45,-17,-10]) rotate([0,-16,75]) cube([20,20,40]);
  }
}

 // whole_thing();
 mirror([0,1,0]) whole_thing();

// rotate([0,0,0]) translate([0,-25,0]) whole_thing();
// rotate([0,0,60]) translate([0,25,0]) mirror([0,1,0]) whole_thing();