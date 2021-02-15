; probe the bed at 9 points
T10
M561

;Reduce motor currents to X and Y axes
;M913 X75 Y75

G1 X0 Y0 Z3 F8000
;Use with Flat Print Bed
G30
;M557 X-180:180 Y-80:80 S90:80
M557 X-50:50 Y-50:50 S50
;M557 X-60:60 Y-60:60 S60:60

;Use with Dovetail Bed
;G1 X0 Y-45 Z3 F8000
;G30
;M557 X-50:50 Y-50:50 S50:50

;Use with Rotary Bed

;M557 X-20:20 Y-20:20 S10:10
;M557 X-116:126 Y-180:180 S40:60

G29

;Restore motor currents to X and Y axes
M913 X100 Y100
