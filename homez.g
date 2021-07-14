; homez.g
; Called to home only the Z axis
; Written by Diabase Engineering
; Last Updated: July 14, 2021

M118 S"Begin homez.g" L2

; Ensure appropriate axis endstops are used
M574 Z2 S1 P{global.ZSwitchPin} ; Configure Z endstop position at high end, pin defined in machinespecific.g

G91 ; Relative Positioning
G1 H1 Z.5 F6000 ; Move Z +0.5mm at 6000 mm/min
M98 P"disengagezbrake.g"       ; Disengage Z brake
G4 P300         ; Wait 300 ms

M400 ; Wait for all moves to finish
G1 H1 Z360 F6000 ; Attempt to move Z +260mm at 6000 mm/min, but halt if endstop triggered and set axis position to axis limit as defined by previous M208 or G1 H3 special move
G1 H2 Z-2 F6000 ; Move Z -2mm at 6000 mm/min, ignoring endstop while moving
G1 H1 Z4 F200 ; Attempt to move Z +20mm at 200 mm/min, but halt if endstop triggered and set axis position to axis limit as defined by previous M208 or G1 H3 special move
M400 ; Wait for all moves to finish

G90 ; Absolute Positioning

G1 Z{move.axes[2].max + global.MaxOffset} F10000 ; Move to Z = ZMax + Longest Z Offset at 10000 mm/min

if {state.currentTool} != -1 ; If we have a tool selected...
    if #tools[{state.currentTool}].name == 5 ; If the probe is the current tool...
        M574 Z1 S2 ; Set Z endstop position to low end and configure as Z probe, pin defined in machinespecific.g

M118 S"End homez.g" L2
