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
M950 F1 C"2.out3"         ; Extruder Cooling Fans - Define Fan 1 to use pin fan1
M950 F2 C"2.out6"         ; 12V cooling fan

; Fan configuration
M106 P1 H5 T50 ; 24V cooling fans
M106 P2 H3 T50 ; 12V cooling fans

M302 S150 ; Set minimum extrude temp
