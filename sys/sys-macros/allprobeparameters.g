; allprobeparameters.g
; Called to display the parameters and status of all defined probes
; Written by Diabase Engineering
; Last Updated: April 25, 2022

M118 S{"Begin allprobeparameters.g"} L3

while iterations < #sensors.probes
    if sensors.probes[iterations] != null
        G31 K{iterations}
        M558 K{iterations}

M118 S{"End allprobeparameters.g"} L3
