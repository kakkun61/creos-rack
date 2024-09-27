include <BOSL2/std.scad>
include <BOSL2/screws.scad>

use <../aru-model/aru-power.scad>

$fn = $preview ? 16 : 64;

scale = 1 / 80;
plate_width = 2744 * scale;
plate_length = 21000 * scale;
plate_height = 2;

gauge_holder_width = plate_width;
gauge_holder_length = 10;
gauge_holder_height = 40 - plate_height;

micro_switch_width = 6.70;
micro_switch_length = 12.90;
micro_switch_height = 6.65;
micro_switch_pin_width_offset = 2.55;

buzzer_diameter = 30.35;
buzzer_height = 10.00;

bogey_position_y = 40;
bogey_position_z = 4;

aru_power_model_number = aru_power_c4004();

bogey_hole_diameter = sqrt(aru_power_box_width(aru_power_model_number) ^ 2 + aru_power_box_length(aru_power_model_number) ^ 2) + 2;

module bogey_hole() {
  intersection() {
    circle(d = bogey_hole_diameter);
    union() {
      rot(0) square([aru_power_box_width(aru_power_model_number) + 2, 100], center = true);
      rot(20) square([aru_power_box_width(aru_power_model_number) + 2, 100], center = true);
      rot(-20) square([aru_power_box_width(aru_power_model_number) + 2, 100], center = true);
      circle(d = aru_power_box_width(aru_power_model_number) + 2 * (aru_power_box_contact_pad_gap(aru_power_model_number) + aru_power_contact_pad_diameter(aru_power_model_number)) + 2);
    }
  }
}

module plate(
  anchor,
  spin,
  orient
) {
  attachable(anchor, spin, orient, size = [plate_width, plate_length, plate_height]) {
    translate([- plate_width / 2, - plate_length / 2, - plate_height / 2])
      linear_extrude(plate_height)
        difference() {
          square([plate_width, plate_length]);
          translate([plate_width / 2, bogey_position_y])
            bogey_hole();
          translate([plate_width / 2, plate_length - bogey_position_y])
            bogey_hole();
        }
    children();
  }
}

module gauge_holder(
  anchor,
  spin,
  orient
) {
  size = [gauge_holder_width, micro_switch_height, gauge_holder_height];
  attachable(anchor, spin, orient, size = size) {
    translate([- gauge_holder_width / 2, - micro_switch_height / 2, - gauge_holder_height / 2])
      diff()
        cube(size = size, anchor = anchor, spin = spin, orient = orient) {
          attach(FRONT, TOP, inside = true)
            screw_hole("M8x1", length = micro_switch_height, tolerance = "6G", thread = true);
          attach(RIGHT, TOP, inside = true, shiftout = 0.01)
            micro_switch();
          attach(TOP, TOP, inside = true, shiftout = 0.01, spin = 90)
            micro_switch();
          attach(LEFT, TOP, inside = true, shiftout = 0.01)
            micro_switch();
        }
    children();
  }
}

module gauge_holder_screw() {
  micro_switch_jump_height = 5;
  gauge_plate_height = 1;
  screw(
    "M8x1",
    length = micro_switch_jump_height + gauge_plate_height + micro_switch_height,
    thread_len = micro_switch_height,
    head = "pan",
    drive = "slot",
    tolerance = "6e",
    thread = true
  );
}

module micro_switch() {
  cube([micro_switch_width, micro_switch_length, micro_switch_height]);
}

plate() {
  attach(TOP, BOTTOM)
    gauge_holder();
}

down(bogey_position_z)
  back(- plate_length / 2 + bogey_position_y)
    aru_power(aru_power_model_number);

down(bogey_position_z)
  back(plate_length / 2 - bogey_position_y)
    aru_power(aru_power_model_number);

right(30) gauge_holder_screw();
