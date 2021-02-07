// human in OpenSCAD

// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// Source code: https://github.com/mihaioltean/pufu
// License: MIT

// all sizes are in millimeters

//------------------------------------------------------------------------
include <human_params.scad>
//------------------------------------------------------------------------
module leg()
{
    cylinder(h = leg_length, r = leg_radius);
}
//------------------------------------------------------------------------
module body()
{
    translate ([-body_width / 2, -body_thickness / 2, 0])
        cube([body_width, body_thickness, body_height]);
}
//------------------------------------------------------------------------
module hand()
{
    cylinder(h = hand_length, r = hand_radius);    
}
//------------------------------------------------------------------------
module head()
{
    sphere(r = head_radius);
}
//------------------------------------------------------------------------
module back_pack()
{
    color("green")
        cube ([body_width, body_thickness, body_height]);
}
//------------------------------------------------------------------------
module human()
{
    translate ([-(body_width / 2 - leg_radius), 0, 0]) leg();
    translate ([(body_width / 2 - leg_radius), 0, 0])  leg();
    translate ([0, 0, leg_length]) body();
    translate([-(body_width / 2 + hand_radius), 0, leg_length + body_height - hand_radius]) hand();
    translate([(body_width / 2 + hand_radius), 0, leg_length + body_height - hand_radius]) hand();
    translate ([0, 0, leg_length + body_height + head_radius]) head();
}
//------------------------------------------------------------------------
module human_with_back_pack()
{
    human();
    translate ([-body_width / 2, -2 * body_thickness, leg_length]) back_pack();
}
//------------------------------------------------------------------------
human_with_back_pack();