; Switch to FFF mode
M451

; Move Z up and unlock the turret
G91
G1 Z15 F6000
G90
M98 P"unlock_turret.g"

; Move turret
G1 U228.3 F9900
G4 P20

; Lock the turret again
M98 P"lock_turret.g"