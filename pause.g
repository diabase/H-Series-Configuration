; pause.g
; Called when a job is paused.
; Written by Diabase Engineering
; Last Updated: July 20, 2021

G60 S0  ;   save current tool information

if state.machineMode="FFF"
    M83 ; Set extruder to relative mode
    G1 E-10 F6000 ; Retract 10mm of filament at 6000 mm/min

G91 ; Relative Positioning
M574 Z2 S1 P{global.ZSwitchPin} ; Configure Z endstop position at high end, it's a microswitch on pin defined in machinespecific.g
if move.axes[2].machinePosition + 40 <= move.axes[2].max ; If we have enough room for a normal tool change Z-hop, do it.
    G1 Z40 F6000 ; Move Z +40mm at 6000 mm/min
elif move.axes[2].machinePosition + 40 > move.axes[2].max ; If we don't have enough room, move as high as we can.
    M574 Z2 S1 P{global.ZSwitchPin} ; Configure Z endstop position at high end, it's a microswitch on pin defined in machinespecific.g
    M400 ; Wait for all moves to finish
    M913 Z50; Reduce Z-axis motor current to 50%
    G1 Z40 F1000 H3 ; Attempt to move Z +40mm at 1000 mm/min, but halt if endstop triggered and set axis limit current position, overriding value set by previous M208 or G1 H3 special move
    M400 ; Wait for all moves to finish
    M913 Z100 ; Restore Z-axis motor current to 100%

G90 ; Set to Absolute Positioning
G1 Y85 F6000 ; Move Y to 85 mm at 6000 mm/min

if {state.currentTool} != -1 ; If we have a tool selected...
    if {{tools[{state.currentTool}].spindle != -1} && {#tools[{state.currentTool}].extruders == 0}} ; If this tool is a spindle...
        M3 P{tools[{state.currentTool}].spindle} S0 ; ...set it to 0 RPM, clockwise.

M400 ; Wait for current moves to finish

; Put all the tools into standby mode and leave no tool selected
T1 P0
T2 P0
T3 P0
T4 P0
T5 P0
T10 P0
T{state.restorePoints[0].toolNumber} P0

if heat.heaters[0] != null ; ...and we have defined a bed heater...
    if {heat.heaters[0].state != "fault" && heat.heaters[0].current != -273.15} ; ...and it's not in a fault state...
        M144 S0 ; Set bed to standby
