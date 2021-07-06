echo state.upTime^"."^state.msUpTime^": trigger4.g begins"
echo state.upTime^"."^state.msUpTime^": Vin is " ^ boards[0].vIn.current ^ ". V12 is " ^ boards[0].v12.current^ "."
while boards[0].vIn.current < 24
    echo state.upTime^"."^state.msUpTime^": Loop "^{iterations}^". Vin is " ^ boards[0].vIn.current ^ ". V12 is " ^ boards[0].v12.current^ "."
    G4 P100
echo state.upTime^"."^state.msUpTime^": Vin is " ^ boards[0].vIn.current ^ ". V12 is " ^ boards[0].v12.current^ "."
G4 S1

; Insert macro to restore CAN bus board properties here.

if state.gpOut[2].pwm == 0
    echo state.upTime^"."^state.msUpTime^": E-Stop released. Z brake fully engaged."
elif state.gpOut[2].pwm == 1
    echo state.upTime^"."^state.msUpTime^": E-Stop released. Z brake fully disengaged."
else
    echo state.upTime^"."^state.msUpTime^": E-Stop released. Z brake partly engaged."

if move.axes[3].homed == true
    echo state.upTime^"."^state.msUpTime^": Z axis homed, releasing Z brake".
    M42 P2 S1 ; Release Z Brake
    if state.gpOut[2].pwm == 1
        echo state.upTime^"."^state.msUpTime^": Z brake fully released."
    else
        echo state.upTime^"."^state.msUpTime^": Error: Z brake did not fully release. Z brake value is now "^state.gpOut[2].pwm
else
    echo state.upTime^"."^state.msUpTime^": Z axis not homed, leaving Z brake value unchanged at "^state.gpOut[2].pwm
echo state.upTime^"."^state.msUpTime^": Vin is " ^ boards[0].vIn.current ^ ". V12 is " ^ boards[0].v12.current^ "."
echo state.upTime^"."^state.msUpTime^": Trigger4.g ends"
