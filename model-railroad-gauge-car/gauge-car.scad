include <BOSL2/std.scad>

use <../aru-model/aru-power.scad>

$fn = $preview ? 16 : 64;

scale = 1 / 80;
plate_width = 2744 * scale;
plate_length = 21000 * scale;
plate_height = 2;

gauge_holder_width = plate_width;
gauge_holder_length = 10;
gauge_holder_height = 40;

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
        }
      }
}

module plate() {
  linear_extrude(plate_height)
  difference() {
    square([plate_width, plate_length]);
    translate([plate_width / 2, bogey_position_y])
      bogey_hole();
    translate([plate_width / 2, plate_length - bogey_position_y])
      bogey_hole();
  }
}

module gauge_holder() {
  difference() {
    cube([gauge_holder_width, micro_switch_height, gauge_holder_height - plate_height]);
    translate(
      [ 0,
        micro_switch_height,
        (gauge_holder_height - micro_switch_length) / 2 - plate_height
      ]
    )
      rotate([90, 0, 0])
      micro_switch();
    translate(
      [ gauge_holder_width - micro_switch_width,
        micro_switch_height,
        (gauge_holder_height - micro_switch_length) / 2 - plate_height
      ]
    )
      rotate([90, 0, 0])
      micro_switch();
    translate(
      [ (gauge_holder_width - micro_switch_length) / 2,
        micro_switch_height,
        gauge_holder_height - plate_height
      ]
    )
      rotate([0, 90, 0])
      rotate([90, 0, 0])
      micro_switch();
  }
  offset = micro_switch_pin_width_offset + 1;
  translate([offset, micro_switch_height, 0])
    cube([gauge_holder_width - 2 * offset, gauge_holder_length - micro_switch_height, gauge_holder_height - offset]);
}

module micro_switch() {
  cube([micro_switch_width, micro_switch_length, micro_switch_height]);
}

plate();

translate([0, plate_length / 2 + 1, plate_height])
  gauge_holder();

down(bogey_position_z)
  back(bogey_position_y)
    right(plate_width / 2)
      aru_power(aru_power_model_number);

down(bogey_position_z)
  back(plate_length - bogey_position_y)
    right(plate_width / 2)
      aru_power(aru_power_model_number);
