; homeall.g
; Called to home all axes

M453 ; Switch to CNC Mode

; Ensure appropriate axis endstops are used
M574 X1 S1 P"xstop" ; Configure X endstop position at low end, it's a microswitch on pin "xstop"
M574 Y1 S1 P"ystop" ; Configure Y endstop position at low end, it's a microswitch on pin "ystop"
M574 Z2 S1 P"!zstop" ; Configure Z endstop position at high end, it's a microswitch on pin "zstop"

M84 E0:1:2:3 ; Idle all extruder motors
T-1 ; Deselect current tool (if any)
G92 A0 C0 ; Set current A and C positions as 0 mm

if {(move.axes[5].letter ^ "") == "W"} ; Motor-driven cleaning station
M98 p"homew.g" ; Call homew.g

G91 ; Relative Positioning
M400 ; Wait for all moves to finish
M913 Z50; Reduce Z-axis motor current to 50%
G1 H1 Z40 F6000 ; Move Z +40mm at 6000 mm/min
M400 ; Wait for all moves to finish
M913 Z100 ; Restore Z-axis motor current to 100%

M98 P"unlock_turret.g" ; Call unlock_turret.g
M915 U R0 ; Configure stall detection for U axis to take no action when a stall is detected
G4 P100 ; Dwell for 100 ms

; Home X Y Z U
M400 ; Wait for all moves to finish
M913 X50 Y50 Z50 ; Reduce X-, Y-, and Z-axis motor currents to 50%
G1 H1 X-420 Y-180 Z220 U-380 F6000 ; Attempt to move X -420mm, Y -180mm, Z +220mm, and U -380mm at 6000 mm/min, but halt when endstop triggered and set axis position to axis limit as defined by previous M208 or G1 H3 special move
G1 H2 X2 Y2 Z-2 U2 F6000 ; Move X +2mm, Y +2mm, Z -2mm, and U +2mm at 6000 mm/min, ignoring endstops and axis limits while moving
G1 H1 X-4 Y-4 Z4 U-4 F1000 ; Attempt to move X -4mm, Y -4mm, Z +4mm, and U -4mm at 1000 mm/min, but halt when endstop triggered and set axis position to axis limit as defined by previous M208 or G1 H3 special move
G1 H2 X2 Y2 Z-2 U2 F6000 ; Move X +2mm, Y +2mm, Z -2mm, and U +2mm at 6000 mm/min, ignoring endstops and axis limits while moving
M400 ; Wait for all moves to finish
M913 X100 Y100 Z100 ; Restore X-, Y-, and Z-axis motor currents to 100%

; Rotate turret to the Z probe location and lock it
G90 ; Absolute Positioning
G1 U0 F16000 ; Rotate Turret to 0 mm at 16000 mm/min
M98 P"lock_turret.g" ; Call lock_turret.g
G92 U0 ; Set current U position as 0 mm

M574 Z1 S2 ; Set Z endstop position to low end and configure as Z probe

G1 X0 Y0 F10000 ; Move to X=0, Y=0 at 10000 mm/min
G1 Z{move.axes[2].max + min(tools[1].offsets[2], tools[2].offsets[2], tools[3].offsets[2], tools[4].offsets[2], tools[5].offsets[2], tools[10].offsets[2])} F10000 ; Move to Z = ZMax + Longest Z Offset at 10000 mm/min

G60 S1 ; Save current position in slot 1 (the slot used when pausing)

; Put all the tools into standby mode and leave the Z probe tool active
T1 P0
T2 P0
T3 P0
T4 P0
T5 P0
T10 P0
