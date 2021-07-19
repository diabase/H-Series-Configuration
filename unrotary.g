; unrotary.g
; Called to return machine to normal mode from rotary printing mode
; Written by Diabase Engineering
; Last Updated: July 19, 2021

M118 S"Info: Begin unrotary.g" L2

; Drive settings
M584 A2.0:2.1 R1                        ; Set driver mapping
M584 Y2 R0                              ; Set driver mapping
M208 Y{global.YMin} A{global.AMin} S1   ; Set axis minima
M208 Y{global.YMax} A{global.AMax} S0   ; Set axis maxima
M350 Y16 A16 I1                         ; Configure microstepping with interpolation
M92 Y320 A53.33                         ; Set steps per mm - U axis 200steps/rev, 16 steps/step microstepping, 360mm/rev, 5.18 motor gear ration, 5 drive gear ratio
M566 Y300 A1000                         ; Set maximum instantaneous speed changes (mm/min)
M203 Y10000 A20000                      ; Set maximum speeds (mm/min)
M201 Y600 A600                          ; Set accelerations (mm/s^2)
M906 Y2100 A1800 I30                    ; Set motor currents (mA) and motor idle factor in per cent
M84 S5                                  ; Set idle timeout

; Endstops
M574 Y1 p"nil"                          ; Clear existing Y endstop pin
M574 A1 p"nil"                          ; Clear existing A endstop pin
G4 P100                                 ; Wait 100ms
M574 Y1 S1 P{global.YSwitchPin}         ; Set new pin for A endstop
M574 A1 S1 P{global.ASwitchPin}         ; Set new pin for Y endstop

M118 S"Info: End unrotary.g" L2
