; engagezbrake.g
; Behavior for Engaging the Z Brake
; Written by Diabase Engineering
; Last Updated: November 05, 2021

M118 S{"Debug: Begin engagezbrake.g"} L3

if state.gpOut[{global.zBrakeOutNum}].pwm == 1.0
    M118 S{"Debug: Z brake fully engaged."} L3
elif state.gpOut[{global.zBrakeOutNum}].pwm == 0.0
    M118 S{"Debug: Z brake fully disengaged."} L3
else
    M118 S{"Debug: Z brake partly engaged."} L3

M118 S{"Debug: Engaging z brake."} L3
M42 P{global.zBrakeOutNum} S1.0 ; Engage Z Brake
if state.gpOut[{global.zBrakeOutNum}].pwm == 1.0
    M118 S{"Debug: Z brake fully engaged."} L3
else
    M118 S{"Warning: Z brake did not fully engage. Z brake value is now "+state.gpOut[{global.zBrakeOutNum}].pwm} L1

M118 S{"Debug: End engagezbrake.g"} L3
