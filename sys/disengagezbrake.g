; disengagezbrake.g
; Behavior for Engaging the Z Brake
; Parameters: 
;   H: Homing?

; Written by Diabase Engineering
; Last Updated: January 25, 2022

M118 S{"Debug: Begin disengagezbrake.g"} L3

if state.gpOut[{global.zBrakeOutNum}].pwm == 1.0
    M118 S{"Debug: Z brake fully engaged."} L3
elif state.gpOut[{global.zBrakeOutNum}].pwm == 0.0
    M118 S{"Debug: Z brake fully disengaged."} L3
else
    M118 S{"Debug: Z brake partly engaged."} L3

if move.axes[3].homed == true
    M118 S{"Debug: Z axis homed, releasing Z brake."} L3
    M42 P{global.zBrakeOutNum} S0.0 ; Release Z Brake
    if state.gpOut[{global.zBrakeOutNum}].pwm == 0.0
        M118 S{"Debug: Z brake fully disengaged."} L3
    else
        M118 S{"Warning: Z brake did not fully disengage. Z brake value is now "^state.gpOut[2].pwm} L1
else
    M118 S{"Debug: Z axis not homed, leaving Z brake value unchanged at "^state.gpOut[2].pwm} L3
    
if {exists(param.H)}
    if param.H == 1
        M118 S{"Debug: Homing Z axis, releasing Z brake."} L3
        M42 P{global.zBrakeOutNum} S0 ; Release Z Brake
        if state.gpOut[{global.zBrakeOutNum}].pwm == 0.0
            M118 S{"Debug: Z brake fully disengaged."} L3
        else
            M118 S{"Warning: Z brake did not fully disengage. Z brake value is now "^state.gpOut[2].pwm} L1

M118 S{"Debug: End disengagezbrake.g"} L3
