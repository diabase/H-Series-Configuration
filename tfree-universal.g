; Universal tfree macro
; Called whenever a tool is de-selected
; Written by Diabase Engineering
; Last Updated: August 6, 2021

M118 S{"Debug: Begin tfree-universal.g"} L3
M453                            ; Switch to CNC mode
M402 P0                         ; Retract Probe
M574 Z2 S1 P{global.ZSwitchPin} ; Configure Z endstop position at high end, it's a microswitch on pin defined in defaultparameters.g
M5                              ; Turn off all spindles
M118 S{"Debug: End tfree-universal.g"} L3
