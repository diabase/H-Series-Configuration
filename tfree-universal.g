; Universal tfree macro
; Called whenever a tool is de-selected
; Written by Diabase Engineering
; Last Updated: July 15, 2021

M118 S{"Info: Begin tfree-universal.g"} L2
M453                            ; Switch to CNC mode
M402 P0                         ; Retract Probe
M574 Z2 S1 P{global.ZSwitchPin} ; Configure Z endstop position at high end, it's a microswitch on pin defined in defaultparameters.g
M5                              ; Turn off all spindles
M118 S{"Info: End tfree-universal.g"} L2
