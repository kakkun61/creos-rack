include <BOSL2/std.scad>;

$fn = $preview ? 16 : 64;

c4004 = 0;
model_numbers = [ c4004 ];

function aru_power_c4004() = c4004;
function aru_power_model_numbers() = model_numbers;

name_index                       = 0;
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
wheel_shaft_offset_z_index       = 18;
wheel_tire_wide_diameter_index   = 19;
wheel_tire_narrow_diameter_index = 20;
wheel_tire_height_index          = 21;
wheel_flange_diameter_index      = 22;
wheel_flange_height_index        = 23;
box_wheel_gap_index              = 24;
wheel_gap_index                  = 25;
wheel_dent_depth_index           = 26;
wheel_dent_diameter_index        = 27;

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
     9.85, // wheel_shaft_offset_z
    10.60, // wheel_tire_wide_diameter
    10.30, // wheel_tire_narrow_diameter
     2.10, // wheel_tire_height
    12.70, // wheel_flange_diameter
     0.60, // wheel_flange_height
     1.00, // box_wheel_gap
    23.00, // wheel_gap
     1.50, // wheel_dent_depth
     9.00, // wheel_dent_diameter
  ]
];

function aru_power_data(model_number) = data[model_number];

function aru_power_name(model_number) = data[model_number][name_index];
function aru_power_box_width(model_number) = data[model_number][box_width_index];
function aru_power_box_length(model_number) = data[model_number][box_length_index];
function aru_power_box_height(model_number) = data[model_number][box_height_index];
function aru_power_box_upper_height(model_number) = data[model_number][box_upper_height_index];
function aru_power_box_lower_length(model_number) = data[model_number][box_lower_length_index];
function aru_power_axis_base_diameter(model_number) = data[model_number][axis_base_diameter_index];
function aru_power_axis_base_height(model_number) = data[model_number][axis_base_height_index];
function aru_power_axis_pin_diameter(model_number) = data[model_number][axis_pin_diameter_index];
function aru_power_axis_pin_height(model_number) = data[model_number][axis_pin_height_index];
function aru_power_axis_pin_hole_diameter(model_number) = data[model_number][axis_pin_hole_diameter_index];
function aru_power_coupler_base_width(model_number) = data[model_number][coupler_base_width_index];
function aru_power_coupler_base_length(model_number) = data[model_number][coupler_base_length_index];
function aru_power_coupler_base_height(model_number) = data[model_number][coupler_base_height_index];
function aru_power_coupler_base_hole_diameter(model_number) = data[model_number][coupler_base_hole_diameter_index];
function aru_power_coupler_base_hole_offset(model_number) = data[model_number][coupler_base_hole_offset_index];
function aru_power_wheel_shaft_diameter(model_number) = data[model_number][wheel_shaft_diameter_index];
function aru_power_wheel_shaft_length(model_number) = data[model_number][wheel_shaft_length_index];
function aru_power_wheel_shaft_offset_z(model_number) = data[model_number][wheel_shaft_offset_z_index];
function aru_power_wheel_tire_wide_diameter(model_number) = data[model_number][wheel_tire_wide_diameter_index];
function aru_power_wheel_tire_narrow_diameter(model_number) = data[model_number][wheel_tire_narrow_diameter_index];
function aru_power_wheel_tire_height(model_number) = data[model_number][wheel_tire_height_index];
function aru_power_wheel_flange_diameter(model_number) = data[model_number][wheel_flange_diameter_index];
function aru_power_wheel_flange_height(model_number) = data[model_number][wheel_flange_height_index];
function aru_power_box_wheel_gap(model_number) = data[model_number][box_wheel_gap_index];
function aru_power_wheel_gap(model_number) = data[model_number][wheel_gap_index];
function aru_power_wheel_dent_depth(model_number) = data[model_number][wheel_dent_depth_index];
function aru_power_wheel_dent_diameter(model_number) = data[model_number][wheel_dent_diameter_index];

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

module aru_power_wheel(
  model_number,
  anchor = CENTER,
  spin = 0,
  orient = UP
) {
  _ = assert(in_list(model_number, model_numbers), "invalid model number");
  datum = data[model_number];
  wheel_tire_narrow_diameter = datum[wheel_tire_narrow_diameter_index];
  wheel_tire_wide_diameter = datum[wheel_tire_wide_diameter_index];
  wheel_tire_height = datum[wheel_tire_height_index];
  wheel_flange_diameter = datum[wheel_flange_diameter_index];
  wheel_flange_height = datum[wheel_flange_height_index];
  wheel_dent_diameter = datum[wheel_dent_diameter_index];
  wheel_dent_depth = datum[wheel_dent_depth_index];
  attachable(anchor, spin, orient, d1 = wheel_flange_diameter, d2 = wheel_tire_narrow_diameter, l = wheel_tire_height + wheel_flange_height) {
    up(wheel_flange_height / 2) {
      diff()
        cyl(d1 = wheel_tire_wide_diameter, d2 = wheel_tire_narrow_diameter, h = wheel_tire_height) {
          attach(BOTTOM, TOP)
            cyl(d = wheel_flange_diameter, h = wheel_flange_height);
          attach(TOP, TOP, inside = true)
            cyl(d = wheel_dent_diameter, h = wheel_dent_depth);
        }
    }
    children();
  }
}

module aru_power(model_number){
  _ = assert(in_list(model_number, model_numbers), "invalid model number");
  aru_power_box(model_number) {
    datum = data[model_number];
    box_wheel_gap = datum[box_wheel_gap_index];
    box_height = datum[box_height_index];
    wheel_shaft_diameter = datum[wheel_shaft_diameter_index];
    wheel_shaft_offset_z = datum[wheel_shaft_offset_z_index];
    wheel_gap = datum[wheel_gap_index];
    attach(TOP, BOTTOM)
      aru_power_axis(model_number);
    align(FRONT, TOP, inset = data[c4004][box_upper_height_index])
      aru_power_coupler_base(model_number);
    align(BACK, TOP, inset = data[c4004][box_upper_height_index])
      aru_power_coupler_base(model_number, spin = 180);
    fwd(wheel_gap / 2)
      down(wheel_shaft_offset_z - box_height / 2)
        attach(RIGHT, BOTTOM, shiftout = box_wheel_gap)
          aru_power_wheel(model_number);
    back(wheel_gap / 2)
      down(wheel_shaft_offset_z - box_height / 2)
        attach(RIGHT, BOTTOM, shiftout = box_wheel_gap)
          aru_power_wheel(model_number);
    fwd(wheel_gap / 2)
      down(wheel_shaft_offset_z - box_height / 2)
        attach(LEFT, BOTTOM, shiftout = box_wheel_gap)
          aru_power_wheel(model_number);
    back(wheel_gap / 2)
      down(wheel_shaft_offset_z - box_height / 2)
        attach(LEFT, BOTTOM, shiftout = box_wheel_gap)
          aru_power_wheel(model_number);
  }
}

aru_power(c4004);
