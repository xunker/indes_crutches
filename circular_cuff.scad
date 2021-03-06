height=35;
cutout_height = height + 1;

// for opening side
od_1 = 100.0;
id_1 = 90;

// for support side
od_2 = 150;
id_2 = 90;

screw_mount_width = 26;

screw_x_offset = -77;

cuff_facets = 50;

module cutouts() {
  ellipse_1 = 17.5; // 17.8
  ellipse_2 = 24.3;

  // center, for handle
  translate([-60.2,0,0])
    rotate([0,0,90])
      scale([1,ellipse_2/ellipse_1,1])
        cylinder(h=cutout_height, d=ellipse_1, center=true, $fn=64);

  module cutout() {
    /*translate([-37,37,0])
      rotate([0,0,120])
        scale([0.35,1.5,1])
          cylinder(h=cutout_height, d=ellipse_1, center=true, $fn=8);
    translate([-48,27,0])
      rotate([0,0,150])
        scale([0.35,1.25,1])
          cylinder(h=cutout_height, d=ellipse_1, center=true, $fn=8);*/
    hull() {
      facets = 8;
      translate([-37,37,0])
        cylinder(h=cutout_height, d=5, center=true, $fn=facets);
      translate([-47,33,0])
        cylinder(h=cutout_height, d=5, center=true, $fn=facets);
      translate([-54,20,0])
        cylinder(h=cutout_height, d=15, center=true, $fn=facets);
    }
  }

  cutout();

  mirror([0,1,0]) cutout();
}

module support_side() {
  difference() {
    union() {
      difference() {
        difference() {
          // outer
          scale([od_2/od_1,1,1]) {
            cylinder(h=height, d=od_1, center=true, $fn=cuff_facets);
          }

          // inner
          scale([id_2/id_1,1.01,1]) {
            cylinder(h=cutout_height, d=id_1, center=true, $fn=cuff_facets);
          }
        }
        // cut off ellipses at middle
        translate([41,0,0]) cube([80,100,cutout_height], center=true);
      }

      // screw mount ridge
      translate([screw_x_offset+1,0,0]) {
        difference() {
          cube([11, screw_mount_width, height], center=true);
        }
      }
    }

    cutouts();

    // screw mount gap
    translate([screw_x_offset,0,0]) cube([20,2,height], center=true);
  }
}

module opening_side() {
  difference() {
    difference() {
      // outer
      scale([1.17,1,1]) {
        cylinder(h=height, d=od_1, center=true, $fn=cuff_facets);
      }

      // inner
      translate([-0.5,0,0]) {
        scale([1.25,1.01,1]) {
          cylinder(h=cutout_height, d=id_1, center=true, $fn=cuff_facets);
        }
      }

    }
    // cut off ellipses at middle
    translate([-41,0,0]) cube([80,100,cutout_height], center=true);

    // cuff front opening
    translate([60,0,0]) {
      rotate([0,270,0]) linear_extrude(height=10) polygon(points=[[0,0],[20,-7.5],[20,7.5]]);
      translate([0,0,13])
        rotate([0,270,0]) linear_extrude(height=10) polygon(points=[[0,0],[5,-10],[5,10]]);
        translate([0,0,-13])
          rotate([0,270,0]) linear_extrude(height=10) polygon(points=[[0,0],[-5,-5],[-5,5]]);
      cube([10,1,height,], center=true);
    }
  }
}

module screw_hole() {
  rotate([90,0,0]) {
    cylinder(d=5.5, h=screw_mount_width, center=true, $fn=10);
  }
}

module full_cuff() {
  difference() {
    union() {
      support_side();
      opening_side();
    }

    translate([screw_x_offset,0,0]) {
      translate([0,0,10]) screw_hole();
      translate([0,0,-10]) screw_hole();
      translate([0,0,0]) screw_hole();
    }
  }
}

/*support_side();*/
/*opening_side();*/
// intersection() {
  full_cuff();
  // translate([-85,-25,-14]) cube([50,50,8]);
  // translate([-85,-50,-18]) cube([200,200,2]);
// }
