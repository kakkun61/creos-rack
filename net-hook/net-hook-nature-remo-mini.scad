$fn = $preview ? 16 : 64;

include <lib.scad>

outer_hole_diameter = 11;
inner_hole_diameter = 5;
wire_diameter = 2.7;
net_gap = 37;
pin_diameter = 2;
back_thickness = 2;
plate_thickness = 2;

// back(wire_diameter, net_gap, pin_diameter, back_thickness);

hook(outer_hole_diameter, inner_hole_diameter, pin_diameter, back_thickness, plate_thickness);
