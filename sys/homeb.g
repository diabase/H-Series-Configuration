; homeb.g
; Called to home tool changer
; Written by Diabase Engineering
; Last Updated: January 07, 2022

M118 S{"Debug: Begin homeb.g"} L3


M42 P{global.tCToolReleaseOutNum} S0    ; Ensure the tool changer release piston is retracted

T0 P0                                   ; Select Tool 0 but don't run any of the tool changing files
G91                                     ; Relative positioning
G1 B-500 H1 F30000                      ; Attempt to move B axis by -500 mm, but stop when endstop is triggered and set axis position to axis limit as defined by previous M208 or G1 H3 special move
M400                                    ; Wait for current moves to finish
G1 B2 F30000                            ; Move off the endstop
M400                                    ; Wait for current moves to finish
G1 B-5 H1 F200                          ; Attempt slow overrun move to find accurate endstop position, stopping when endstop is triggered and set axis position to axis limit as defined by previous M208 or G1 H3 special move
M400                                    ; Wait for current moves to finish
G90                                     ; Absolute positioning
G1 B0 F30000                            ; Move to B0 at 30,000 mm/min
T{state.previousTool} P0                ; Re-select previous tool, but don't run any of the tool changing files

M118 S{"Debug: End homeb.g"} L3
