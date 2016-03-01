$fn=60;

pole_height = 66;
pole_dia=10;
pole_hole_dia=7;
box_height = 25;
box_width=30;
box_length=60;
box_corner_radius=8;
box_wall=4;

screwpost_dia=8;
screwhole_dia=2;
screwhole_depth=10;
inset=4;

button_width=12;
button_length=6;

difference() {
    union() {
        box();
        translate([0, box_length/4, box_height/2+pole_height/2-4]) cylinder(d=pole_dia, h=pole_height,center=true);
    }
    translate([0, box_length/4, box_height/2+pole_height/2-4]) cylinder(d=pole_hole_dia, h=pole_height, center=true);
    button_holes();
}
screwposts();


module button_holes() {
    translate([button_width/2,-box_length/3+button_length/2,box_height/2]) cylinder(d=2,h=10, center=true);
    translate([-button_width/2,-box_length/3+button_length/2,box_height/2]) cylinder(d=2,h=10, center=true);
    translate([button_width/2,-box_length/3-button_length/2,box_height/2]) cylinder(d=2,h=10, center=true);
    translate([-button_width/2,-box_length/3-button_length/2,box_height/2]) cylinder(d=2,h=10, center=true);
}

module screwpost()
{
    difference() {
        cylinder(d=screwpost_dia, h=box_height-inset, center=true);
        translate([0,0,-inset]) cylinder(d=screwhole_dia, h=box_height, center=true);
    }
}


module screwposts()
{
    translate([box_width/2+box_corner_radius/3,box_length/2+box_corner_radius/3,0]) screwpost();  
    translate([-box_width/2-box_corner_radius/3,box_length/2+box_corner_radius/3,0]) screwpost(); 
    translate([box_width/2+box_corner_radius/3,-box_length/2-box_corner_radius/3,0]) screwpost(); 
    translate([-box_width/2-box_corner_radius/3,-box_length/2-box_corner_radius/3,0]) screwpost();
}


module box() {
    difference() {
        hull(){
            cube([box_width,box_length,box_height], center=true);
            translate([box_width/2,box_length/2,0]) cylinder(r=box_corner_radius, h=box_height, center=true);
            translate([-box_width/2,box_length/2,0]) cylinder(r=box_corner_radius, h=box_height, center=true);
            translate([box_width/2,-box_length/2,0]) cylinder(r=box_corner_radius, h=box_height, center=true);
            translate([-box_width/2,-box_length/2,0]) cylinder(r=box_corner_radius, h=box_height, center=true);
        }     
        hull() {
            translate([0,0,-4]) cube([box_width-box_wall*2,box_length-box_wall*2,box_height], center=true);
            translate([box_width/2-box_wall/2,box_length/2-box_wall/2,-4]) cylinder(r=box_corner_radius, h=box_height, center=true);
            translate([-box_width/2+box_wall/2,box_length/2-box_wall/2,-4]) cylinder(r=box_corner_radius, h=box_height, center=true);
            translate([box_width/2-box_wall/2,-box_length/2+box_wall/2,-4]) cylinder(r=box_corner_radius, h=box_height, center=true);
            translate([-box_width/2+box_wall/2,-box_length/2+box_wall/2,-4]) cylinder(r=box_corner_radius, h=box_height, center=true);

        }
        translate([box_width/4,-box_length/4,0-box_height-2])cube([box_width*2,box_length*2, 5], center=true);
    }
}

