; homex.g
; Called to home only the X axis
; Written by Diabase Engineering
; Last Updated: July 14, 2021

; Ensure appropriate axis endstops are used
M574 X1 S1 P{global.XSwitchPin} ; Configure X endstop position at low end, it's an optical interrupt on pin defined in machinespecific.g
M574 Z2 S1 P{global.ZSwitchPin} ; Configure Z endstop position at high end, it's an optical interrupt on pin defined in machinespecific.g

G91 ; Relative Positioning

G60 S0 ; Save current position to Slot 0
M400 ; Wait for all moves to finish
M913 X50 Z50 ; Reduce X-, and Z-axis motor currents to 50%

G1 H1 Z2 F200 ; Attempt to move Z +2mm at 200 mm/min, but halt if endstop triggered and set axis position to axis limit as defined by previous M208 or G1 H3 special move
G1 H1 X-420 F6000 ; Attempt to move X -420mm at 6000 mm/min, but halt if endstop triggered and set axis position to axis limit as defined by previous M208 or G1 H3 special move
G1 H2 X2 F6000 ; Move X 2mm at 6000 mm/min, ignoring endstop while moving
G1 H1 X-20 F200 ; Attempt to move X -20mm at 200 mm/min, but halt if endstop triggered and set axis position to axis limit as defined by previous M208 or G1 H3 special move
M400 ; Wait for all moves to finish
M913 X100 Z100 ; Restore X-, and Z-axis motor currents to 100%

G90 ; Absolute Positioning
G1 X0 F10000 ; Move to X=0 at 10000 mm/min

if {state.currentTool} != -1 ; If we have a tool selected...
    if #tools[{state.currentTool}].name == 5 ; If the probe is the current tool...
        M574 Z1 S2 ; Set Z endstop position to low end and configure as Z probe

G1 R0 Z0 ; Return to Z-axis position stored in Slot 0
