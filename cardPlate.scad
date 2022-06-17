// Render Control
$fa = 1;
$fs = 0.4;

// Dimensions: Badger
widthBadger = 86;
heightBadger = 49;

// Dimensions: Badger Plate
offsetHole = 2;
radiusHole = 1.5;

// Dimensions: ID Card
widthCard = 86;
heightCard = 55;
depthCard = 1.25;

// Dimensions: Fixings
lengthScrew = 3;
lengthNut = 1;
radiusNut = 2.1;

// Dimensions: General
radiusPlate = 1;
heightWall = 3;
bufferPlate = 2;
overhangWall = 3;

// Module: Hull
module hull_cyl() {
    cylinder(r=radiusPlate, h=lengthScrew + heightWall);
}

module hull_nut() {
    linear_extrude(height=lengthNut) {
        circle(r=radiusNut, $fn=6);
    }
    translate([0, 0, lengthNut - lengthScrew]) {
        cylinder(r=radiusHole, h=lengthScrew - lengthNut);
    }
}

// Model
render() {
    difference() {
        hull(){
            translate([radiusPlate, radiusPlate, 0]) {
                hull_cyl();
            }

            translate([widthCard + (2 * bufferPlate) - radiusPlate, radiusPlate, 0]) {
                hull_cyl();
            }

            translate([radiusPlate, heightCard + (2 * bufferPlate) - radiusPlate, 0]) {
                hull_cyl();
            }

            translate([widthCard + (2 * bufferPlate) - radiusPlate, heightCard + (2 * bufferPlate) - radiusPlate, 0]) {
                hull_cyl();
            }
        }

        translate([bufferPlate + offsetHole + radiusHole, bufferPlate + ((heightCard - heightBadger) / 2) + offsetHole + radiusHole, lengthScrew - lengthNut]) {
            hull_nut();
        }

        translate([bufferPlate + widthBadger - (offsetHole + radiusHole), bufferPlate + ((heightCard - heightBadger) / 2) + offsetHole + radiusHole, lengthScrew - lengthNut]) {
            hull_nut();
        }

        translate([bufferPlate + offsetHole + radiusHole, bufferPlate + heightBadger + ((heightCard - heightBadger) / 2) - (offsetHole + radiusHole), lengthScrew - lengthNut]) {
            hull_nut();
        }

        translate([bufferPlate + widthBadger - (offsetHole + radiusHole), bufferPlate + heightBadger + ((heightCard - heightBadger) / 2) - (offsetHole + radiusHole), lengthScrew - lengthNut]) {
            hull_nut();
        }

        translate([bufferPlate, bufferPlate, lengthScrew]) {
            cube([widthCard + bufferPlate, heightCard, depthCard]);
        }

        translate([bufferPlate + overhangWall, bufferPlate + overhangWall, lengthScrew + depthCard]) {
            cube([widthCard - overhangWall, heightCard - (2 * overhangWall), heightWall - depthCard]);
        }

        translate([bufferPlate + widthCard, bufferPlate + overhangWall, lengthScrew + depthCard]) {
            cube([bufferPlate, heightCard - (bufferPlate + overhangWall), heightWall - depthCard]);
        }
    }
}
