; Universal tfree macro
; Called whenever a tool is de-selected
; Written by Diabase Engineering
; Last Updated: December 13, 2021

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
        G1 B0 F10000                                                                                                    ; Move tool changer to position for current tool
        M42 P{global.spindleIndexOutNum} S1                                                                             ; Toggle Drawbar Release Pressure Low
        M42 P{global.dbarOutNum} S1                                                                                     ; Turn Drawbar Release Pressure On
        ; if sensors.gpIn[{global.spindleIndexSenseInNum}].value == 1                                                     ; Drawbar position sensor active means the index pin hasn't dropped into its slot
        ;     M291 P"Rotate spindle until index pin is in the correct location. Press OK when aligned." R"Warning" S3     ; Display a blocking warning with no timeout.
        var blipSpindleSpeed = 1000
        var blipDuration = 200
        while sensors.gpIn[{global.spindleIndexSenseInNum}].value == 1
            if iterations > 0
                if {{mod(iterations,5)} == 0}
                    M42 P{global.dbarOutNum} S0                                                                                     ; Turn Drawbar Release Pressure Off
                    G4 P500                                                                                                         ; Dwell 100ms
                    M118 S{"Debug: Additional blip with drawbar fully clamped on attempt "^iterations ^ " at " ^ var.blipSpindleSpeed ^"RPM"} L3
                    M3 S{var.blipSpindleSpeed}
                    G4 P{var.blipDuration}
                    M5
                    G4 P200
                    M42 P{global.dbarOutNum} S1
                    G4 P500                                                                                                         ; Dwell 100ms
            if iterations = 10
                set var.blipSpindleSpeed = 2000
                set var.blipDuration = 400
            if iterations < 20
                M118 S{"Debug: Spindle blip attempt "^iterations ^ " at " ^ var.blipSpindleSpeed ^"RPM"} L3
                M3 S{var.blipSpindleSpeed}
                G4 P{var.blipDuration}
                M5
                G4 P200
            else
                M291 P{"Warning: Spindle blipped " ^ iterations ^ " times without success."} R"Warning" S3            ; Display a blocking warning with no timeout.
                ; abort
            
        M42 P{global.tCToolReleaseOutNum} S1                                                                            ; Extend the tool changer release piston
        M400
        M98 P"unlock_turret.g"                                                                                          ; Call unlock_turret.g
        G1 U180 F8900                                                                                                   ; Rotate turret to tool changer
        M400
        M98 P"lock_turret.g"                                                                                            ; Lock turret
        M42 P{global.spindleIndexOutNum} S0                                                                             ; Toggle Drawbar Release Pressure High
        if move.axes[2].machinePosition < move.axes[2].max                                                              ; If we're below ZMax
            G1 Z{move.axes[2].max + global.maxOffset} F6000                                                                                ; Move Z to ZMax quickly
        G1 Z{{move.axes[2].max}+{global.tCOvertravelPutTool}} H2 F1000                                                  ; Move Z beyond ZMax slowly, ignoring endstops
        M400                                                                                                            ; Wait for all moves to finish
        M42 P{global.tCToolReleaseOutNum} S0                                                                            ; Retract the tool changer release piston
        G4 P500                                                                                                         ; Dwell for 500 ms
        G1 Z{{move.axes[2].max}-70} H2 F6000                                                                            ; Move Z to 70 mm below ZMax, ignoring endstops
        M400                                                                                                            ; Wait for any current moves to finish
        if {{state.nextTool} < 11}
            M42 P{global.dbarOutNum} S0                                                                                 ; Turn Drawbar Release Pressure Off (Fully clamp drawbar)

M118 S{"Debug: End tfree-universal.g"} L3
