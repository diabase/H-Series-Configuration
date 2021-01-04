; Switch to FFF mode
M451

; Move Z up and unlock the turret
G91
G1 Z15 F6000
G90
M98 P"unlock_turret.g"

; Move to the right coordinates
G1 U0 F9900
G4 P20

; Lock the turret again
M98 P"lock_turret.g"

; Configure the Z probe switch
M574 Z1 S2