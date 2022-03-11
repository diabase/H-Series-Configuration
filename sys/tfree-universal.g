; Universal tfree macro
; Called whenever a tool is de-selected
; Written by Diabase Engineering
; state.previousTool is now the tool being freed
; state.currentTool is still the tool being freed
; state.nextTool is the upcoming tool
; Last Updated: March 09, 2022

M118 S{"Begin tfree-universal.g"} L3

if global.tFreeComplete = 0
    M118 S{"tfree-universal.g: tfree didn't finish last time. Resetting status flag and trying again."} L1
set global.tFreeComplete = 0

if global.tPreComplete = 0
    M118 S{"tfree-universal.g: tpre didn't finish last time."} L1

if global.tPostComplete = 0
    M118 S{"tfree-universal.g: tpost didn't finish last time."} L1

M453                            ; Switch to CNC mode
M402 P0                         ; Retract Probe
M574 Z2 S1 P{global.zSwitchPin} ; Configure Z endstop position at high end, it's a microswitch on pin defined in defaultparameters.g
M5                              ; Turn off all spindles

if {global.machineModel} == "H5B"
    if {{state.currentTool} >= 11}
        ; Find Z-Axis Index
        var zAxisIndex = -1
        while iterations < #move.axes
            if move.axes[iterations].letter == "Z"
                set var.zAxisIndex = iterations
                break
        M400                                                                                                            ; Wait for all moves to finish
        G90                                                                                                             ; Absolute Positioning
        if global.dontRotate != 1                                                                                       ; If we're performing normal tool changes...
            G53 G1 Z{move.axes[var.zAxisIndex].max} F10000                                                                                ; ... move Z to ZMax quickly
        else                                                                                                            ; If we're performing tool changes without turret rotations...
            G53 G1 Z{move.axes[var.zAxisIndex].max-100} F10000                                                                           ; ... We might have a tool pointing at the tool changer, so move to 100mm below ZMax for clearance
        G1 B0 F30000                                                                                                    ; Move tool changer to position for current tool
        M400
        var spindleNum = tools[state.previousTool].spindle
        M98 P"indexspindle.g" H1 S{var.spindleNum}                                                                      ; Call indexspindle.g
        M42 P{global.tCToolReleaseOutNum} S1                                                                            ; Extend the tool changer release piston
        if global.dontRotate != 1                                                                                       ; If we're performing normal tool changes...
            M98 P"unlock_turret.g"                                                                                          ; Call unlock_turret.g
            G1 U90 F8900                                                                                                    ; Rotate turret to tool changer
            ;G53 G1 Z{move.axes[var.zAxisIndex].max+global.maxOffset} F6000                                                               ; Move Z to ZMax quickly
            G1 U180 F8900                                                                                                   ; Rotate turret to tool changer
            M400                                                                                                            ; Wait for all moves to finish
            M98 P"lock_turret.g"                                                                                            ; Lock turret
        G53 G1 Z{{move.axes[var.zAxisIndex].max}+{global.tCOvertravelPutTool}} H2 F3000                                              ; Move Z beyond ZMax ignoring endstops
        M400                                                                                                            ; Wait for all moves to finish
        G1 P100                                                                                                         ; Dwell for 100 ms
        if sensors.gpIn[global.zHighInNum].value == 0
            M98 P"engagezbrake.g"
            M291 P{"Z High switch is not triggered. Z might have crashed. Z brake engaged. We will now e-stop."}  R"Not high enough." S2
            M98 P"estop.g"                                                                                                  ; Call estop.g
        if state.gpOut[global.dbarOutNum].pwm == 1
            M42 P{global.spindleIndexOutNum} S0                                                                                 ; Toggle Drawbar Release Pressure High
        else
            abort "Error: Drawbar clamping pressure not released. Contact Diabase Support."
        G4 P500                                                                                                         ; Dwell for 500 ms
        M42 P{global.tCToolReleaseOutNum} S0                                                                            ; Retract the tool changer release piston, securing tool in tool changer
        G4 P500                                                                                                         ; Dwell for 500 ms
        G53 G1 Z{move.axes[var.zAxisIndex].max - 1} H2 F10000                                                               ; Move Z to 1mm below the axis limit at 10000 mm/min ignoring endstops
        
        while sensors.endstops[var.zAxisIndex].triggered == true
            M118 S{"tfree-universal.g: Z end stop still triggered. Moving down 1mm."} L3
            G53 G1 H2 Z{move.axes[var.zAxisIndex].machinePosition - 1} F6000
            M400
            if iterations >= {global.tCOvertravelPutTool}
                if sensors.endstops[var.zAxisIndex].triggered == true
                    M98 P"engagezbrake.g"
                    M291 P{"Z end stop still triggered after " ^ iterations ^ "mm additional movement. Tool might not have released. Z brake engaged. We will now e-stop."}  R"Tool not released." S2
                    M98 P"estop.g"                                                                                                  ; Call estop.g
        M400                                                                                                            ; Wait for any current moves to finish
        G53 G1 H1 Z{move.axes[var.zAxisIndex].machinePosition + 5} F1000                                                ; Attempt to move Z +5mm at 1000 mm/min, but halt when endstop triggered and set axis position to axis limit as defined by previous M208 or G1 H3 special move
        if {{state.nextTool} < 11}
            if state.gpOut[global.spindleIndexOutNum].pwm == 0
                M42 P{global.dbarOutNum} S0                                                                                     ; Toggle Drawbar Clamping Pressure to High Pressure
            else
                abort "Error: Drawbar release pressure held low. Contact Diabase Support."

set global.tFreeComplete = 1

M118 S{"End tfree-universal.g"} L3
