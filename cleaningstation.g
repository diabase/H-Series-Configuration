; cleaningstation.g
; Configure H4 Cleaning Station
; Written by Diabase Engineering
; Last Updated: February 19, 2021

; Configure Cleaning Station Solenoids
;M950 P0 C"fan0" ; Cleaning Station, Station Extension Solenoid (if equipped) - Define GPIO Pin 0 to use pin "fan0"
M950 P1 C"out1" ; Cleaning Station, Pliers-Closing Solenoid - Define GPIO Pin 1 to use pin "fan2"

; Configure Optional Cleaning Station Vacuum
;M950 F8 C"duex.fan8" ; Cleaning Station Vacuum - Define Fan 8 to use pin duex.fan8
;M106 P8 S0 B0 L1 C"Vacuum" ; I/O Pin for Cleaning Station Vacuum Relay - Configure Fan 8: Speed 0, Blip Time 0, Minimum Fan Speed 1, and call it "Vacuum"
