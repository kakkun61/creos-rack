depth = 315;
width = 242;
height = 70;
thickness = 0.4;

cell_width = (width + thickness) / 5 - thickness;
cell_depth = (depth + thickness) / 7 - thickness;

module width_separator() {
  difference() {
    cube([width, height, thickness]);
    for (i = [0 : 5 - 2]) {
      translate([cell_width * (i + 1) + thickness * i, 0, 0])
        cube([thickness + 0.5, height / 2 + 0.6, thickness]);
    }
  }
}

module depth_separator(unit = 7) {
  assert(unit <= 7, "unit must be greater than or equal to 7");
  depth = cell_depth * unit + thickness * (unit - 1);
  difference() {
    cube([depth, height, thickness]);
    for (i = [0 : unit - 2]) {
      translate([cell_depth * (i + 1) + thickness * i, 0, 0])
        cube([thickness + 0.5, height / 2 + 0.6, thickness]);
    }
  }
}

depth_separator(2);
