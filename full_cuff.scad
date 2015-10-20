// ellipsoidal was measured as 23.8mm by 17.3
ellipse_1 = 17.8; // 17.3;
ellipse_2 = 24.3; // 23.8;

module core_ellipse(wall_thickness=3) {
  scale([1,ellipse_2/ellipse_1,1]) {
    difference() {
      cylinder(h=2, d=ellipse_1+wall_thickness, center=true, $fn=50);
      cylinder(h=2, d=ellipse_1, center=true, $fn=50);
    }
  }
}

// core_ellipse();

od_1 = 91.0;
od_2 = 150; // guess

id_1 = 82; // guess
id_2 = 90; // guess

difference() {
  difference() {
    scale([od_2/od_1,1,1]) {
      cylinder(h=2, d=od_1, center=true, $fn=50);
    }
    scale([id_2/id_1,1,1]) {
      cylinder(h=2, d=id_1, center=true, $fn=50);
    }
  }
  translate([40,0,0]) cube([80,100,2], center=true);
  translate([-60,0,0]) rotate([0,0,90]) scale([1,ellipse_2/ellipse_1,1]) cylinder(h=2, d=ellipse_1, center=true, $fn=50);

  translate([-52,21,0]) rotate([0,0,130]) scale([0.8,ellipse_2/ellipse_1,1]) cylinder(h=2, d=ellipse_1, center=true, $fn=50);

  translate([-32,36,0]) rotate([0,0,110]) scale([0.35,ellipse_2/ellipse_1,1]) cylinder(h=2, d=ellipse_1, center=true, $fn=50);

  mirror([0,1,0]) translate([-52,21,0]) rotate([0,0,130]) scale([0.8,ellipse_2/ellipse_1,1]) cylinder(h=2, d=ellipse_1, center=true, $fn=50);

  mirror([0,1,0]) translate([-32,36,0]) rotate([0,0,110]) scale([0.35,ellipse_2/ellipse_1,1]) cylinder(h=2, d=ellipse_1, center=true, $fn=50);
}