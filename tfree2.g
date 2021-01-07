if state.machineMode="CNC"
    M3 P0 S0
    M3 P1 S0
    M3 P2 S0
if state.machineMode!="CNC"
    M453 ; Set to CNC Mode
