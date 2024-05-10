module back(wire_diameter, net_gap, pin_diameter, back_thickness) {
  width = 5;
  module vertical() {
    linear_extrude(width) {
      difference() {
        circle(d = wire_diameter + 2 * back_thickness);
        circle(d = wire_diameter);
        translate([- wire_diameter / 2 - back_thickness, 0])
          square([wire_diameter + 2 * back_thickness, wire_diameter / 2 + back_thickness]);
      }
      translate([wire_diameter / 2, 0])
        square([back_thickness, net_gap + 3]);
      translate([- wire_diameter / 2 - back_thickness, 0])
        square([back_thickness, 3]);
    }
  }
  module half() {
    translate([0, 0, 10]) vertical();
    translate([wire_diameter / 2, 2, 0]) {
      difference() {
        cube([back_thickness, width, 10]);
        translate([0, width / 2, 0])
          rotate([90, 0, 90]) {
            cylinder(d = pin_diameter + 0.3, h = back_thickness);
            translate([- 0.2 / 2, - pin_diameter * 1.4 / 2, 0])
              cube([0.2, pin_diameter * 1.4, back_thickness]);
          }
      }
    }
    translate([wire_diameter / 2, net_gap + 3 - width, 0]) cube([back_thickness, width, 10]);
  }
  half();
  mirror([0, 0, 1]) half();
}

module hook(outer_hole_diameter, inner_hole_diameter, pin_diameter, back_thickness, plate_thickness) {
  cylinder(d = pin_diameter, h = back_thickness + plate_thickness + 3);
  translate([0, 0, back_thickness]) cylinder(d = inner_hole_diameter, h = plate_thickness + 3);
  translate([0, 0, back_thickness + plate_thickness]) cylinder(d = outer_hole_diameter, h = 3);
}
