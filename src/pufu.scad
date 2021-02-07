// PuFU (Personal Flying Umbrela)
// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// Source code: https://github.com/mihaioltean/pufu
// License: MIT

// all sizes are in millimeters

//------------------------------------------------------------------------
propeller_radius = 317;
propeller_width = 16.5;
propeller_thickness = 10;
BLDC_radius = 46;
BLDC_thickness = 30;
bar_length = 2000;
bar_radius = 15;
duct_radius = propeller_radius + 10;
duct_height = 100;
//------------------------------------------------------------------------
use <human.scad>
include <human_params.scad>
//------------------------------------------------------------------------
module BLDC(radius, thickness)
{
    // the motor
    color("black")
        cylinder(h = thickness, r = radius);
    
    // shaft
        cylinder(h = 20, r = 1.5);
    
}
//------------------------------------------------------------------------
module duct(radius, height)
{
    difference(){
        cylinder(h = height, r = radius);
        translate ([0, 0, -1]) cylinder(h = height + 2, r = radius - 1);
    }
}    
//------------------------------------------------------------------------
module propeller(radius, width, thickness)
{
    translate ([-radius, -width / 2, 0])
        color("black")
        cube([2 * radius, width, thickness]);
}
//------------------------------------------------------------------------
module motor_with_propeller()
{
    BLDC(BLDC_radius, BLDC_thickness);
    translate([0, 0, BLDC_thickness + 2])
        rotate([0, 0, 30]) propeller(300, BLDC_thickness, 10);
}
//------------------------------------------------------------------------
module bar_with_motors(bar_length, bar_radius)
{
    rotate([0, 90, 0])
        color("black")
        cylinder(r = bar_radius, h = bar_length, center = true);
    
    translate ([bar_length / 2 - duct_radius, 0, bar_radius])
            motor_with_propeller();
    
    translate ([bar_length / 2 - duct_radius, 0, bar_radius])
            duct(duct_radius, duct_height);
    
    translate ([-(bar_length / 2 - duct_radius), 0, bar_radius])
            motor_with_propeller();
    
    translate ([-(bar_length / 2 - duct_radius), 0, bar_radius])
            duct(duct_radius, duct_height);
}
//------------------------------------------------------------------------
module PuFU()
{
    bar_with_motors(bar_length, bar_radius);
    translate([0, 0, 30])
    rotate([0, 0, 90])
        bar_with_motors(bar_length, bar_radius);
}
//------------------------------------------------------------------------
module PuFU_with_human()
{
    // that is me
    human_with_back_pack();
    
    // now PuFU
    translate([0, 0, leg_length + body_height + hand_length]) 
        PuFU();
    
}
//------------------------------------------------------------------------
PuFU_with_human();