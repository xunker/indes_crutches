height=35;
radius=40;
fn=50;

module main() {
  difference() {
    difference() {
      cylinder(r=radius, h=height, $fn=fn);
      translate([0,-7.5,0]) scale([1.05,1,1]) cylinder(r=radius, h=height, $fn=fn);
    }
    translate([0,-10,0]) cube([45,55,height]);
  }
}

module divot() {
  difference() {
    difference() {
      difference() {
        cylinder(r=radius, h=height, $fn=fn);
        translate([0,-4.5,0]) cylinder(r=radius, h=height, $fn=fn);
      }
      translate([0,-10,0]) cube([45,55,height]);
    }
    // diagonal cut
    translate([-53.5,-21,-10]) {
      rotate([0,-5,0]) {
        cube([45,65,65]);
      }
    }
  }
}

module biscuit() {

  width = 4.5;
  height = 20.0;
  thickness = 2.2;

  minkowski() {
    cube([height-2, width-2, thickness-2]);
    translate([0,0,thickness/2]) sphere(d=thickness, $fn=5);
  }
}

module big_hole() {
  hull() {
    translate([0,height/7,0])
      rotate([0,0,45])
        cube([height/2.75, height/2.75, 15], center=true);
    translate([0,-(height/7),0])
      cylinder(d=height/1.94, h=15, $fn=fn, center=true);
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
          // translate([-90,-20,0]) rotate([0,0,-5]) cube([radius,radius*2,height]);
        }

        translate([-6.5,39.5,26.0]) rotate([90,81,0]) biscuit();
        translate([-7.0,35,26.0]) rotate([90,81,0]) biscuit();
      }

      // // dual screw holes
      // translate([-3,41,10.5]) rotate([90,0,0]) cylinder(d=2.5, h=15, $fn=fn);
      // translate([-4.75,41,23.5]) rotate([90,0,0]) cylinder(d=2.5, h=15, $fn=fn);

      // single breakaway screw hole
      translate([-4.25,35,height/2]) rotate([90,0,0]) {
        // screw hole
        cylinder(d=2.75, h=15, $fn=fn, center=true);
        // breakaway
        // translate([3,0,0]) cube([5,1.75,15], center=true);
        rotate([0,0,40]) translate([3,0.4,0]) cube([7,1.75,15], center=true);
        rotate([0,0,-40]) translate([3.5,3,0]) cube([7,4.75,15], center=true);
      }

    }

    // outside cut
    // translate([-45,9,0]) rotate([0,0,50]) cube([50,10,height]);

    // big hole 1
    // translate([-25,46,height/2]) rotate([90,0,20]) cylinder(d=20, h=25, $fn=fn);
    translate([-18,34,height/2]) rotate([90,0,20]) {
      big_hole();
    }

    //big hole 2
    // translate([-45,30,height/2]) rotate([90,0,45]) cylinder(d=20, h=25, $fn=fn);
    translate([-39,23,height/2]) rotate([90,0,45]) {
      big_hole();
    }

    // cuff v cut top
    translate([-55,-15,10]) rotate([0,18,55]) cube([20,20,50]);

    // cuff v cut bottom
    translate([-55,-6,-10]) rotate([0,-15,55]) cube([20,20,50]);
  }
}

 whole_thing();
 mirror([0,1,0]) whole_thing();

// rotate([0,0,0]) translate([0,-25,0]) whole_thing();
// rotate([0,0,60]) translate([0,25,0]) mirror([0,1,0]) whole_thing();