; Switch to FFF mode
M451
M84 E0
; Move Z up and unlock the turret
G91
G1 Z5 F6000
G90
M98 P"unlock_turret.g"

; Move to the right coordinates
G1 U0 F9900
G4 P20

; Lock the turret again
M98 P"lock_turret.g"

G92 U0

; Configure the Z probe switch
M574 Z1 S2