; disengagezbrake.g
; Behavior for Engaging the Z Brake
; Parameters: 
;   H: Homing?

; Written by Diabase Engineering
; Last Updated: July 14, 2021

M118 S{"Info: Begin disengagezbrake.g"} L2

if state.gpOut[2].pwm == 1
    M118 S{"Info: Z brake fully engaged."} L2
elif state.gpOut[2].pwm == 0
    M118 S{"Info: Z brake fully disengaged."} L2
else
    M118 S{"Info: Z brake partly engaged."} L2

if move.axes[3].homed == true
    M118 S{"Info: Z axis homed, releasing Z brake."} L2
    M42 P2 S0 ; Release Z Brake
    if state.gpOut[2].pwm == 0
    
if param.H == 1
    M118 S{"Info: Homing Z axis, releasing Z brake."} L2
    M42 P{global.ZBrakeOutNum} S0 ; Release Z Brake
    if state.gpOut[{global.ZBrakeOutNum}].pwm == 0.0
        M118 S{"Info: Z brake fully disengaged."} L2
    else
        M118 S{"Error: Z brake did not fully disengage. Z brake value is now "^state.gpOut[2].pwm} L2
else
    M118 S{"Info: Z axis not homed, leaving Z brake value unchanged at "^state.gpOut[2].pwm} L2

M118 S{"Info: End disengagezbrake.g"} L2