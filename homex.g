; homex.g
; Called to home only the X axis
; Written by Diabase Engineering
; Last Updated: July 22, 2021

; Ensure appropriate axis endstops are used
M574 X1 S1 P{global.xSwitchPin}                             ; Configure X endstop position at low end, it's an optical interrupt on pin defined in defaultparameters.g
M574 Z2 S1 P{global.zSwitchPin}                             ; Configure Z endstop position at high end, it's an optical interrupt on pin defined in defaultparameters.g

G91                                                         ; Relative Positioning

G60 S0                                                      ; Save current position to Slot 0
M400                                                        ; Wait for all moves to finish

G1 H1 Z2 F200                                               ; Attempt to move Z +2mm at 200 mm/min, but halt if endstop triggered and set axis position to axis limit as defined by previous M208 or G1 H3 special move
G1 H1 X-420 F6000                                           ; Attempt to move X -420mm at 6000 mm/min, but halt if endstop triggered and set axis position to axis limit as defined by previous M208 or G1 H3 special move
G1 H2 X2 F6000                                              ; Move X 2mm at 6000 mm/min, ignoring endstop while moving
G1 H1 X-20 F200                                             ; Attempt to move X -20mm at 200 mm/min, but halt if endstop triggered and set axis position to axis limit as defined by previous M208 or G1 H3 special move
M400                                                        ; Wait for all moves to finish

G90                                                         ; Absolute Positioning
G1 X0 F10000                                                ; Move to X=0 at 10000 mm/min

if {state.currentTool} != -1                                ; If we have a tool selected...
    if {tools[{state.currentTool}].spindle == -1}           ; If this tool has no spindles...
        if {#tools[{state.currentTool}].extruders == 0}     ; ... or extruders, we assume it's a probe
            M574 Z1 S2                                      ; Set Z endstop position to low end and configure as Z probe

G1 R0 Z0                                                    ; Return to Z-axis position stored in Slot 0
