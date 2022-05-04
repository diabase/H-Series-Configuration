; tprime-universal.g
; Universal priming macro
; Written by Diabase Engineering
; Last Updated: April 5, 2021

if #tools[{state.currentTool}].name != 8 ; If this tool is not extruder...
    abort "Tool "^state.currentTool^" ("^tools[{state.currentTool}].name^") is not an extruder and cannot be primed. Priming cycle aborted."

G60 S0 ; Save current position to slot 0

G91 ; Relative Positioning
if move.axes[2].machinePosition + 40 <= move.axes[2].max ; If we have enough room for a normal tool change Z-hop, do it.
    G1 Z40 F6000 ; Move Z +40mm at 6000 mm/min
elif move.axes[2].machinePosition + 40 > move.axes[2].max ; If we don't have enough room...
    G90 ; Absolute Positioning
    G1 Z{move.axes[2].max} ; Move as high as we can.

G90 ; Set to Absolute Positioning
G1 Y85 F6000 ; Move Y to 85 mm at 6000 mm/min

M98 P"unlock_turret.g" ; Call unlock_turret.g
if tools[{state.currentTool}].offsets[3] + 100.00 <= 0
    G1 U-100.00 F9900; Rotate turret (U) to point extruder at priming surface 260.00 (-100.00 mod 360) at 9900 mm/min
elif tools[{state.currentTool}].offsets[3] + 100.00 > 0
    G1 U260.00 F9900; Rotate turret (U) to point extruder at priming surface 260.00 (-100.00 mod 360) at 9900 mm/min

G4 P20 ; Dwell for 20 ms

M116 P{state.currentTool} S5 ; Wait until tool reaches +/-5C of its set value

while iterations < #move.axes ; Loop over all axes
    if {(move.axes[iterations].letter ^ "") == "W"} ; A W-axis is defined, so we have a motor-driven cleaning station.
        G1 W31 F15000 ; Move W to 31mm at 15000 mm/min to extend cleaning station to priming location (Wprimesurface)
        M83 ; Set Extruder to Relative Mode
        G1 E{tools[{state.currentTool}].retraction.length} F{tools[{state.currentTool}].retraction.speed*60} ; Anti-Ooze Makeup Extrusion - Extrude Filament at After Prime Retraction Amount and Feedrate
        G1 E{tools[{state.currentTool}].retraction.length + tools[{state.currentTool}].retraction.extraRestart} F{tools[{state.currentTool}].retraction.unretractSpeed*60} ; Extrude Filament at Prime Extrusion Amount and Feedrate
        M400 ; Wait for current moves to finish
        G1 W26 F6000 ; Move W to 26mm at 6000 mm/min to retract cleaning station to the clearance location for a turret rotation (Wclearance)
        G1 E{-{tools[{state.currentTool}].retraction.length}} F{tools[{state.currentTool}].retraction.speed*60} ; Anti-Ooze Retraction - Retract Filament at After Prime Retraction Amount and Feedrate
        G4 P20 ; Dwell for 20 ms
        break

    elif iterations == {#move.axes - 1} ; We're on the last loop and none were W, so assume we have a solenoid cleaning station.
        M42 P0 S1 ; Set GPIO pin 0 high to fully extend cleaning station to priming location
        M83 ; Set Extruder to Relative Mode
        G1 E{tools[{state.currentTool}].retraction.length} F{tools[{state.currentTool}].retraction.speed*60} ; Anti-Ooze Makeup Extrusion - Extrude Filament at After Prime Retraction Amount and Feedrate
        M42 P0 S0.75 ; Set GPIO pin 0 to 75%
        G1 E{tools[{state.currentTool}].retraction.length + tools[{state.currentTool}].retraction.extraRestart} F{tools[{state.currentTool}].retraction.unretractSpeed*60} ; Button Extrusion - Extrude Filament at Prime Extrusion Amount and Feedrate
        M400 ; Wait for current moves to finish
        M42 P0 S0 ; Set GPIO pin 0 to low 
        G1 E{-{tools[{state.currentTool}].retraction.length}} F{tools[{state.currentTool}].retraction.speed*60} ; Anti-Ooze Retraction - Retract Filament at After Prime Retraction Amount and Feedrate
        G4 P20 ; Dwell for 20 ms

if tools[{state.currentTool}].offsets[3] - 90.00 <= 0
    G1 U-90.00 F9900; Rotate turret (U) to point extruder at pliers (270.00mm == (-90.00mm mod 360)) at 9900 mm/min
elif tools[{state.currentTool}].offsets[3] - 90.00 > 0
    G1 U270.00 F9900; Rotate turret (U) to point extruder at pliers (270.00mm == (-90.00mm mod 360)) at 9900 mm/min

G4 P20 ; Dwell for 20 ms
M106 P8 S1 ; Turn on vacuum

M98 P"clean.g" ; Call clean.g

M42 P1 S1 ; Close pliers
G4 P20 ; Dwell for 20 ms
M42 P1 S0.4 ; Reduce pliers solenoid current to 40%

G90 ; Set to Absolute Positioning

G1 U0 F9900 ; Rotate turret (U) to point extruder at the bed at 9900 mm/min
G4 P20 ; Dwell for 20 ms
M98 P"lock_turret.g" ; Call lock_turret.g

; Perform post-cleaning of the pliers
M98 P"postclean.g" ; Call postclean.g

M106 P8 S0 ; Turn off vacuum

G1 R0 Y0 F6000 ; Return to Y coordinate saved in restore point 0 at 6000 mm/min

if state.restorePoints[0].coords[2] + 2 <= {move.axes[2].max + min(tools[1].offsets[2], tools[2].offsets[2], tools[3].offsets[2], tools[4].offsets[2], tools[5].offsets[2], tools[10].offsets[2])}
    G1 R0 Z2 F6000 ; Return to 2mm above Z coordinate stored in restore point 2 at 6000 mm/min
else
    G1 Z{move.axes[2].max + min(tools[1].offsets[2], tools[2].offsets[2], tools[3].offsets[2], tools[4].offsets[2], tools[5].offsets[2], tools[10].offsets[2])} F6000 ; Move to Z = ZMax + Longest Z Offset at 6000 mm/min
