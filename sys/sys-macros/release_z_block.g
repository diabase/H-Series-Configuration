; release_z_block.g
; Lower the arm by 10mm to free the block used for shipping
; Written by Diabase Engineering
; Last Updated: April 26, 2022

M118 S{"Begin release_z_block.g"} L1

; Ensure appropriate axis endstops are used
M574 Z2 S1 P{global.zSwitchPin}                             ; Configure Z endstop position at high end, pin defined in defaultparameters.g

G91                                                         ; Relative Positioning
G1 H1 Z.5 F6000                                             ; Move Z +0.5mm at 6000 mm/min
M98 P"disengagezbrake.g" H1                                 ; Disengage Z brake
G4 P300                                                     ; Wait 300 ms

M400                                                        ; Wait for all moves to finish
G1 H1 Z-10 F1000                                            ; Attempt to move Z -10 mm at 1000 mm/min even if Z is unhomed
M98 P"engagezbrake.g" H1                                    ; Disengage Z brake
M18 Z                                                       ; Disable Z motor

M118 S{"End release_z_block.g"} L1
