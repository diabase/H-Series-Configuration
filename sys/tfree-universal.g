; Universal tfree macro
; Called whenever a tool is de-selected
; Written by Diabase Engineering
; state.previousTool is now the tool being freed
; state.currentTool is still the tool being freed
; state.nextTool is the upcoming tool
; Last Updated: January 07, 2022

M118 S{"Debug: Begin tfree-universal.g"} L3
M453                            ; Switch to CNC mode
M402 P0                         ; Retract Probe
M574 Z2 S1 P{global.zSwitchPin} ; Configure Z endstop position at high end, it's a microswitch on pin defined in defaultparameters.g
M5                              ; Turn off all spindles

if {global.machineModel} == "H5B"
    if {{state.currentTool} >= 11}
        M400                                                        ; Wait for all moves to finish
        if move.axes[2].machinePosition + 70 <= move.axes[2].max    ; If we have enough room for a normal tool change Z-hop (plus 30mm of clearance for the tool changer), do it.
            G91                                                     ; Relative Positioning
            G1 Z40 F6000                                            ; Move Z +40mm at 6000 mm/min
        elif move.axes[2].machinePosition + 40 > move.axes[2].max   ; If we don't have enough room, move as high as we can.
            M574 Z2 S1 P{global.zSwitchPin}                         ; Configure Z endstop position at high end, it's a microswitch on pin defined in defaultparameters.g
            G90                                                     ; Absolute positioning
            G53 G1 Z{move.axes[2].max - 70} F6000                       ; Move to 70mm below ZMax
            M400                                                    ; Wait for all moves to finish

        G90                                                                                                             ; Absolute Positioning
        G1 B0 F30000                                                                                                    ; Move tool changer to position for current tool
        var spindleNum = tools[state.previousTool].spindle
        M98 P"indexspindle.g" H1 S{var.spindleNum}                                                                      ; Call indexspindle.g
        M42 P{global.tCToolReleaseOutNum} S1                                                                            ; Extend the tool changer release piston
        M98 P"unlock_turret.g"                                                                                          ; Call unlock_turret.g
        G1 U180 F8900                                                                                                   ; Rotate turret to tool changer
        M400
        M98 P"lock_turret.g"                                                                                            ; Lock turret
        if move.axes[2].machinePosition < move.axes[2].max                                                              ; If we're below ZMax
            G53 G1 Z{move.axes[2].max + global.maxOffset} F6000                                                         ; Move Z to ZMax quickly
        G53 G1 Z{{move.axes[2].max}+{global.tCOvertravelPutTool}} H2 F3000                                              ; Move Z beyond ZMax ignoring endstops
        M400                                                                                                            ; Wait for all moves to finish
        if sensors.gpIn[{global.zHighInNum}].value == 0
            M98 P"engagezbrake.g"
            M291 P{"Z High switch is not triggered. Z might have crashed. Z brake engaged. We will now abort."}  R"Not high enough." S2
            abort
        M42 P{global.spindleIndexOutNum} S0                                                                             ; Toggle Drawbar Release Pressure High
        G4 P500                                                                                                         ; Dwell for 500 ms
        M42 P{global.tCToolReleaseOutNum} S0                                                                            ; Retract the tool changer release piston
        G4 P500                                                                                                         ; Dwell for 500 ms
        G53 G1 Z{{move.axes[2].max}-70} H2 F6000                                                                        ; Move Z to 70 mm below ZMax, ignoring endstops
        M400                                                                                                            ; Wait for any current moves to finish
        if {{state.nextTool} < 11}
            M42 P{global.dbarOutNum} S0                                                                                 ; Turn Drawbar Release Pressure Off (Fully clamp drawbar)

M118 S{"Debug: End tfree-universal.g"} L3
