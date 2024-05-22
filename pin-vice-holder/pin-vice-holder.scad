$fn = $preview ? 16 : 64;

one_pin_width = 10;
one_pin_height = 7;
one_pin_length = 60;

module one_pin(pin_diameter) {
  width = one_pin_width;
  height = one_pin_height;
  length = one_pin_length;
  function allowance(x) = (10 / 3) / (x + 11 / 3);
  difference() {
    union() {
      cube([height, width, length]);
      translate([height / 2, width / 2, 0]) rotate([0, 0, 180]) rotate([-90, 0, 0]) translate([- height / 2, 0, - width / 2]) linear_extrude(width) polygon([[0, 0], [height, 0], [0, height * sqrt(3)]]);
    }
    depth = (floor((pin_diameter - 0.1) / 0.5) + 1) * 10;
    p = pin_diameter <= 0.5? 1: pin_diameter < 1? 1.5: pin_diameter;
    translate([height / 3, width / 3, length - depth]) cylinder(d = pin_diameter + allowance(pin_diameter), depth);
    translate([height * 2 / 3, width * 2 / 3, length - depth]) cylinder(d = p + allowance(p), depth);
  }
}

rotate([0, 30, 0]) translate([- one_pin_height * 6, 0, one_pin_height * sqrt(3) * 6])
  for(i = [0:29]) {
    j = 29 - i;
    w = one_pin_height * floor(j / 5);
    h = one_pin_width * (j % 5);
    d = - one_pin_height * sqrt(3) * floor(j / 5);
    p = 0.1 + 0.1 * i;
    translate([w, h, d]) one_pin(p);
  }

mirror([0, 1, 0]) rotate([90, 0, 0]) linear_extrude(5 * one_pin_width) polygon([[0, 0], [one_pin_length / 2, 0], [one_pin_length / 2, one_pin_length / 2 * sqrt(3) + 0.01]]);
