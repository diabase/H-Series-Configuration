; Universal priming macro

if #tools[{state.currentTool}].name != 8 ; If this tool is not extruder...
    abort "Tool "^state.currentTool^" ("^tools[{state.currentTool}].name^") is not an extruder and cannot be primed. Priming cycle aborted."

G60 S0 ; Save current position to slot 0

G91 ; Relative Positioning
if move.axes[2].machinePosition + 40 <= move.axes[2].max ; If we have enough room for a normal tool change Z-hop, do it.
    G1 Z40 F6000 ; Move Z +40mm at 6000 mm/min
elif move.axes[2].machinePosition + 40 > move.axes[2].max ; If we don't have enough room, move as high as we can.
    M574 Z2 S1 P"zstop" ; Configure Z endstop position at high end, it's a microswitch on pin "zstop"
    M400 ; Wait for all moves to finish
    M913 Z50; Reduce Z-axis motor current to 50%
    G1 Z40 F6000 H3 ; Attempt to move Z +40mm at 6000 mm/min, but halt if endstop triggered and set axis limit current position, overriding value set by previous M208 or G1 H3 special move
    M400 ; Wait for all moves to finish
    M913 Z100 ; Restore Z-axis motor current to 100%

G90 ; Set to Absolute Positioning
G1 Y85 F6000 ; Move Y to 85 mm at 6000 mm/min

M98 P"unlock_turret.g" ; Call unlock_turret.g
if tools[{state.currentTool}].offsets[3] + 100.5 <= 0
    G1 U-100.5 F9900; Rotate turret (U) to point extruder at priming surface 259.5 (-100.5 mod 360) at 9900 mm/min
elif tools[{state.currentTool}].offsets[3] + 100.5 > 0
    G1 U259.5 F9900; Rotate turret (U) to point extruder at priming surface 259.5 (-100.5 mod 360) at 9900 mm/min

G4 P20 ; Dwell for 20 ms

M116 P{state.currentTool} S5 ; Wait until tool reaches +/-5C of its set value

if {(move.axes[5].letter ^ "") == "W"} ; Motor-driven cleaning station
    G1 W23 F15000 ; Move W to 23mm at 15000 mm/min to extend cleaning station to priming location
    M83 ; Set Extruder to Relative Mode
    G1 E20 F6000 ; Extrude 20 mm at 6000 mm/min
    G1 E8 F200 ; Extrude 6 mm at 300 mm/min
    M400 ; Wait for current moves to finish
    G1 W20 F6000 ; Move W  to 20mm at 6000 mm/min to retract cleaning station to cleaning location
    G1 E-16 F6000 ; Retract 16 mm at 6000 mm/min
    G4 P20 ; Dwell for 20 ms

else ; Solenoid-driven cleaning station
    M42 P0 S1 ; Set GPIO pin 0 high
    M83 ; Set Extruder to Relative Mode
    G1 E20 F6000 ; Extrude 20 mm at 6000 mm/min
    M42 P0 S0.75 ; Set GPIO pin 0 to 75%
    G1 E8 F200 ; Extrude 6 mm at 300 mm/min
    M400 ; Wait for current moves to finish
    M42 P0 S0 ; Set GPIO pin 0 to low (Solenoid-driven cleaning station only)
    G1 E-16 F6000 ; Retract 16 mm at 6000 mm/min
    G4 P20 ; Dwell for 20 ms

if tools[{state.currentTool}].offsets[3] - 89.62 <= 0
    G1 U-89.62 F9900; Rotate turret (U) to point extruder at pliers 270.38 (-89.62 mod 360) at 9900 mm/min
elif tools[{state.currentTool}].offsets[3] - 89.62 > 0
    G1 U270.38 F9900; Rotate turret (U) to point extruder at pliers 270.38 (-89.62 mod 360) at 9900 mm/min

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