; probe the bed at 9 points
T10
M561

;Reduce motor currents to X and Y axes
;M913 X75 Y75

G1 X0 Y0 Z3 F8000
;Use with Flat Print Bed
G30
;M557 X-30:180 Y-50:50 S50:50

;Full Bed
M557 X-180:180 Y-80:80 S180:80

;80x80 Bed
;M557 X-40:40 Y-40:40 s40

;Use with Dovetail Bed
;M557 X-180:180 Y-45:45 S90

G29 

;Restore motor currents to X and Y axes
M913 X100 Y100