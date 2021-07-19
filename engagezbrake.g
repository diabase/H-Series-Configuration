; engagezbrake.g
; Behavior for Engaging the Z Brake
; Written by Diabase Engineering
; Last Updated: July 16, 2021

M118 S{"Info: Begin engagezbrake.g"} L2

if state.gpOut[{global.ZBrakeOutNum}].pwm == 1.0
    M118 S{"Info: Z brake fully engaged."} L2
elif state.gpOut[{global.ZBrakeOutNum}].pwm == 0.0
    M118 S{"Info: Z brake fully disengaged."} L2
else
    M118 S{"Info: Z brake partly engaged."} L2

M118 S{"Info: Engaging z brake."} L2
M42 P{global.ZBrakeOutNum} S1.0 ; Engage Z Brake
if state.gpOut[{global.ZBrakeOutNum}].pwm == 1.0
    M118 S{"Info: Z brake fully engaged."} L2
else
    M118 S{"Error: Z brake did not fully engage. Z brake value is now "+state.gpOut[{global.ZBrakeOutNum}].pwm} L2
echo state.upTime^"."^state.msUpTime^": Vin is " ^ boards[0].vIn.current ^ "V12 is " ^ boards[0].v12.current

M118 S{"Info: End engagezbrake.g"} L2
