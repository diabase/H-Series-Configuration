; homeb.g
; Called to home tool changer
; Written by Diabase Engineering
; Last Updated: January 10, 2022
; TODO: Remove bMin setting from global variable on line 10 - RT 3/18/2022
; TODO: Remove forced b-axis limits on line 23 - RT 3/18/2022

M118 S{"Debug: Begin homeb.g"} L3

M208 B{global.bMin} S1 
M42 P{global.tCToolReleaseOutNum} S0    ; Ensure the tool changer release piston is retracted

T-1 P0                                  ; Deselect the current tool, but don't run any of the tool changing files
G91                                     ; Relative positioning
G1 B-500 H1 F15000                      ; Attempt to move B axis by -500 mm, but stop when endstop is triggered and set axis position to axis limit as defined by previous M208 or G1 H3 special move
M400                                    ; Wait for current moves to finish
G1 B2 F15000                            ; Move off the endstop
M400                                    ; Wait for current moves to finish
G1 B-5 H1 F200                          ; Attempt slow overrun move to find accurate endstop position, stopping when endstop is triggered and set axis position to axis limit as defined by previous M208 or G1 H3 special move
M400                                    ; Wait for current moves to finish
G90                                     ; Absolute positioning
G1 B0 F30000                            ; Move to B0 at 30,000 mm/min
T{state.previousTool} P0                ; Re-select previous tool, but don't run any of the tool changing files
M208 B-216:216

M118 S{"Debug: End homeb.g"} L3
