; homez.g
; Called to home only the Z axis

; Ensure appropriate axis endstops are used
M574 Z2 H1 P"!io4.in" ; Configure Z endstop position at high end, it's a microswitch on pin "zstop"

G91 ; Relative Positioning
M400 ; Wait for all moves to finish
M913 Z50; Reduce Z-axis motor current to 50%
G1 H1 Z360 F6000 ; Attempt to move Z +260mm at 6000 mm/min, but halt if endstop triggered and set axis position to axis limit as defined by previous M208 or G1 H3 special move
G1 H2 Z-2 F6000 ; Move Z -2mm at 6000 mm/min, ignoring endstop while moving
G1 H1 Z4 F200 ; Attempt to move Z +20mm at 200 mm/min, but halt if endstop triggered and set axis position to axis limit as defined by previous M208 or G1 H3 special move
M400 ; Wait for all moves to finish
M913 Z100 ; Restore Z-axis motor current to 100%

G90 ; Absolute Positioning

G1 Z{move.axes[2].max + min(tools[1].offsets[2], tools[2].offsets[2], tools[3].offsets[2], tools[4].offsets[2], tools[5].offsets[2], tools[10].offsets[2])} F10000 ; Move to Z = ZMax + Longest Z Offset at 10000 mm/min

if {state.currentTool} != -1 ; If we have a tool selected...
    if #tools[{state.currentTool}].name == 5 ; If the probe is the current tool...
        M574 Z1 S2 ; Set Z endstop position to low end and configure as Z probe
