/*

Blank Super 8 cartridge shell exterior
Jenny List 2022
CC-BY-SA 4.0

Front is across the X axis

*/

//outside profile of main part of the film cartridge
module SuperEightOutline(OutlineWidth=68,OutlineDepth=74,OutlineHeight=21,CornerRadius=10){
    cube([OutlineWidth,OutlineDepth-CornerRadius,OutlineHeight]);
    linear_extrude(OutlineHeight){
        hull() {
            translate([OutlineWidth-CornerRadius,OutlineDepth-CornerRadius,0]) circle(CornerRadius,$fn=90);
            translate([CornerRadius,OutlineDepth-CornerRadius,0]) circle(CornerRadius,$fn=90);
        }
    }
}

// Making a solid film cartridge with no hollowing out
module SuperEightShell(){
    //...from bottom to top
    SuperEightOutline(71,76,1,11); // Bottom of the cartridge
    translate([1.5,0,1]) SuperEightOutline();; //Main body of the shell
    translate([0,0,22]) SuperEightOutline(71,76,1,10.4); // Top of the cartridge. 1.6mm thick for PCB
    cube([71,5,23]); //Strengthen and thicken the front
    translate([11,73.25,00]) cube([9,3,2]); //left protrusion
    translate([51,73.25,00]) cube([9,3,2]); //right protrusion
}

// Hollowing out the bits to make a useful cartridge
module SuperEightCartridge(){
    difference() {
        SuperEightShell();
        translate([34.5,0,23]) rotate([-90,0,0]) cube([4,5,8]); // alignment pin 
        translate([38,1.75,9]) cube([28,3.5,12],true); // Where the film would go
        translate([35.625,41,0]) cylinder(3,10,6,$fn=90); //space for film winder to sit
        translate([24,9.2,-5.5]) rotate([65,0,0]) cube ([28,5,20]); //slide in
        translate([3.5,5,4]) SuperEightOutline(64,68,19,8); //Main cut-out inside
    }
}

SuperEightCartridge();