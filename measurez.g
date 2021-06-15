; measurez.g
; Called to probe the bed and set Z0 to the bed surface and then set Z-axis maximum to the carefully measured location of the upper Z-axis endstop relative to the bed surface.

M291 P"Turret will now move. Is Probe above the surface to measure?" R"Crash Check" S3 ; Warn the user about the imminent probing move.

T10 ; Select Tool 10 (probe)
M18 Z ; Idle z axis to unhome the Z axis
M208 Z-10:400 ; Set z axis minimum and maximum travel

; Go to first bed probe point and coarse probe Z
M558 F1200 ; Set Z probe feed rate to 1200 mm/min.
G30 ; Probe the bed at the current XY position and set the Z coordinate to the probe trigger height.

; Fine probe Z
M558 F150 ; Set Z probe feed rate to 150 mm/min
G30 ; Probe the bed at the current XY position and set the Z coordinate to the probe trigger height.

M574 Z2 S1 P"io4.in" ; Configure Z endstop position at high end, it's a microswitch on pin "zstop"
M208 Z380 S0 ; Set Z-axis maximum to 380 mm
G91 ; Relative Positioning
G1 Z340 F6000 H3 ; Attempt to move Z +370mm at 6000 mm/min, but halt when endstop triggered and set axis limit current position, overriding value set by M208 in config.g
G1 Z40 F200 H3
G1 H2 Z-2 F6000 ; Move Z -2mm at 6000 mm/min, ignoring endstop while moving
G1 H3 Z4 F200 ; Attempt to move Z +4mm at 200 mm/min, but halt if endstop triggered and set axis limit to current position, overriding value set by previous M208 or G1 H3 special move
M400 ; Wait for all moves to finish
M913 Z100 ; Restore Z-axis motor current to 100%

M500 ; Save current parameters to config-override.g

G90 ; Absolute Positioning
if move.axes[2].machinePosition > move.axes[2].max ; If we're now above the new Z-axis limit...
    G1 H2 Z{move.axes[2].max} F200 ; ...move to it at 200 mm/min while ignoring endstops and limits.

G1 Z{move.axes[2].max + min(tools[1].offsets[2], tools[2].offsets[2], tools[3].offsets[2], tools[4].offsets[2], tools[5].offsets[2], tools[10].offsets[2])} F10000 ; Move to Z = ZMax + Longest Z Offset at 10000 mm/min

M574 Z1 S2 ; Set Z endstop position to low end and configure as Z probe
