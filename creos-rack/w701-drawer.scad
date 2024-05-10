$fn = $preview ? 16 : 64;

bottom_thickness = 2;
side_thickness = 0.5;
face_thickness = 2 * side_thickness;
width = 36.5;
length = 251;
height = 20;
handle_width = 10;
handle_height = 2;
corner_radius = 3;

module rounded_square(size, radius, center = true) {
  if (center) {
    square([size.x - 2 * radius, size.y], center = true);
    square([size.x, size.y - 2 * radius], center = true);
    translate([- size.x / 2 + radius, - size.y / 2 + radius]) circle(r = radius);
    translate([size.x / 2 - radius, - size.y / 2 + radius]) circle(r = radius);
    translate([- size.x / 2 + radius, size.y / 2 - radius]) circle(r = radius);
    translate([size.x / 2 - radius, size.y / 2 - radius]) circle(r = radius);
  } else {
    translate([radius, 0]) square([size.x - 2 * radius, size.y], center = false);
    translate([0, radius]) square([size.x, size.y - 2 * radius], center = false);
    translate([radius, radius]) circle(r = radius);
    translate([size.x - radius, radius]) circle(r = radius);
    translate([radius, size.y - radius]) circle(r = radius);
    translate([size.x - radius, size.y - radius]) circle(r = radius);
  }
}

module bottom () {
  linear_extrude(height = bottom_thickness) {
    flange_width = width / 5;
    difference() {
      rounded_square([width, length], corner_radius, center = false);
      translate([flange_width, flange_width]) rounded_square([3 * flange_width, (length - 3 * flange_width) / 2], corner_radius, center = false);
      translate([flange_width, (length + flange_width) / 2]) rounded_square([3 * flange_width, (length - 3 * flange_width) / 2], corner_radius, center = false);
    }
  }
}

module side() {
  cube([side_thickness, length - 2 * corner_radius, height - bottom_thickness], center = false);
}

module face() {
  cube([width - 2 * corner_radius, face_thickness, height - bottom_thickness], center = false);
}

module corner() {
  hole_radius = corner_radius - face_thickness;
  d = corner_radius - hole_radius - side_thickness;
  linear_extrude(height = height) {
    intersection() {
      difference() {
        circle(r = corner_radius);
        translate([d, 0]) circle(r = hole_radius);
        square([d, hole_radius], center = false);
      }
      square([corner_radius, corner_radius], center = false);
    }
  }
}

module handle_hole() {
  translate([0, face_thickness, 0]) rotate([90, 0, 0]) linear_extrude(height = face_thickness) rounded_square([handle_width, handle_height], handle_height / 2, center = false);
}

bottom();
translate([0, corner_radius, bottom_thickness]) side();
translate([width - side_thickness, corner_radius, bottom_thickness]) side();
difference() {
  translate([corner_radius, 0, bottom_thickness]) face();
  translate([width / 2 - handle_width / 2, 0, height - handle_height - 2]) handle_hole();
}
translate([corner_radius, length - face_thickness, bottom_thickness]) face();
translate([corner_radius, corner_radius, 0]) rotate(a = [0, 0, 180]) corner();
translate([width - corner_radius, corner_radius, 0]) rotate(a = [0, 0, 180]) mirror([1, 0, 0]) corner();
translate([corner_radius, length - corner_radius, 0]) rotate(a = [0, 0, 0]) mirror([1, 0, 0]) corner();
translate([width - corner_radius, length - corner_radius, 0]) corner();
