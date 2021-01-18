
; Switch to FFF mode
M451

; Move Z up and unlock the turret
G91
G1 Z25 F6000
G90
M98 P"unlock_turret.g"

; Move turret
G1 U30 F16000
G4 P20

; Lock the turret again
M98 P"lock_turret.g"

;G92 U30
