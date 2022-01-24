; Universal tfree macro
; Called whenever a tool is de-selected
; Written by Diabase Engineering
; state.previousTool is now the tool being freed
; state.currentTool is still the tool being freed
; state.nextTool is the upcoming tool
; Last Updated: January 20, 2022

M118 S{"Debug: Begin tfree-universal.g"} L3
M453                            ; Switch to CNC mode
M402 P0                         ; Retract Probe
M574 Z2 S1 P{global.zSwitchPin} ; Configure Z endstop position at high end, it's a microswitch on pin defined in defaultparameters.g
M5                              ; Turn off all spindles

if {global.machineModel} == "H5B"
    if {{state.currentTool} >= 11}
        M400                                                                                                            ; Wait for all moves to finish
        G90                                                                                                             ; Absolute Positioning
        if global.dontRotate != 1                                                                                       ; If we're performing normal tool changes...
            G53 G1 Z{move.axes[2].max} F10000                                                                                ; ... move Z to ZMax quickly
        else                                                                                                            ; If we're performing tool changes without turret rotations...
            G53 G1 Z{move.axes[2].max-100} F10000                                                                           ; ... We might have a tool pointing at the tool changer, so move to 100mm below ZMax for clearance
        G1 B0 F30000                                                                                                    ; Move tool changer to position for current tool
        M400
        var spindleNum = tools[state.previousTool].spindle
        M98 P"indexspindle.g" H1 S{var.spindleNum}                                                                      ; Call indexspindle.g
        M42 P{global.tCToolReleaseOutNum} S1                                                                            ; Extend the tool changer release piston
        if global.dontRotate != 1                                                                                       ; If we're performing normal tool changes...
            M98 P"unlock_turret.g"                                                                                          ; Call unlock_turret.g
            G1 U90 F8900                                                                                                    ; Rotate turret to tool changer
            ;G53 G1 Z{move.axes[2].max+global.maxOffset} F6000                                                               ; Move Z to ZMax quickly
            G1 U180 F8900                                                                                                   ; Rotate turret to tool changer
            M400                                                                                                            ; Wait for all moves to finish
            M98 P"lock_turret.g"                                                                                            ; Lock turret
        G53 G1 Z{{move.axes[2].max}+{global.tCOvertravelPutTool}} H2 F3000                                              ; Move Z beyond ZMax ignoring endstops
        M400                                                                                                            ; Wait for all moves to finish
        if sensors.gpIn[{global.zHighInNum}].value == 0
            M98 P"engagezbrake.g"
            M291 P{"Z High switch is not triggered. Z might have crashed. Z brake engaged. We will now abort."}  R"Not high enough." S2
            abort
        M42 P{global.spindleIndexOutNum} S0                                                                             ; Toggle Drawbar Release Pressure High
        G4 P500                                                                                                         ; Dwell for 500 ms
        M42 P{global.tCToolReleaseOutNum} S0                                                                            ; Retract the tool changer release piston, securing tool in tool changer
        G4 P500                                                                                                         ; Dwell for 500 ms
        G53 G1 Z{move.axes[2].max} H2 F10000                                                                            ; Move Z to the axis limit at 10000 mm/min ignoring endstops
        M400                                                                                                            ; Wait for any current moves to finish
        if {{state.nextTool} < 11}
            M42 P{global.dbarOutNum} S0                                                                                 ; Turn Drawbar Release Pressure Off (Fully clamp drawbar)

M118 S{"Debug: End tfree-universal.g"} L3
