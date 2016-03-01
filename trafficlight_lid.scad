$fn=60;

box_width=30;
box_length=60;
box_corner_radius=8;
box_wall=4;
inset_height=2;
lid_height=4;

screwpost_dia=8;
screwhole_dia=2;
screwhole_depth=10;
screw_inset_dia=7.5;
screw_inset_height=2.5;

difference() {
    lid();
    screwholes();
}



module screwhole()
{
    cylinder(d=screwhole_dia, h=lid_height+inset_height+10, center=true);
    translate([0,0,-lid_height/2+screw_inset_height/2]) cylinder(d=screw_inset_dia,h=screw_inset_height, center=true);
}


module screwholes()
{
    translate([box_width/2+box_corner_radius/3,box_length/2+box_corner_radius/3,0]) screwhole();  
    translate([-box_width/2-box_corner_radius/3,box_length/2+box_corner_radius/3,0]) screwhole(); 
    translate([box_width/2+box_corner_radius/3,-box_length/2-box_corner_radius/3,0]) screwhole(); 
    translate([-box_width/2-box_corner_radius/3,-box_length/2-box_corner_radius/3,0]) screwhole();
}


module lid() {
    hull(){
        cube([box_width,box_length,lid_height], center=true);
        translate([box_width/2,box_length/2,0]) cylinder(r=box_corner_radius, h=lid_height, center=true);
        translate([-box_width/2,box_length/2,0]) cylinder(r=box_corner_radius, h=lid_height, center=true);
        translate([box_width/2,-box_length/2,0]) cylinder(r=box_corner_radius, h=lid_height, center=true);
        translate([-box_width/2,-box_length/2,0]) cylinder(r=box_corner_radius, h=lid_height, center=true);
    }
    translate([0,0,lid_height/2+inset_height/2]) {
        hull() {
            translate([0,0,0]) cube([box_width-box_wall*2,box_length-box_wall*2,inset_height], center=true);
            translate([box_width/2-box_wall/2,box_length/2-box_wall/2,0]) cylinder(r=box_corner_radius, h=inset_height, center=true);
            translate([-box_width/2+box_wall/2,box_length/2-box_wall/2,0]) cylinder(r=box_corner_radius, h=inset_height, center=true);
            translate([box_width/2-box_wall/2,-box_length/2+box_wall/2,0]) cylinder(r=box_corner_radius, h=inset_height, center=true);
            translate([-box_width/2+box_wall/2,-box_length/2+box_wall/2,0]) cylinder(r=box_corner_radius, h=inset_height, center=true);
        }
    }
}