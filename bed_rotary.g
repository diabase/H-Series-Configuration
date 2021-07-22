; bed_rotary.g
; H5A Configuration File
; Written by Diabase Engineering
; Last Updated: July 21, 2021

M118 S"Info: Begin bed_rotary.g" L2

M291 P"Edit bed_rotary.g AND USE ROTARY AXES TAB to define mesh area for rotary axis" R"First open" S3

T10                                 ; Select Tool 10 (Probe)
M561                                ; Set Identity Transform (Clears any existing bed-plane fitting)

G1 X0 Y-5 Z3 F8000                  ; Move to starting position
G30                                 ; Probe the bed at the current XY position. When the probe is triggered, set the Z coordinate to the probe trigger height.
M557 X-100:150 Y-360:360 S50:18     ; Define a probing grid bounded for X between -150 and 150 and Y between -360 and 360 with X and Y probe point spacings of 50mm and 40 degrees, respectively
M203 X{global.XMaxSpeed}            ; Set maximum speeds (mm/min)
G29                                 ; Probe the bed using the grid defined by M557, save the height map in /sys/heightmap.csv, and activate bed compensation
M203 X{global.XMaxSpeedRotary}      ; Set maximum speeds (mm/min)

M118 S"Info: End bed_rotary.g" L2
