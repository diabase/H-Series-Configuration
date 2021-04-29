; probe the bed at 9 points
T10
M561

;Reduce motor currents to X and Y axes
;M913 X75 Y75

;Use with Flat Print Bed
;this is the height to which the printer moves without probing
;always put this at least 3mm higher as the object you want to print on
;G1 X0 Y0 Z3 F8000 ;original
;G1 X0 Y0 Z6 F8000 ; compensated for glass plate
G1 X0 Y0 Z10 F8000 ; compensated for glass plate and springs
G30
;this command defines the probe grid

;M557 X-180:150 Y-80:80 S165:80 ; martijn 13-07-2019 changed to to shrinked bed size due to the addition of the paste extruder
;M557 X-180:160 Y-80:80 S170:80;3x3 ; Gerjan 05-06-2019 changed due to hole in kapton was: X-180:180 Y-80:80 S180:80
;M557 X-30:30 Y-30:30 S30:30;waver
;M557 X-20:20 Y-20:20 S20:20;cookie
;M557 X-100:100 Y-40:40 S50:40;A4
;M557 X-100:100 Y-40:40 S25:20;A4 high precision
M557 X-30:30 Y-10:10 S10:5;piece of delrin
;M557 X-50:50 Y-50:50 S50:50;pancake
;M557 X-180:180 Y-80:80 S90:40;5x5 points


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