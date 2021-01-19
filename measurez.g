M291 P"Turret will now move. Is Probe above the surface to measure?" R"Crash Check" S3

T10 ; Select Tool 10 (probe)

; Go to first bed probe point and coarse probe Z
M558 F1200 ; Set Z probe feed rate to 1200 mm/min.
G30 X0 Y0 ; Probe the bed at X=0, Y=0 and set the Z coordinate to the probe trigger height.

; Fine probe Z
M558 F150 ; Set Z probe feed rate to 150 mm/min
G30 ; Probe the bed at the current XY position and set the Z coordinate to the probe trigger height.

M574 Z2 S1 P"zstop" ; Configure Z endstop position at high end, it's a microswitch on pin "zstop"
M208 Z220 S0 ; Set Z-axis maximum to 220 mm
G91 ; Relative Positioning
G1 Z230 F6000 H3 ; Attempt to move Z +230mm at 6000 mm/min, but halt when endstop triggered and set axis limit current position, overriding value set by M208 in config.g

M500 ; Save current parameters to config-override.g

G1 Z-20 ; Move Z -20mm

M574 Z1 S2 ; Set Z endstop position to low end and configure as Z probe
G90 ; Absolute Positioning
