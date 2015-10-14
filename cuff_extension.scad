steven=40;
fn=100;

module main() {
  difference() {
    difference() {
      cylinder(r=steven, h=35, $fn=fn);
      translate([0,-10,0]) cylinder(r=steven, h=35, $fn=fn);
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
      // translate([-55,-20,-10]) {
      translate([-55,-21,-10]) {
        cube([45,65,65]);
      }
    }
  }
}

module biscuit() {

  lower_width = 4.7;
  upper_width = 5.3;
  upper_height = 21.0;
  lower_height = 21.0;
  // thickness = 4.2;
  // thickness = 3.2;
  thickness = 2.2;



  M = [ [ 1, 0.2, 0, 0 ],
         [ 0, 1, -0.2, 0 ],  // The "0.7" is the skew value; pushed along the y axis
         [ 0, 0, 1, 0 ],
         [ 0, 0, 0, 1 ] ] ;
   multmatrix(M) {  union() {
    cube([lower_height, lower_width, thickness], center=true);
   } }
 }

difference() {
  scale([1.25,1.0,1.0]) {
    difference() {
      main();
      translate([0,-2.5,0]) divot();
    }
  }
  translate([-60,-10,0]) cube([steven,steven*2,35]);
}
// translate([-5.5,33,17]) rotate([90,81,0]) biscuit();
translate([-4.5,37,17]) rotate([90,81,0]) biscuit();

translate([-5.25,32.5,17]) rotate([90,81,0]) biscuit();

