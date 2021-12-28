; Bed.g sets up and then runs a Mesh bed probing routine (G29)
T10 ; Select Tool 10 (Probe)
M561 ; Set Identity Transform (Clears any existing bed-plane fitting)

G90 ; Set to Absolute Positioning
G1 X-180 Y-45 Z3 F8000 ; Move to X=0, Y=-45, and Z=3 at 8000 mm/min
G30 ; Probe the bed at the current XY position. When the probe is triggered, set the Z coordinate to the probe trigger height.

;Use with Flat Print Bed
M557 X-180:180 Y-80:80 P3:3 ; Define a 3x3 probing grid bounded for X between -180 and 180 and Y between -80 and 80

;Use with Dovetail Bed
;M557 X-180:180 Y-45:45 S90

;Rotary Axis level
;M557 X-100:100 Y-180:180 S50:40

G29 ; Probe the bed using the grid defined by M557, save the height map in /sys/heightmap.csv, and activate bed compensation
