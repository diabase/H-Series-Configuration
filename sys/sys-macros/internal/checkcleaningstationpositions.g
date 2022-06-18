; checkcleaningstationpositions.g
; FOR INTERNAL USE
; This macro steps through the priming and cleaning positions for each nozzle.
; Written by Ron Thomas, Diabase Engineering
; Last Updated: June 17, 2022

echo "Start checkcleaningstationpositions.g"
M291 P"This macro will home all then step through the priming positions for each defined nozzle. Ready?" R"CS Position Check" S3
M98 P"homeall.g"

G60 S0 ; Save current position to slot 0

G91 ; Relative Positioning

if move.axes[2].machinePosition + 40 <= move.axes[2].max ; If we have enough room for a normal tool change Z-hop, do it.
    G1 Z40 F6000 ; Move Z +40mm at 6000 mm/min
elif move.axes[2].machinePosition + 40 > move.axes[2].max ; If we don't have enough room, move as high as we can.
    M574 Z2 S1 P{global.zSwitchPin} ; Configure Z endstop position at high end, it's a microswitch on pin defined in defaultparameters.g
    M400 ; Wait for all moves to finish
    G1 Z40 F6000 H3 ; Attempt to move Z +40mm at 6000 mm/min, but halt if endstop triggered and set axis limit current position, overriding value set by previous M208 or G1 H3 special move
    M400 ; Wait for all moves to finish

G90 ; Set to Absolute Positioning

while iterations < #tools ; Loop over all tools
    if tools[{iterations}] == null
        continue

    if {tools[{iterations}].spindle == -1}                                                                                          ; If this tool has no spindles...
        if {#tools[{iterations}].extruders > 0}                                                                                   ; ... and has extruders, we assume it's an extruder
            echo "Testing "^tools[iterations].name
            
            if state.currentTool != iterations
                T{iterations}
            
            M98 P"unlock_turret.g" ; Call unlock_turret.g
            if tools[{state.currentTool}].offsets[3] + 100.00 <= 0
                G1 U-100.00 F9900; Rotate turret (U) to point extruder at priming surface (260.00mm == (-100.00mm mod 360)) at 9900 mm/min
            elif tools[{state.currentTool}].offsets[3] + 100.00 > 0
                G1 U260.00 F9900; Rotate turret (U) to point extruder at priming surface (260.00mm == (-100.00mm mod 360)) at 9900 mm/min

            if global.cSType == "Motor"
                G1 W{global.wPrimeSurface} F15000 ; Move W to value specified in defaultparameters.g at 15000 mm/min to extend cleaning station to priming location
                M291 P"If this is the nozzle with the longest Z-axis offset, mechanically adjust the cleaning station so that the priming surface is 1.00 mm from the nozzle tip." R"Wprimesurface" S3
                G1 W{global.wClearance} F15000 ; Move W to 5mm less than value specified in defaultparameters.g at 6000 mm/min to retract cleaning station to the clearance location for a turret rotation
                M291 P"Is there sufficient clearance distance between the cleaning station and the nozzle for a turret rotation?" R"Wclearance" S3

            elif global.cSType == "Solenoid"
                M42 P{global.cSSolenoidOutNum} S1 ; Set GPIO pin 0 high to fully extend cleaning station to priming location
                M42 P{global.cSSolenoidOutNum} S0.75 ; Set GPIO pin 0 to 75%
                M291 P"If this is the nozzle with the longest Z-axis offset, mechanically adjust the cleaning station so that the priming surface is 1.00 mm from the nozzle tip." R"Wprimesurface" S3
                M400 ; Wait for current moves to finish
                M42 P{global.cSSolenoidOutNum} S0 ; Set GPIO pin 0 to low 
                M291 P"Is there sufficient clearance distance between the cleaning station and the nozzle for a turret rotation?" R"Wclearance" S3

            if tools[{state.currentTool}].offsets[3] - 90.00 <= 0
                G1 U-90.00 F9900; Rotate turret (U) to point extruder at pliers (270.00mm == (-90.00mm mod 360)) at 9900 mm/min
            elif tools[{state.currentTool}].offsets[3] - 90.00 > 0
                G1 U270.00 F9900; Rotate turret (U) to point extruder at pliers (270.00mm == (-90.00mm mod 360)) at 9900 mm/min

            if global.cSType == "Motor"
                G90 ; Set to Absolute Positioning
                M400 ; Wait for current moves to finish
                G1 W{global.wClean} F15000 ; Move W to value specified in cleaningstation.g at 15000 mm/min to extend the cleaning station pliers to surround the nozzle
                G4 P125 ; Dwell for 125 ms
                M400 ; Wait for current moves to finish
                M42 P{global.cSPinchOutNum} S1 ; Close pliers
                G4 P125 ; Dwell for 125 ms
                M42 P{global.cSPinchOutNum} S0.75 ; Reduce pliers-closing solenoid current to 75%
                G4 P125 ; Dwell for 125 ms
                M42 P{global.cSPinchOutNum} S0.5 ; Reduce pliers-closing solenoid current to 50%
                M291 P"Are the pliers closed on the straight portion of the nozzle?" R"Wclean" S3
                G1 W{global.wGrab} F15000 ; Move W to value specified in cleaningstation.g at 15000 mm/min to retract the cleaning station pliers to pull the filament button from the nozzle
                M291 P"Did the pliers retract beyond the tip of the nozzle?" R"Wgrab" S3
                G28 W ; Home W
                G4 P175 ; Dwell for 175 ms
                M42 P{global.cSPinchOutNum} S0 ; Open Pliers
                M400 ; Wait for current moves to finish
                M291 P"Is the cleaning station fully homed?" R"Homed W" S3

            elif global.cSType == "Solenoid"
                M400 ; Wait for current moves to finish
                M42 P{global.cSSolenoidOutNum} S1 ; Extend Pliers
                G4 P125 ; Dwell for 125 ms
                M42 P{global.cSPinchOutNum} S1 ; Close pliers
                G4 P125 ; Dwell for 125 ms
                M42 P{global.cSPinchOutNum} S0.75 ; Reduce pliers-closing solenoid current to 75%
                G4 P125 ; Dwell for 125 ms
                M42 P{global.cSPinchOutNum} S0.5 ; Reduce pliers-closing solenoid current to 50%
                M291 P"Are the pliers closed on the straight portion of the nozzle?" R"Wclean" S3
                M42 P{global.cSSolenoidOutNum} S0 ; Retract cleaning station
                M42 P{global.cSPinchOutNum} S0.5 ; Reduce pliers-closing solenoid current to 50%
                G4 P175 ; Dwell for 175 ms
                M42 P{global.cSPinchOutNum} S0 ; Open Pliers
                M400 ; Wait for current moves to finish
                M291 P"Is the cleaning station fully homed?" R"Homed W" S3

            G90 ; Set to Absolute Positioning

            G1 U0 F9900 ; Rotate turret (U) to point extruder at the bed at 9900 mm/min
            G4 P20 ; Dwell for 20 ms
            M98 P"lock_turret.g" ; Call lock_turret.g
        else
            echo "Tool "^iterations^" ("^tools[iterations].name^") is not an extruder. Skipping prime positions check for this tool."
            continue
    else
        echo "Tool "^iterations^" ("^tools[iterations].name^") is not an extruder. Skipping prime positions check for this tool."
        continue

if state.restorePoints[0].coords[2] + 2 <= {move.axes[2].max - global.maxOffset}
    G1 R0 Z2 F6000 ; Return to 2mm above Z coordinate stored in restore point 2 at 6000 mm/min
else
    G1 Z{move.axes[2].max + global.maxOffset} F6000 ; Move to Z = ZMax + Longest Z Offset at 6000 mm/min