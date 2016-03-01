$fn=60;

element_height=17;
element_count=3;
width=17;
thickness=17;
d_light=5.1;
shade_thickness=2;
shade_size=34;
element_bevel=0.1;
traffic_light_bevel=sqrt(2*thickness*thickness);
d_pole_hole=10;
h_pole_hole=10;
d_wire_hole=15;

//translate([0,-element_height*0.5-2,-thickness*0]) rotate([90,0,0]) cylinder(d=d_pole_hole, h=h_pole_hole-2, center=true);


difference() {
    union() {
        rotate([0,-45,0]) trafficlight();
        rotate([0,45,0]) trafficlight();
    }
    translate([0,-element_height*0.5,-thickness*0]) rotate([90,0,0]) cylinder(d=d_pole_hole, h=h_pole_hole, center=true);
    
    translate([0,(element_count-1)*element_height*0.5-1,0]) rotate([90,0,0]) cylinder(d=d_wire_hole, h=element_count*element_height-h_pole_hole, center=true);
}

module trafficlight() {
    difference() {
            for(i = [1:element_count]) {
                translate([0,element_height*(i-1),0]){
                    union(){
	            difference() {
                        difference() {
		            cube([width,element_height,thickness], center=true);
                            translate([width*0.5, 0, thickness*0.5]) rotate([0,45,0]) cube([element_bevel, element_height, element_bevel], center=true);
                            translate([0, element_height*0.5, thickness*0.5]) rotate([0,45,90]) cube([element_bevel, element_height, element_bevel], center=true);
                            translate([-width*0.5, 0, thickness*0.5]) rotate([0,45,0]) cube([element_bevel, element_height, element_bevel], center=true);
                            translate([0, -element_height*0.5, thickness*0.5]) rotate([0,45,90]) cube([element_bevel, element_height, element_bevel], center=true);
                        }
		        cylinder(d=d_light, h=thickness*2, center=true);
	            }
                    shade(i);
                }                
            }
	}
        translate([width*0.5, element_height, -thickness*0.5]) rotate([0,45,0]) cube([traffic_light_bevel, element_height*element_count+0.1, traffic_light_bevel], center=true);
        translate([-width*0.5, element_height, -thickness*0.5]) rotate([0,45,0]) cube([traffic_light_bevel, element_height*element_count+0.1, traffic_light_bevel], center=true);
        translate([0,element_height,-thickness*0.5]) rotate([90,0,0]) cylinder(d=width*0.7,h=element_count*element_height, center=true);
    }
    
}

module shade(i) {
    intersection(){
        difference() {
            difference() {
                cylinder(d=d_light+shade_thickness, h=shade_size, center=true);
                cylinder(d=d_light, h=shade_size, center=true);
            }
            translate([0,-shade_size*0.5,0]) cube([d_light+shade_thickness,d_light+shade_thickness,shade_size], center=true);
        }
        translate([0,d_light*0.5,thickness*0.5])
        rotate([0,90,0])
        resize([shade_size*0.5+thickness*0.5, (d_light+(shade_thickness*0.5)), width])
        cylinder(d=1, h=1, center=true);
    }
}