; Universal tfree macro
; Called whenever a tool is de-selected
; Written by Diabase Engineering
; Last Updated: July 14, 2021

M453 ; Switch to CNC mode
M574 Z2 S1 P{global.ZSwitchPin} ; Configure Z endstop position at high end, it's a microswitch on pin defined in machinespecific.g
M5 ; Turn off all spindles
