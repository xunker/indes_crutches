height=35;
cutout_height = height + 1;

// for opening side
od_1 = 100.0;
id_1 = 90; // guess

// for support side
od_2 = 150; // guess
id_2 = 90; // guess

module cutouts() {
  // ellipsoidal was measured as 23.8mm by 17.3
  ellipse_1 = 17.8; // 17.3;
  ellipse_2 = 24.3; // 23.8;

  // center, for handle
  translate([-60.2,0,0])
    rotate([0,0,90])
      scale([1,ellipse_2/ellipse_1,1])
        cylinder(h=cutout_height, d=ellipse_1, center=true, $fn=64);

  module cutout() {
    translate([-39,35,0])
      rotate([0,0,120])
        scale([0.35,2,1])
          cylinder(h=cutout_height, d=ellipse_1, center=true, $fn=64);
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
            cylinder(h=height, d=od_1, center=true, $fn=50);
          }

          // inner
          scale([id_2/id_1,1,1]) {
            cylinder(h=cutout_height, d=id_1, center=true, $fn=50);
          }
        }
        // cut off ellipses at middle
        translate([41,0,0]) cube([80,100,cutout_height], center=true);

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
      // outer
      scale([1.17,1,1]) {
        cylinder(h=height, d=od_1, center=true, $fn=50);
      }

      // inner
      scale([((id_2/id_1)*1.23),1,1]) {
        cylinder(h=cutout_height, d=id_1, center=true, $fn=50);
      }

    }
    // cut off ellipses at middle
    translate([-41,0,0]) cube([80,100,cutout_height], center=true);

    // cuff from opening
    translate([57,0,0]) cube([5,2,height,], center=true);
  }
}

module screw_hole() {
  rotate([90,0,0]) {
    cylinder(d=5.5, h=20, center=true, $fn=10);
  }
}


module full_cuff() {
  difference() {
    union() {
      support_side();
      opening_side();
    }

    translate([-78,0,10]) screw_hole();
    translate([-78,0,-10]) screw_hole();
    translate([-78,0,0]) screw_hole();
  }
}

/*support_side();
opening_side();*/
full_cuff();
