; tcreate-universal.g
; Creates and configures all tools
; Written by Diabase Engineering
; Last Updated: May 12, 2021

M98 P"tcreate1.g"
M98 P"tcreate2.g"
M98 P"tcreate3.g"
M98 P"tcreate4.g"
M98 P"tcreate5.g"
M563 P10 S"Probe"

;Fans
M950 F1 C"1.out7"         ; Extruder cooling fans - jumpered to 12V
M950 F2 C"1.out8"         ; Layer cooling fans - jumpered to 12V

; Fan configuration
M106 P1 H3 T50         ; thermostatic control of cooling fan on heaters 1, 3, and 5. Turns on at 50C
M106 P2 C"Cooling"             ; manual control of layer cooling fans

;crash detection
M950 J1 C"1.io4.in" ;define pin for crash detection
M581 T2 P1 S1 R0    ;triggers any time (printing or jogging), runs "trigger2.g"
M669 S100 T0.1      ;break up movements into smaller bits - this is necessary for the machine to be able to pause if a crash is detected

M302 S150 ; Set minimum extrude temp

;turn off spindles
M453 ;
M3 P0 S0;
M3 P1 S0;