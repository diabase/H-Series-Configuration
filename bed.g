; probe the bed at 9 points
T10
M561

;Reduce motor currents to X and Y axes
;M913 X75 Y75

;Use with Flat Print Bed
G1 X0 Y0 Z3 F8000
G30
M557 X-180:180 Y-80:80 S180:80

;Use with Dovetail Bed
;G1 X0 Y45 Z3 F8000
;G30
;M557 X-180:180 Y-45:45 S90

;Use with Rotary shaft
;G1 x0 y0 Z3
;G30
;M557 X-130:80 Y-30:30 S40:5

G29 

;Restore motor currents to X and Y axes
M913 X100 Y100