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

module plate() {
  cube([plate_width, plate_length, plate_height]);
}

module gauge_holder() {
  difference() {
    cube([gauge_holder_width, micro_switch_height, gauge_holder_height]);
    translate(
      [ 0,
        micro_switch_height,
        (gauge_holder_height - micro_switch_length) / 2
      ]
    )
      rotate([90, 0, 0])
      micro_switch();
    translate(
      [ gauge_holder_width - micro_switch_width,
        micro_switch_height,
        (gauge_holder_height - micro_switch_length) / 2
      ]
    )
      rotate([90, 0, 0])
      micro_switch();
    translate(
      [ (gauge_holder_width - micro_switch_length) / 2,
        micro_switch_height,
        gauge_holder_height
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
translate([0, plate_length / 2 + 1, 0])
  gauge_holder();
