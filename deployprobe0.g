; deployprobe0.g
; Prepare turret probe for use
; Written by Diabase Engineering
; Last Updated: July 15, 2021

M118 S{"Info: Begin deployprobe0.g"} L2
if state.gpOut[{global.ProbeRetractOutNum}].pwm == 1.0
    M118 S{"Info: Probe is retracted."} L2
elif state.gpOut[{global.ProbeRetractOutNum}].pwm == 0.0
    M118 S{"Info: Probe is deployed."} L2
else
    M118 S{"Error: Probe is in an intermediate state."} L2

M118 S{"Info: Attempting to deploy probe."} L2
M42 P{global.ProbeRetractOutNum} S0.0                       ; Deploy probe

if state.gpOut[{global.ProbeRetractOutNum}].pwm == 0.0
    M118 S{"Info: Probe deployed"} L2
else
    M118 S{"Error: Probe not fully deployed. Probe retract value is now  "^state.gpOut[{global.ProbeRetractOutNum}].pwm} L2

M118 S{"Info: End deployprobe0.g"} L2
