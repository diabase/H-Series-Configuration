G1 R1 Y0 F3000 ; Return to Y position stored in slot 1 at 3000 mm/min
G1 R1 Z0 F3000 ; Return to Z position stored in slot 1 at 3000 mm/min

if state.machineMode="FFF"
    M83 ; Set extruder to relative mode
    G1 E10 F6000 ; Extrude the retracted 10mm of filament at 6000 mm/min

if state.machineMode="CNC"
    M3 R1           ; restore spindle RPM
    ;M3 R1 P1       ; restore spindle RPM
