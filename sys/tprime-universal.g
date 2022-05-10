; tprime-universal.g
; Universal priming macro
; Written by Diabase Engineering
; Last Updated: April 15, 2022

M118 S{"Debug: Begin tprime-universal.g"} L3

if state.currentTool = -1
    abort "No tool currently active. Priming cycle aborted."

elif #tools[{state.currentTool}].extruders == 0 ; If this tool has no extruders...
    abort "Tool "^state.currentTool^" ("^tools[{state.currentTool}].name^") is not an extruder and cannot be primed. Priming cycle aborted."

G91 ; Relative Positioning
if move.axes[2].machinePosition + 40 <= move.axes[2].max ; If we have enough room for a normal tool change Z-hop, do it.
    G1 Z40 F6000 ; Move Z +40mm at 6000 mm/min
elif move.axes[2].machinePosition + 40 > move.axes[2].max ; If we don't have enough room, move as high as we can.
    M574 Z2 S1 P{global.zSwitchPin} ; Configure Z endstop position at high end, it's a microswitch on pin defined in defaultparameters.g
    M400 ; Wait for all moves to finish
    G1 Z40 F6000 H3 ; Attempt to move Z +40mm at 6000 mm/min, but halt if endstop triggered and set axis limit current position, overriding value set by previous M208 or G1 H3 special move
    M400 ; Wait for all moves to finish

G60 S0 ; Save current position to slot 0

G90 ; Set to Absolute Positioning
G1 Y85 F6000 ; Move Y to 85 mm at 6000 mm/min

M98 P"unlock_turret.g" ; Call unlock_turret.g
if tools[{state.currentTool}].offsets[3] + 100.00 <= 0
    G1 U-100.00 F9900; Rotate turret (U) to point extruder at priming surface 260.00 (-100.00 mod 360) at 9900 mm/min
elif tools[{state.currentTool}].offsets[3] + 100.00 > 0
    G1 U260.00 F9900; Rotate turret (U) to point extruder at priming surface 260.00 (-100.00 mod 360) at 9900 mm/min

G4 P20 ; Dwell for 20 ms

M116 P{state.currentTool} S5 ; Wait until tool reaches +/-5C of its set value

if global.cSType == "Motor"
    G1 W{global.wPrimeSurface} F15000 ; Move W to value specified in defaultparameters.g at 15000 mm/min to extend cleaning station to priming location
    M83 ; Set Extruder to Relative Mode
    G1 E{tools[{state.currentTool}].retraction.length} F{tools[{state.currentTool}].retraction.speed*60} ; Anti-Ooze Makeup Extrusion - Extrude Filament at After Prime Retraction Amount and Feedrate
    G1 E{tools[{state.currentTool}].retraction.length + tools[{state.currentTool}].retraction.extraRestart} F{tools[{state.currentTool}].retraction.unretractSpeed*60} ; Extrude Filament at Prime Extrusion Amount and Feedrate
    M400 ; Wait for current moves to finish
    G1 W{global.wClearance} F15000 ; Move W to 5mm less than value specified in defaultparameters.g at 6000 mm/min to retract cleaning station to the clearance location for a turret rotation
    G1 E{-{tools[{state.currentTool}].retraction.length + global.currentAdditionalRetraction}} F{tools[{state.currentTool}].retraction.speed*60} ; Anti-Ooze Retraction - Retract Filament at After Prime Retraction Amount (with Additional Retraction Amount) and Feedrate
    G4 P20 ; Dwell for 20 ms

elif global.cSType == "Solenoid"
    M42 P{global.cSSolenoidOutNum} S1 ; Set GPIO pin 0 high to fully extend cleaning station to priming location
    M83 ; Set Extruder to Relative Mode
    G1 E{tools[{state.currentTool}].retraction.length} F{tools[{state.currentTool}].retraction.speed*60} ; Anti-Ooze Makeup Extrusion - Extrude Filament at After Prime Retraction Amount and Feedrate
    M42 P{global.cSSolenoidOutNum} S0.75 ; Set GPIO pin 0 to 75%
    G1 E{tools[{state.currentTool}].retraction.length + tools[{state.currentTool}].retraction.extraRestart} F{tools[{state.currentTool}].retraction.unretractSpeed*60} ; Button Extrusion - Extrude Filament at Prime Extrusion Amount and Feedrate
    M400 ; Wait for current moves to finish
    M42 P{global.cSSolenoidOutNum} S0 ; Set GPIO pin 0 to low 
    G1 E{-{tools[{state.currentTool}].retraction.length + global.currentAdditionalRetraction}} F{tools[{state.currentTool}].retraction.speed*60} ; Anti-Ooze Retraction - Retract Filament at After Prime Retraction Amount (with Additional Retraction Amount) and Feedrate
    G4 P20 ; Dwell for 20 ms

if tools[{state.currentTool}].offsets[3] + 90.00 <= 0
    G1 U-90.00 F9900; Rotate turret (U) to point extruder at pliers (270.00mm == (-90.00mm mod 360)) at 9900 mm/min
elif tools[{state.currentTool}].offsets[3] + 90.00 > 0
    G1 U270.00 F9900; Rotate turret (U) to point extruder at pliers (270.00mm == (-90.00mm mod 360)) at 9900 mm/min

G4 P20 ; Dwell for 20 ms
if {{global.vacuumFanNum} != -1}
    M106 P{global.vacuumFanNum} S1 ; Turn vacuum on

M98 P"clean.g" ; Call clean.g

M42 P{global.cSPinchOutNum} S1 ; Close pliers
G4 P20 ; Dwell for 20 ms
M42 P{global.cSPinchOutNum} S0.4 ; Reduce pliers solenoid current to 40%

G90 ; Set to Absolute Positioning

G1 U0 F9900 ; Rotate turret (U) to point extruder at the bed at 9900 mm/min
G4 P20 ; Dwell for 20 ms
M98 P"lock_turret.g" ; Call lock_turret.g

; Perform post-cleaning of the pliers
M98 P"postclean.g" ; Call postclean.g

if {{global.vacuumFanNum} != -1}
    M106 P{global.vacuumFanNum} S0 ; Turn vacuum off

G1 R0 Y0 F6000 ; Return to Y coordinate saved in restore point 0 at 6000 mm/min

if state.restorePoints[0].coords[2] + 2 <= {move.axes[2].max - global.maxOffset}
    G1 R0 Z2 F6000 ; Return to 2mm above Z coordinate stored in restore point 2 at 6000 mm/min
else
    G1 Z{move.axes[2].max + global.maxOffset} F6000 ; Move to Z = ZMax + Longest Z Offset at 6000 mm/min
    
M118 S{"Debug: End tprime-universal.g"} L3