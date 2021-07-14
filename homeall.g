; homeall.g
; Called to home all axes
; Written by Diabase Engineering
; Last Updated: July 6, 2021

M118 S"Info: Begin homeall.g" L2

G54 ; Assert WCS

; Ensure axis endstops are used
M574 X1 S1 P{global.XSwitchPin} ; Configure X endstop position at low end, it's an optical interrupt on pin defined in machinespecific.g
M574 Y1 S1 P{global.YSwitchPin} ; Configure Y endstop position at low end, it's an optical interrupt on pin defined in machinespecific.g
M574 Z2 S1 P{global.ZSwitchPin} ; Configure Z endstop position at high end, it's an optical interrupt on pin defined in machinespecific.g

if {global.MachineModel} == "H4"
    M84 E0:1:2:3 ; Idle all extruder motors

T-1 ; Deselect current tool (if any)
G92 A0 C0 ; Set current A and C positions as 0 mm

if {global.CSType} == "Motor"
    M98 p"homew.g" ; Call homew.g

G91 ; Relative Positioning
G1 H1 Z0.5 F6000 ; Move Z +0.5mm at 6000 mm/min
M98 P"disengagezbrake.g"       ; Disengage Z brake
G4 P300         ; Wait 300 ms

M400 ; Wait for all moves to finish
G1 H1 Z40 F6000 ; Move Z +40mm at 6000 mm/min
M400 ; Wait for all moves to finish

M98 P"unlock_turret.g" ; Call unlock_turret.g
M915 U R0 ; Configure stall detection for U axis to take no action when a stall is detected
G4 P100 ; Dwell for 100 ms

; Home X Y Z U
M400 ; Wait for all moves to finish
G1 H1 X-420 Y-180 Z320 U-380 F6000 ; Attempt to move X -420mm, Y -180mm, Z +220mm, and U -380mm at 6000 mm/min, but halt when endstop triggered and set axis position to axis limit as defined by previous M208 or G1 H3 special move
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
G1 Z{move.axes[2].max + global.MaxOffset} F10000 ; Move to Z = ZMax + Longest Z Offset at 10000 mm/min

G60 S1 ; Save current position in slot 1 (the slot used when pausing)

; Put all the tools into standby mode and leave the Z probe tool active
T1 P0
T2 P0
T3 P0
T4 P0
T5 P0
T10 P0

M118 S"Info: End homeall.g" L2
