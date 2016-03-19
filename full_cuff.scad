// ellipsoidal was measured as 23.8mm by 17.3
ellipse_1 = 17.8; // 17.3;
ellipse_2 = 24.3; // 23.8;

height=35;

module core_ellipse(wall_thickness=3) {
  scale([1,ellipse_2/ellipse_1,1]) {
    difference() {
      cylinder(h=height, d=ellipse_1+wall_thickness, center=true, $fn=50);
      cylinder(h=height, d=ellipse_1, center=true, $fn=50);
    }
  }
}

// core_ellipse();

od_1 = 91.0;
od_2 = 150; // guess

id_1 = 82; // guess
id_2 = 90; // guess

module cutouts() {
  // for handle
  translate([-60.2,0,0]) rotate([0,0,90]) scale([1,ellipse_2/ellipse_1,1]) cylinder(h=height, d=ellipse_1, center=true, $fn=64);

  // translate([-52,21,0]) rotate([0,0,130]) scale([0.8,ellipse_2/ellipse_1,1]) cylinder(h=height, d=ellipse_1, center=true, $fn=64);

  translate([-32,36,0]) rotate([0,0,110]) scale([0.35,ellipse_2/ellipse_1,1]) cylinder(h=height, d=ellipse_1, center=true, $fn=64);

  // mirror([0,1,0]) translate([-52,21,0]) rotate([0,0,130]) scale([0.8,ellipse_2/ellipse_1,1]) cylinder(h=height, d=ellipse_1, center=true, $fn=64);

  mirror([0,1,0]) translate([-32,36,0]) rotate([0,0,110]) scale([0.35,ellipse_2/ellipse_1,1]) cylinder(h=height, d=ellipse_1, center=true, $fn=64);
}

module support_side() {
  difference() {
    union() {
      difference() {
        difference() {
          scale([od_2/od_1,1,1]) {
            cylinder(h=height, d=od_1, center=true, $fn=50);
          }
          scale([id_2/id_1,1,1]) {
            cylinder(h=height, d=id_1, center=true, $fn=50);
          }
        }
        translate([41,0,0]) cube([80,100,height], center=true);

        cutouts();
      }

      // screw mount ridge
      translate([-74,0,0]) {
        difference() {
          // cylinder(h=height, d=20, center=true, $fn=50);
          cube([20, 20, height], center=true);
          translate([7,0,0]) cube([10,20,height], center=true);
        }

      }
    }

    // screw mount gap
    translate([-80,0,0]) cube([20,2,height], center=true);
  }
}

module opening_side() {
  difference() {
    difference() {
      // scale([od_2/od_1,1,1]) {
      scale([1.45,1,1]) {  
        cylinder(h=height, d=od_1, center=true, $fn=50);
      }
      scale([((id_2/id_1)*1.37)+0.03,1,1]) {
        cylinder(h=height, d=id_1, center=true, $fn=50);
      }

    }
    translate([-41,0,0]) cube([80,100,height], center=true);

    // cuff cut
    translate([65,0,0]) cube([5,2,height,], center=true);
    // rotate([-11,0,0]) translate([65,1,0]) cube([10,4,height*2], center=true);
    // rotate([11,0,0]) translate([65,-1,0]) cube([10,4,height*2], center=true);
  }
  

}

module lozenge(d=10, h=10) {
  translate([0,0,h/2]) sphere(d=d, center=true, $fn=50);
  cylinder(d=d, h=h, center=true, $fn=50);
  translate([0,0,-(h/2)]) sphere(d=d, center=true, $fn=50);
}

module support_side_weight_saving_cutouts() {
  translate([-44,-45,0]) rotate([90,0,55]) scale([1,1.4,1]) lozenge(h=75, d=25);
  translate([-40,-45,0]) rotate([90,0,74]) scale([1,1.4,1])lozenge(h=75, d=25);
}

module opening_side_weight_saving_cutouts(d=10, h=10) {
  translate([5,-45,0]) rotate([90,0,0]) scale([1,3,1]) cylinder(d=d, h=h, center=true, $fn=50);
  translate([17,-42,0]) rotate([90,0,10]) scale([1,3,1]) cylinder(d=d, h=h, center=true, $fn=50);
  translate([28,-37,0]) rotate([90,0,19]) scale([1,3,1]) cylinder(d=d, h=h, center=true, $fn=50);
  translate([39,-32,0]) rotate([90,0,27]) scale([1,3,1]) cylinder(d=d, h=h, center=true, $fn=50);
  translate([49,-27,0]) rotate([90,0,37]) scale([1,3,1]) cylinder(d=d, h=h, center=true, $fn=50);
  translate([57,-19,0]) rotate([90,0,53]) scale([1,3,1]) cylinder(d=d, h=h, center=true, $fn=50);
}

module screw_hole() {
  rotate([90,0,0]) {
    cylinder(d=5.5, h=20, center=true, $fn=10);
    // translate([0,0,10]) cylinder(d=9, h=5, center=true, $fn=10);
    // translate([0,0,-10]) cylinder(d=9, h=5, center=true, $fn=10);
  }
}

// intersection() {
  difference() {
    union() {
      support_side();
      opening_side();
    }
    
    // support_side_weight_saving_cutouts();
    // mirror([0,1,0]) support_side_weight_saving_cutouts();
    // opening_side_weight_saving_cutouts();
    // mirror([0,1,0]) opening_side_weight_saving_cutouts();
    translate([-78,0,10]) screw_hole();
    translate([-78,0,-10]) screw_hole();
    translate([-78,0,0]) screw_hole();
  }
//   translate([-85,-30,-20]) cube([50,60,16]);
// }
