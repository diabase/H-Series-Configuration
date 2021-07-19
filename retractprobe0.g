; retractprobe0.g
; Prepare turret probe for use
; Written by Diabase Engineering
; Last Updated: July 15, 2021

M118 S{"Info: Begin retractprobe0.g"} L2
if state.gpOut[{global.ProbeRetractOutNum}].pwm == 1.0
    M118 S{"Info: Probe is retracted."} L2
elif state.gpOut[{global.ProbeRetractOutNum}].pwm == 0.0
    M118 S{"Info: Probe is deployed."} L2
else
    M118 S{"Error: Probe is in an intermediate state."} L2

M118 S{"Info: Attempting to retract probe."} L2
M42 P{global.ProbeRetractOutNum} S1.0                       ; Retract probe

if state.gpOut[{global.ProbeRetractOutNum}].pwm == 1.0
    M118 S{"Info: Probe retracted"} L2
else
    M118 S{"Error: Probe not fully retracted. Probe retract value is now "^state.gpOut[{global.ProbeRetractOutNum}].pwm} L2

M118 S{"Info: End retractprobe0.g"} L2
