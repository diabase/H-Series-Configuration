; retractprobe0.g
; Prepare turret probe for use
; Written by Diabase Engineering
; Last Updated: October 28, 2021

M118 S{"Debug: Begin retractprobe0.g"} L3
set global.isMovingProbe = 1

if state.gpOut[{global.probeRetractOutNum}].pwm == 1.0
    M118 S{"Debug: Probe is retracted."} L3
elif state.gpOut[{global.probeRetractOutNum}].pwm == 0.0
    M118 S{"Debug: Probe is deployed."} L3
else
    M118 S{"Warning: Probe is in an intermediate state."} L1

M118 S{"Debug: Attempting to retract probe."} L3
M42 P{global.probeRetractOutNum} S1.0                                                                                               ; Activate probe retract solenoid valve

if state.gpOut[{global.probeRetractOutNum}].pwm == 1.0
    M118 S{"Debug: Probe retracted."} L3
else
    M118 S{"Warning: Probe not fully retracted. Probe retract value is now "^state.gpOut[{global.probeRetractOutNum}].pwm^"."} L1

G4 P100                                                                                                                              ; Wait 100 ms

set global.isMovingProbe = 0
M118 S{"Debug: End retractprobe0.g"} L3
