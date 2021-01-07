M453 ; Switch to CNC mode

G90 ; Set to Absolute Positioning
G1 R2 X0 Y0 F6000 ; Return to X and Y coordinates stored in restore point 2 at a speed of 6000 mm/min
G1 R2 Z0 ; Return to Z coordinate stored in restore point 2

; M451 ; Switch to FFF Mode (Extruder only)
M140 S0 ; Ensure bed heater is off to protect power supply. (Spindle only)
