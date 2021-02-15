; probe the bed at 9 points
T10
M561

G1 X0 Y0 Z3 F8000
;Use with Flat Print Bed
G30
M557 X-180:180 Y-80:80 S180:80

G29

