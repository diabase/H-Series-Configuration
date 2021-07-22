; rotaryprint.g
; Called to switch machine into rotary printing mode
; Written by Diabase Engineering
; Last Updated: July 21, 2021

M118 S"Info: Begin rotaryprint.g" L2

; Drive settings
M584 Y2.0:2.1 R1                                ; Set driver mapping
M584 A2 R0                                      ; Set driver mapping
M208 Y-365 A-93 S1                              ; Set axis minima
M208 Y365 A93 S0                                ; Set axis maxima
M350 Y16 A16  I1                                ; Configure microstepping with interpolation
M92  Y53.33 A320                                ; Set steps per mm
M566 Y1000 A600                                 ; Set maximum instantaneous speed changes (mm/min)
M203 X{global.XMaxSpeedRotary} Y20000 A10000    ; Set maximum speeds (mm/min)
M201 Y1400 A900                                 ; Set accelerations (mm/s^2)
M906 Y2000 A2000 I30                            ; Set motor currents (mA) and motor idle factor in per cent
M84 S5                                          ; Set idle timeout

M574 Y1 P"nil"                                  ; Clear existing Y endstop pin
M574 A1 P"nil"                                  ; Clear existing A endstop pin
G1 P100                                         ; Wait 100ms
M574 A1 S1 P{global.YSwitchPin}                 ; Set new pin for A endstop
M574 Y1 S1 P{global.ASwitchPin}                 ; Set new pin for Y endstop

G92 A0 Y0                                       ; Set curret A and Y positions to 0

M118 S"Info: End rotaryprint.g" L2
