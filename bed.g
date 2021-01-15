; probe the bed at 36? points
T10
M561

G1 X0 Y-45 Z3 F8000
G30

;Use with Flat Print Bed
M557 X-180:180 Y-80:80 S40

;Use with Dovetail Bed
;M557 X-180:180 Y-45:45 S90

;Rotary Axis level
;M557 X-100:100 Y-180:180 S50:40

G29

;Restore motor currents to X and Y axes
M913 X100 Y100
