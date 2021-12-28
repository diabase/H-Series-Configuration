; Universal tpre macro
; Called when a tool is selected
; Written by Diabase Engineering
; Last Updated: December 27, 2021

M118 S{"Debug: Begin tpre-universal.g"} L3

M118 S{"Debug: Changing from tool " ^ {state.previousTool} ^ " to tool " ^ {state.nextTool}} L3

M453 ; Switch to CNC mode
if {global.machineModel} == "H4"
    M84 E0:1:2:3 ; Idle all extruder motors

while iterations < #move.axes
    if move.axes[iterations].homed == false
        M291 P{ move.axes[iterations].letter^" axis is unhomed. Home all axes now?"} R"Home all?" S3
        M98 P"homeall.g"

if {global.machineModel} == "H4" || {global.machineModel} == "H5A"
    ; Only perform machine moves if we need to change the turret position
    if move.axes[3].machinePosition != -tools[{state.nextTool}].offsets[3]
        G91 ; Relative Positioning

        if move.axes[2].machinePosition < {move.axes[2].max - 40}  ; If we have enough room for a normal tool change Z-hop, do it.
            G1 Z40 F6000 ; Move Z +40mm at 6000 mm/min

        elif move.axes[2].machinePosition > {move.axes[2].max -40} ; If we don't have enough room, move as high as we can.
            M574 Z2 S1 P{global.zSwitchPin} ; Configure Z endstop position at high end, it's a microswitch on pin defined in defaultparameters.g
            M400 ; Wait for all moves to finish
            G1 Z40 F6000 H3 ; Attempt to move Z +40mm at 6000 mm/min, but halt if endstop triggered and set axis limit current position, overriding value set by previous M208 or G1 H3 special move
            M400 ; Wait for all moves to finish

        elif move.axes[2].machinePosition == {move.axes[2].max -40} ; If we're already at the safe z position for a tool change...
            M118 S{"Debug: Already at safe z position for tool change."} L3     ; ... do nothing
        M400
        M98 P"unlock_turret.g" ; Call unlock_turret.g
        G90 ; Absolute Positioning

        G1 U{-tools[{state.nextTool}].offsets[3]} F8900 ; Rotate turret to new tool
        G4 P20 ; Dwell for 20 ms
        M400
        M98 P"lock_turret.g" ; Call lock_turret.g

if {global.machineModel} == "H5B"
    ; Only perform machine moves if we need to change the turret position
    if {move.axes[3].machinePosition != -tools[{state.nextTool}].offsets[3] || {state.nextTool} >= 11}
        M400                                                                    ; Wait for all moves to finish
        if move.axes[2].machinePosition < {move.axes[2].max - 70}               ; If we have enough room for a normal tool change Z-hop (plus 30mm of clearance for the tool changer), do it.
            G91                                                                 ; Relative Positioning
            G53 G1 Z40 F6000                                                        ; Move Z +40mm at 6000 mm/min

        elif move.axes[2].machinePosition > {move.axes[2].max - 70}             ; If we don't have enough room, move as high as we can.
            M574 Z2 S1 P{global.zSwitchPin}                                     ; Configure Z endstop position at high end, it's a microswitch on pin defined in defaultparameters.g
            G90                                                                 ; Absolute positioning
            G53 G1 Z{move.axes[2].max - 70} F6000                                   ; Move to 70mm below ZMax
            M400                                                                ; Wait for all moves to finish

        elif move.axes[2].machinePosition == {move.axes[2].max - 70}            ; If we're already at the safe z position for a tool change...
            M118 S{"Debug: Already at safe z position for tool change."} L3     ; ... do nothing

        if {{state.nextTool} >= 11}
            G90                                                                                                             ; Absolute Positioning
            G1 B{-tools[{state.nextTool}].offsets[6]} F10000                                                                ; Move tool changer to position for upcoming tool
            if state.gpOut[{global.dbarOutNum}].pwm == 0                                                                    ; If drawbar release pressure is off
                var spindleNum = tools[state.nextTool].spindle
                M98 P"indexspindle.g" H0 S{var.spindleNum}                                                                      ; Call indexspindle.g

            if {abs({move.axes[3].machinePosition}-{{-tools[{state.nextTool}].offsets[3]}+180}) > 1.0}                       ; If the turret isn't already pointing the spindle within 1 degree of the tool changer...
                M118 S{"Debug: Current turret position is " ^ move.axes[3].machinePosition ^ " and we need it to be " ^ {{-tools[{state.nextTool}].offsets[3]}+180}} L3
                M400
                M98 P"unlock_turret.g"                                                                                      ; Call unlock_turret.g
                G1 U{{-tools[{state.nextTool}].offsets[3]}+180} F8900                                                       ; Rotate turret to point the spindle at the tool changer
                M400
                M98 P"lock_turret.g"                                                                                        ; Lock turret
            M42 P{global.spindleIndexOutNum} S0                                                                             ; Toggle Drawbar Release Pressure High
            G53 G1 Z{move.axes[2].max} F6000                                                                                ; Move Z to ZMax quickly
            G53 G1 Z{{move.axes[2].max}+{global.tCOvertravelGetTool}} H2 F3000                                              ; Move Z beyond ZMax ignoring endstops
            M400                                                                                                            ; Wait for all moves to finish
            if sensors.gpIn[{global.zHighInNum}].value == 0
                M291 P{"Z High switch is not triggered. Z might have crashed. We will now abort."}  R"Not high enough." S2
                abort
            M42 P{global.tCToolReleaseOutNum} S1                                                                            ; Extend the tool changer release piston
            G4 P500                                                                                                         ; Dwell for 500 ms
            M42 P{global.dbarOutNum} S0                                                                                     ; Turn Drawbar Release Pressure Off (Fully clamp drawbar)
            
            ; Reduce z-axis maximum current for tool retrieval move in case tool changer fails to release
            M118 S{"Normal Max Z Motor Current is "^move.axes[2].current^ "mA. Reducing by 50%."} L3
            var zMotorCurrent = move.axes[2].current
            M906 Z{var.zMotorCurrent * 0.5}
            M118 S{"Max z-motor current is now "^move.axes[2].current^ "mA. Attempting downward move."} L3
            G53 G1 Z{{move.axes[2].max}-100} H2 F6000                                                                           ; Move Z to 100 mm below ZMax, ignoring endstops
            M906 Z{var.zMotorCurrent}
            M118 S{"Attempted move finished. Max z-motor current is now "^move.axes[2].current^ "mA."} L3
            M400                                                                                                            ; Wait for any current moves to finish
            M42 P{global.tCToolReleaseOutNum} S0                                                                            ; Retract the tool changer release piston
            
        G90 ; Absolute Positioning
        M400
        M98 P"unlock_turret.g" ; Call unlock_turret.g
        G53 G1 U{-tools[{state.nextTool}].offsets[3]} Z{move.axes[2].max + global.maxOffset} F8900 ; Rotate turret to active position for new tool
        G4 P20 ; Dwell for 20 ms
        
        M400
        M98 P"lock_turret.g" ; Call lock_turret.g

M118 S{"Debug: End tpre-universal.g"} L3
