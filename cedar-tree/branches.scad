$fn = $preview ? 16 : 64;

depth = 0.6;
stem_diameter = 5.5;
stem_ring_thickness = 0.6;
branch_length = 35;
branch_width = 0.6;
number_branches = 15;

module branch() {
  translate([0, - branch_width / 2])
    square([branch_length, branch_width]);
}

linear_extrude(depth) {
  difference() {
    union() {
      circle(stem_diameter / 2 + stem_ring_thickness);
      for(i = [0 : number_branches - 1])
        rotate([0, 0, 360 / number_branches * i]) branch();
    }
    circle(stem_diameter / 2);
  }
}
