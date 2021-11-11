; deployprobe0.g
; Prepare turret probe for use
; Written by Diabase Engineering
; Last Updated: October 28, 2021

M118 S{"Debug: Begin deployprobe0.g"} L3
set global.isMovingProbe = 1

if state.gpOut[{global.probeRetractOutNum}].pwm == 1.0
    M118 S{"Debug: Probe is retracted."} L3
elif state.gpOut[{global.probeRetractOutNum}].pwm == 0.0
    M118 S{"Debug: Probe is deployed."} L3
else
    M118 S{"Error: Probe is in an intermediate state."} L3

M118 S{"Debug: Attempting to deploy probe."} L3
M42 P{global.probeRetractOutNum} S0.0                                                                                               ; Deactivate probe retract solenoid

if state.gpOut[{global.probeRetractOutNum}].pwm == 0.0
    M118 S{"Debug: Probe deployed."} L3
else
    M118 S{"Error: Probe not fully deployed. Probe retract value is now "^state.gpOut[{global.probeRetractOutNum}].pwm^"."} L3

G4 P100                                                                                                                              ; Wait 100 ms

set global.isMovingProbe = 0
M118 S{"Debug: End deployprobe0.g"} L3
