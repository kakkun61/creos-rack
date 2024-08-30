module name() {
  linear_extrude(5) {
    translate([15, 5]) {
      scale([0.52, 0.52]) {
        translate([4.5, 100])
          import("name-1.svg");
        import("name-2.svg");
      }
    }
  };
}

module plate() {
  difference() {
    cube([80, 120, 5]);
    translate([40, 112, 0]) {
      cylinder(d = 6.5, h = 40, center = true);
      translate([0, 6.5 / 2, 0])
        cylinder(d = 3.5, h = 40, center=true);
    }
  };
}

// difference() {
//   plate();
//   name();
// };

plate();
