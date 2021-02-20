; tcreate-universal.g
; Creates and configures all tools

M98 P"tcreate1.g"
M98 P"tcreate2.g"
M98 P"tcreate3.g"
M98 P"tcreate4.g"
M98 P"tcreate5.g"
M563 P10 S"Probe"

; Configure Extruder Fans
M950 F1 C"fan1"         ; Define Extruder Cooling Fan - Define Fan 1 to use pin fan1
M106 P1 H1:2:3:4:5 T50 ; Configure Extruder Cooling Fan - Configure Fan 1: Turn on when any extruder heaters (heaters 1-5) reach the trigger temperature of 50C

; Configure Layer Fans
M950 F3 C"duex.fan3"    ; Layer Fans - Define Fan 3 to use pin duex.fan3
M106 P3 C"Layer Fan" ; Layer Fans - Configure Fan 3

; Configure Extruder Multiplexer and Spindle Enable
M950 P2 C"duex.gp1" ; Extruder Multiplexer and Spindle Enable - Define GPIO Pin 2 to use pin "duex.gp1"
M950 P3 C"duex.gp2" ; Extruder Multiplexer and Spindle Enable - Define GPIO Pin 3 to use pin "duex.gp2" 
M950 P4 C"duex.gp3" ; Extruder Multiplexer and Spindle Enable - Define GPIO Pin 4 to use pin "duex.gp3" 
M950 P5 C"duex.gp4" ; Extruder Multiplexer and Spindle Enable - Define GPIO Pin 5 to use pin "duex.gp4" 

M302 S150 ; Set minimum extrude temp
