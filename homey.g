; homey.g
; Called to home only the Y axis

; Ensure appropriate axis endstops are used
M574 Y1 S1 P"!io3.in" ; Configure Y endstop position at low end, it's an optical interrupt on pin "io3.in"
M574 Z1 S1 P"!io4.in" ; Configure Z endstop position at high end, it's an optical interrupt on pin "io4.in"

G91 ; Relative Positioning

G60 S0 ; Save current position to Slot 0
M400 ; Wait for all moves to finish
M913 Y50 Z50 ; Reduce Y-, and Z-axis motor currents to 50%

G1 H1 Z2 F200 ; Attempt to move Z +2mm at 200 mm/min, but halt if endstop triggered and set axis position to axis limit as defined by previous M208 or G1 H3 special move
G1 H1 Y-180 F6000 ; Attempt to move Y -180mm at 6000 mm/min, but halt if endstop triggered and set axis position to axis limit as defined by previous M208 or G1 H3 special move
G1 H2 Y2 F6000 ; Move Y 2mm at 6000 mm/min, ignoring endstop while moving
G1 H1 Y-20 F200 ; Attempt to move Y -20mm at 200 mm/min, but halt if endstop triggered and set axis position to axis limit as defined by previous M208 or G1 H3 special move
M400 ; Wait for all moves to finish
M913 Y100 Z100 ; Restore Y-, and Z-axis motor currents to 100%

G90 ; Absolute Positioning
G1 Y0 F10000 ; Move to Y=0 at 10000 mm/min

if {state.currentTool} != -1 ; If we have a tool selected...
    if #tools[{state.currentTool}].name == 5 ; If the probe is the current tool...
        M574 Z1 S2 ; Set Z endstop position to low end and configure as Z probe

G1 R0 Z0 ; Return to Z-axis position stored in Slot 0
