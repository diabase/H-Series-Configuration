M574 Z2 S1 P"!io4.in"; Configure Z endstop position at high end, it's a microswitch on pin "zstop"

G91 ; Relative Positioning
G1 Z40 F6000 H3 ; Attempt to move Z +40mm at 6000 mm/min, but halt when endstop triggered and set axis limit current position, overriding value set by M208 in config.g
G90 ; Absolute Positioning
G1 Y85 F6000 ; Move Y to 85mm at 6000 mm/min

G10 P1 R0 S0 ; Set Tool 1 active and standby temperatures to 0C
G10 P2 R0 S0 ; Set Tool 2 active and standby temperatures to 0C
G10 P3 R0 S0 ; Set Tool 3 active and standby temperatures to 0C
G10 P4 R0 S0 ; Set Tool 4 active and standby temperatures to 0C
G10 P5 R0 S0 ; Set Tool 5 active and standby temperatures to 0C
M400 ; Wait for current moves to finish
