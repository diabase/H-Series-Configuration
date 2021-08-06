; lock_turret.g
; Called to engage the turret latch
; Written by Diabase Engineering
; Last Updated: August 6, 2021

M118 S{"Debug: Begin lock_turret.g"} L3

G92 V0          ; Assign current V position to 0
G91             ; Set to Relative Positioning
G1 V-3          ; Move V -3.
G1 U-0.5 V-3    ; Move U -0.5 mm and V -3 mm.
G1 U0.5 V-3     ; Move U 0.5 mm and V -3 mm.
G1 U-0.25 V-0.5 ; Move U -0.25 mm and V -0.5 mm.
G1 U0.25 V-0.5  ; Move U 0.25 mm and V -0.5 mm.
G1 U-0.15 V-0.5 ; Move U -0.15 mm and V -0.5 mm.
G1 U0.15 V-0.5  ; Move U 0.15 mm and V -0.5 mm.
G4 P20          ; Dwell for 20 ms

M118 S{"Debug: End lock_turret.g"} L3
