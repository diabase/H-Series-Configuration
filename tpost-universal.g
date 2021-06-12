; Universal tpost macro

M453 ; Switch to CNC mode
G90
; MOVE TURRET TO ACTIVE LOCATION
;Only perform machine moves if we need to change the turret position
if move.axes[3].userPosition != 0 ;
    G90 ; Absolute Positioning
    if move.axes[2].machinePosition + 10 <= move.axes[2].max ; If we have enough room for a normal tool change Z-hop, do it.
        G91
		G1 Z10 F6000 ; Move Z +40mm at 6000 mm/min
		G90
    elif move.axes[2].machinePosition + 10 > move.axes[2].max ; If we don't have enough room...
        ;G90 ; Absolute Positioning
        ;G1 Z{move.axes[2].max} ; Move as high as we can.    M98 P"unlock_turret.g" ; Call unlock_turret.g
    M98 P"unlock_turret.g" ; Call lock_turret.g
	G1 U0 F16000 ; Rotate turret to new tool
    G4 P20 ; Dwell for 20 ms
    M98 P"lock_turret.g" ; Call lock_turret.g

;TURN OFF BED HEATER
;if tools[{state.currentTool}].spindle>-1       ; If this tool is a spindle...
;    M453 ; Switch to CNC mode
;    if heat.bedHeaters[0] > -1 ; If we have defined a bed heater...
;        if heat.bedHeaters[0].state != "fault" ; ...and it's not in a fault state...
;            M140 H0 S-273.15 ; ...turn it off to protect power supply.

;elif #tools[{state.currentTool}].extruders > 0 ; If this tool is an extruder
;    M451 ; Switch to FFF Mode

;else                                        ;defaults to probe
;    M453 ; Switch to CNC mode
;    M574 Z1 S2 ; Set Z endstop position to low end and configure as Z probe    

set global.TCactive=0   ;   toolchange is no longer active

;MOVE DOWN TO PREVIOUS LOCATION + 2
if state.previousTool != -1 ; If we changed to this tool from another tool...
    G90 ; Set to Absolute Positioning
    G1 R2 X0 Y0 F6000 ; Return to X and Y coordinates stored in restore point 2 at a speed of 6000 mm/min
    if state.restorePoints[2].coords[2] + 2 <= {move.axes[2].max - global.TClength}
        G1 R2 Z2 ; Return to 2mm above Z coordinate stored in restore point 2
    else
        G1 Z{move.axes[2].max - global.TClength} F10000 ; Move to Z = ZMax + Longest Z Offset at 10000 mm/min
