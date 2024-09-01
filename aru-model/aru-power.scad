include <BOSL2/std.scad>;

$fn = $preview ? 16 : 64;

c4004 = 0;
model_numbers = [ c4004 ];

box_name_index                   = 0;
box_width_index                  = 1;
box_length_index                 = 2;
box_height_index                 = 3;
box_upper_height_index           = 4;
box_lower_length_index           = 5;
axis_base_diameter_index         = 6;
axis_base_height_index           = 7;
axis_pin_diameter_index          = 8;
axis_pin_height_index            = 9;
axis_pin_hole_diameter_index     = 10;
coupler_base_width_index         = 11;
coupler_base_length_index        = 12;
coupler_base_height_index        = 13;
coupler_base_hole_diameter_index = 14;
coupler_base_hole_offset_index   = 15;
wheel_shaft_diameter_index       = 16;
wheel_shaft_length_index         = 17;
wheel_shaft_offset_index         = 18;

data = [
  [ "アルパワー HO-23B",
    11.20, // box_width
    30.30, // box_length
    12.35, // box_height
     6.60, // box_upper_height
    31.30, // box_lower_length
     6.80, // axis_base_diameter
     0.40, // axis_base_height
     4.00, // axis_pin_diameter
     1.00, // axis_pin_height
     2.00, // axis_pin_hole_diameter
     7.90, // coupler_base_width
     7.90, // coupler_base_length
     0.60, // coupler_base_height
     2.00, // coupler_base_hole_diameter
     1.30, // coupler_base_hole_offset
     1.00, // wheel_shaft_diameter
    12.60, // wheel_shaft_length
     9.85, // wheel_shaft_offset
  ]
];

module aru_power_box(
  model_number,
  anchor = CENTER,
  spin = 0,
  orient = UP
) {
  _ = assert(in_list(model_number, model_numbers), "invalid model number");
  datum = data[model_number];
  upper_size = [
    datum[box_width_index],
    datum[box_length_index],
    datum[box_upper_height_index]
  ];
  lower_size = [
    datum[box_width_index],
    datum[box_lower_length_index],
    datum[box_height_index] - datum[box_upper_height_index]
  ];
  attachable(anchor, spin, orient, size = [upper_size.x, lower_size.y, upper_size.z + lower_size.z]) {
    up(lower_size.z / 2)
      cuboid(size = upper_size)
        attach(BOTTOM, TOP)
          cuboid(size = lower_size);
    children();
  }
}

module aru_power_axis(
  model_number,
  anchor = CENTER,
  spin = 0,
  orient = UP
) {
  _ = assert(in_list(model_number, model_numbers), "invalid model number");
  datum = data[model_number];
  pin_diameter = datum[axis_pin_diameter_index];
  pin_height = datum[axis_pin_height_index];
  base_diameter = datum[axis_base_diameter_index];
  base_height = datum[axis_base_height_index];
  pin_hole_diameter = datum[axis_pin_hole_diameter_index];
  attachable(anchor, spin, orient, d1 = base_diameter, d2 = pin_diameter, h = pin_height + base_height) {
    diff()
      up(base_height / 2) {
        cyl(d = pin_diameter, h = pin_height) {
          attach(BOTTOM, TOP)
            cyl(d = base_diameter, h = base_height);
        }
          attach(TOP, TOP, inside = true)
            cyl(d = pin_hole_diameter, h = pin_height + base_height);
      }
    children();
  }
}

module aru_power_coupler_base(
  model_number,
  anchor = CENTER,
  spin = 0,
  orient = UP
) {
  _ = assert(in_list(model_number, model_numbers), "invalid model number");
  datum = data[model_number];
  width = datum[coupler_base_width_index];
  length = datum[coupler_base_length_index];
  height = datum[coupler_base_height_index];
  hole_diameter = datum[coupler_base_hole_diameter_index];
  hole_offset = datum[coupler_base_hole_offset_index];
  attachable(anchor, spin, orient, size = [width, length, height]) {
    diff()
      cuboid(size = [width, length, height])
        attach(FRONT, FRONT, inside = true)
          up(hole_offset)
            cyl(d = hole_diameter, h = height + 0.01);
    children();
  }
}

aru_power_box(model_number = c4004) {
  attach(TOP, BOTTOM)
    aru_power_axis(model_number = c4004);
  align(FRONT, TOP, inset = data[c4004][box_upper_height_index])
    aru_power_coupler_base(model_number = c4004);
  align(BACK, TOP, inset = data[c4004][box_upper_height_index])
    aru_power_coupler_base(model_number = c4004, spin = 180);
}
