; tcreate-universal.g
; Creates and configures all tools
; Written by Diabase Engineering
; Last Updated: February 22, 2021

M98 P"tcreate1.g"
M98 P"tcreate2.g"
M98 P"tcreate3.g"
M98 P"tcreate4.g"
M98 P"tcreate5.g"
M563 P10 S"Probe"

;Fans
M950 F1 C"1.out7"         ; Extruder Cooling Fans - OUT7 on extruder expansion board (set to 12V)
M950 F2 C"1.out8"         ; Cooling fan - OUT8 on extruder expansion board (set to 12V)

; Fan configuration
M106 P1 H1:2:4 T50 ; FDM cooling fans tehrmostatic on T1, T2, T4
M106 P2 C"Cooling" ; Cooling fan on "Fan 2", controllable

M302 S150 ; Set minimum extrude temp
