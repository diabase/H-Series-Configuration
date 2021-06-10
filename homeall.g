; homeall.g
; Called to home all axes

;ensure axis endstops are used
M574 X1 S1 P"!io2.in" ; Configure X endstop position at low end, it's an optical interrupt on pin "io2.in"
M574 Y1 S1 P"!io3.in" ; Configure Y endstop position at low end, it's an optical interrupt on pin "io3.in"
M574 Z2 S1 P"io4.in" ; Configure Z endstop position at high end, it's an optical interrupt on pin "io4.in"

T-1 ; Deselect current tool (if any)
G92 V0 W0 A0 C0 ; Set current A and C positions as 0 mm
M98 P"homeb.g"  ; Home B axis
M98 P"homez.g" ; Call homez.g

M400 ; Wait for all moves to finish

; Home X Y W
M400 ; Wait for all moves to finish
M913 X50 Y50 ; Reduce X-, Y- motor currents to 50%
G91
G1 H1 X-420 Y-180 F6000 ; Attempt to move X -420mm, Y -180mm, and U -380mm at 6000 mm/min, but halt when endstop triggered and set axis position to axis limit as defined by previous M208 or G1 H3 special move
G1 H2 X2 Y2 W-40 F6000 ; Move X +2mm, Y +2mm, and U +2mm at 6000 mm/min, ignoring endstops and axis limits while moving
G1 H1 X-4 Y-4 F1000 ; Attempt to move X -4mm, Y -4mm, and U -4mm at 1000 mm/min, but halt when endstop triggered and set axis position to axis limit as defined by previous M208 or G1 H3 special move
M400 ; Wait for all moves to finish
M913 X100 Y100 Z100 ; Restore X-, Y-, and Z-axis motor currents to 100%
G92 W0


; Home U
G90
G1 X0 Y0 F10000 ; Move to X=0, Y=0 at 10000 mm/min
G1 Z{move.axes[2].max - global.TClength-50} F10000 ; Move to Z = ZMax + Longest Z Offset at 10000 mm/min
M98 P"homeu.g"
M574 Z1 S2 ; Set Z endstop position to low end and configure as Z probe

G60 S1 ; Save current position in slot 1 (the slot used when pausing)

; Put all the tools into standby mode and leave the Z probe tool active
T1 P0
T2 P0
T3 P0
T4 P0
T5 P0
T0 P0
