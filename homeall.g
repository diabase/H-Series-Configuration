; Called to home all axes

; Ensure axis endstops are used
M574 X1 S1 P"xstop" ; Configure X endstop position at low end, it's a microswitch on pin "xstop"
M574 Y1 S1 P"ystop" ; Configure Y endstop position at low end, it's a microswitch on pin "ystop"
M574 Z2 S1 P"zstop" ; Configure Z endstop position at high end, it's a microswitch on pin "zstop"

M84 E0:1:2:3 ; Idle all extruder motors
T-1 P0; Deselect current tool
M451 ; Switch to FFF Mode
; G92 A C ; Placeholder for setting positions of A and C axes

M98 p"homew.g" ; Call homew.g

G91 ; Relative Positioning
G1 H1 Z60 F6000 ; Attempt to move Z +60mm at 6000 mm/min, but halt when endstop triggered and set axis position to axis limit as defined by M208 in config.g or previous G1 H3 special move

M98 P"unlock_turret.g" ; Call unlock_turret.g
M915 U R0 ; Configure stall detection for U axis to take no action when a stall is detected
G4 P100 ; Dwell for 100 ms

; Home X Y Z U
G1 H1 X-420 Y-180 Z220 U-380 F6000 ; Attempt to move X -420mm, Y -180mm, Z +220mm, and U -380mm at 6000 mm/min, but halt when endstop triggered and set axis position to axis limit as defined by M208 in config.g or previous G1 H3 special move
G1 H2 X2 Y2 Z-2 U2 F6000 ; Move X +2mm, Y -2mm, Z -2mm, and U +2mm at 6000 mm/min, ignoring endstop while moving
G1 H1 X-20 Y-20 Z20 U-29.7 F3000 ; Attempt to move X -20mm, Y -20mm, Z +20mm, and U -29.7mm at 3000 mm/min, but halt when endstop triggered and set axis position to axis limit as defined by M208 in config.g or previous G1 H3 special move

; Rotate turret to the Z probe location and lock it
G90 ; Absolute Positioning
G1 U0 F9900 ; Move U to 0 mm at 9900 mm/min
M98 P"lock_turret.g" ; Call lock_turret.g
G92 U0 ; Set current U position as 0 mm

; Go to X=0 Y=0 Z=190
G1 X0 Y0 Z190 F10000 ; Move to X=0, Y=0, and Z=190 at 10000 mm/min
M453 ; Switch to CNC Mode
G60 S1 ; Save current position in slot 1 (the slot used when pausing)

; Put all the tools into standby mode and leave the Z probe tool active
T1 P0
T2 P0
T3 P0
T4 P0
T5 P0
T10 P0

M451 ; Switch to FFF Mode
