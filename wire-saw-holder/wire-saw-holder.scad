$fn = $preview ? 16 : 64;

thickness = 0.5;
wire_width = 7;
wire_thick_height = 10;
wire_thin_height = 5;
wire_length = 180;

module body() {
  difference() {
    cube([
      thickness + wire_width + thickness,
      thickness + wire_thick_height + thickness + (wire_thin_height + thickness) * 3,
      thickness + wire_length
    ]);
    translate([thickness, thickness, thickness]) cube([wire_width, wire_thick_height, wire_length]);
    translate([thickness, thickness + wire_thick_height + thickness, thickness])
      cube([wire_width, wire_thin_height, wire_length]);
    translate([thickness, thickness + wire_thick_height + thickness + wire_thin_height + thickness, thickness])
      cube([wire_width, wire_thin_height, wire_length]);
    translate([thickness, thickness + wire_thick_height + thickness + (wire_thin_height + thickness) * 2, thickness])
      cube([wire_width, wire_thin_height, wire_length]);
  }
}

module cap() {
  dowel = 2;
  catch = 1;
  allowance = 0.5;
  translate([catch / 2, 0, dowel]) {
    translate([thickness + wire_width / 2, thickness + wire_thick_height / 2, 0])
      scale([wire_width - allowance, wire_thick_height - allowance / 2])
      cylinder(d = 1, h = dowel);
    translate([thickness + wire_width / 2, thickness + wire_thick_height + thickness + wire_thin_height / 2, 0])
      scale([wire_width - allowance, wire_thin_height - allowance / 2])
      cylinder(d = 1, h = dowel);
    translate([thickness + wire_width / 2, thickness + wire_thick_height + thickness + wire_thin_height + thickness + wire_thin_height / 2, 0])
      scale([wire_width - allowance, wire_thin_height - allowance / 2])
      cylinder(d = 1, h = dowel);
    translate([thickness + wire_width / 2, thickness + wire_thick_height + thickness + (wire_thin_height + thickness) * 2 + wire_thin_height / 2, 0])
      scale([wire_width - allowance, wire_thin_height - allowance / 2])
      cylinder(d = 1, h = dowel);
  }
  cube([thickness + wire_width + thickness + catch, thickness + wire_thick_height + thickness + (wire_thin_height + thickness) * 3, dowel]);
}

// body();
translate([10, 0, 0]) cap();
