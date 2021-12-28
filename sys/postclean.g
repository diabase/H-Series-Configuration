; postclean.g
; Open and close the cleaning station pliers to clear any filament buttons
; Written by Diabase Engineering
; Last Updated: July 16, 2021

M42 P{global.cSPinchOutNum} S1 ; Close pliers
G4 P125 ; Dwell for 125 ms
M42 P{global.cSPinchOutNum} S0 ; Open pliers
G4 P125 ; Dwell for 125 ms
M42 P{global.cSPinchOutNum} S1 ; Close pliers
G4 P125 ; Dwell for 125 ms
M42 P{global.cSPinchOutNum} S0 ; Open pliers
G4 P125 ; Dwell for 125 ms
