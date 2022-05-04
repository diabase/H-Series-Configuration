; Bed_rotary.g sets up and then runs a Mesh bed probing routine (G29), specifically for a rotary print bed
M291 P"Have you set your Xmin and Xmax for your setup? If not, this may crash" R"Limit Check" S3

T10 ; Select Tool 10 (Probe)
M561 ; Set Identity Transform (Clears any existing bed-plane fitting)

G90 ; Set to Absolute Positioning
G1 X0 Y-45 Z3 F8000 ; Move to X=0, Y=-45, and Z=3 at 8000 mm/min
G30 ; Probe the bed at the current XY position. When the probe is triggered, set the Z coordinate to the probe trigger height.

;Rotary Axis level
M557 X-150:150 Y-180:180 S50:40

G29 ; Probe the bed using the grid defined by M557, save the height map in /sys/heightmap.csv, and activate bed compensation