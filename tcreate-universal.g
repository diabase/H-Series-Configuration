; tcreate-universal.g
; Creates and configures all tools
; Written by Diabase Engineering
; Last Updated: February 22, 2021

M98 P"tcreate1.g"
;M98 P"tcreate2.g"
;M98 P"tcreate3.g"
;M98 P"tcreate4.g"
;M98 P"tcreate5.g"

M302 S150 ; Set minimum extrude temp

M563 P0 S"Probe"

;Fans
M950 F1 C"2.out3"         ; Extruder Cooling Fans - Define Fan 1 to use pin fan1
M950 F2 C"2.out6"         ; 12V cooling fan
M950 F3 C"out8" ; Spindle 2 Air Flow - Define Fan 5 to use pin duex.fan5
M950 F4 C"out9" ; Spindle collet closer

; Fan configuration
M106 P1 H5 T50 ; 12V FDM fans
M106 P2 C"Cooling" ; 12V cooling fans
M106 P3 S0 B0 L1 C"T2 Air" ; Spindle 2 air flow
M106 P4 S0 B0 L1 C"Spin Collet"

M950 R0 C"io5.out+!io8.out+!io6.out" L12000
M563 P2 R0 S"T2"
M563 P11 R0 S"TC11" ; Create toolchanger tool 11 
M563 P12 R0 S"TC12" ; Create toolchanger tool 12 
M563 P13 R0 S"TC13" ; Create toolchanger tool 13
M563 P14 R0 S"TC14" ; Create toolchanger tool 14 
M563 P15 R0 S"TC15" ; Create toolchanger tool 15 
M563 P16 R0 S"TC16" ; Create toolchanger tool 16
M563 P17 R0 S"TC17" ; Create toolchanger tool 17

M453

