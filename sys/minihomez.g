; minihomez.g
; Called to confirm z-axis position
; Written by Diabase Engineering
; Last Updated: April 26, 2022

M118 S{"Debug: Begin minihomez.g"} L3

var zAxisIndex = -1
while iterations < #move.axes
    if move.axes[iterations].letter == "Z"
        set var.zAxisIndex = iterations
        break

; Ensure appropriate axis endstops are used
M574 Z2 S1 P{global.zSwitchPin}                             ; Configure Z endstop position at high end, pin defined in defaultparameters.g

G90                                                         ; Absolute positioning
while sensors.endstops[var.zAxisIndex].triggered == true
    G1 H2 Z{move.axes[var.zAxisIndex].machinePosition - 1} F6000
    M400

G53 G1 H2 Z{move.axes[var.zAxisIndex].max - 2} F10000       ; Move Z quickly to 2mm below ZMax ignoring endstops
M400                                                        ; Wait for all moves to finish
G53 G1 H1 Z{move.axes[var.zAxisIndex].max + 4} F200         ; Attempt to move Z +20mm at 200 mm/min, but halt if endstop triggered and set axis position to axis limit as defined by previous M208 or G1 H3 special move
M400                                                        ; Wait for all moves to finish
G53 G1 Z{move.axes[var.zAxisIndex].max} F10000              ; Move to Z = ZMax at 10000 mm/min

if {state.currentTool} != -1                                ; If we have a tool selected...
    if {tools[{state.currentTool}].spindle == -1}           ; If this tool has no spindles...
        if {#tools[{state.currentTool}].extruders == 0}     ; ... or extruders, we assume it's a probe
            M574 Z1 S2                                      ; Set Z endstop position to low end and configure as Z probe

M118 S{"Debug: End minihomez.g"} L3
