if state.machineMode="FFF"
    M83 ; Set extruder to relative mode
    G1 E-10 F6000 ; Retract 10mm of filament at 6000 mm/min

G91 ; Relative Positioning
G1 Z40 F6000 H3 ; Attempt to move Z +40mm at 6000 mm/min, but halt when endstop triggered and set axis limit current position, overriding value set by M208 in config.g
G90 ; Absolute Positioning
G1 Y85 F6000 ; Move Y to 85mm at 6000 mm/min

if state.machineMode="CNC"
    M3 P0 S0 ; Set Spindle 0 RPM to 0
    M3 P1 S0 ; Set Spindle 1 RPM to 0
    M3 P2 S0 ; Set Spindle 2 RPM to 0
