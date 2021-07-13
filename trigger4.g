; trigger4.g
; Behavior for Disengaging the E-Stop
; Written by Diabase Engineering
; Last Updated: July 13, 2021

echo state.upTime^"."^state.msUpTime^": Trigger4.g begins"
echo state.upTime^"."^state.msUpTime^": Vin is " ^ boards[0].vIn.current ^ "V12 is " ^ boards[0].v12.current
if state.gpOut[2].pwm == 1
    echo state.upTime^"."^state.msUpTime^": Z brake fully engaged."
elif state.gpOut[2].pwm == 0
    echo state.upTime^"."^state.msUpTime^": Z brake fully disengaged."
else
    echo state.upTime^"."^state.msUpTime^": Z brake partly engaged."
echo state.upTime^"."^state.msUpTime^": Engaging Z brake."
M42 P2 S1 ; Engage Z Brake
if state.gpOut[2].pwm == 1
    echo state.upTime^"."^state.msUpTime^": Z brake fully engaged."
else
    echo state.upTime^"."^state.msUpTime^": Error: Z brake did not fully engage. Z brake value is now "+state.gpOut[2].pwm
echo state.upTime^"."^state.msUpTime^": Vin is " ^ boards[0].vIn.current ^ "V12 is " ^ boards[0].v12.current
echo state.upTime^"."^state.msUpTime^": Trigger4.g ends"