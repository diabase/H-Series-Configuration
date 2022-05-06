; config.g
; H5A Configuration File
; Written by Diabase Engineering
; Last Updated: April 25, 2022
; Customized for H5014 on March 17, 2022

G4 S2 ; Wait for 2 seconds to allow expansion boards time to boot

; Logging
M929 P"eventlog.txt" S3 ; start logging to file eventlog.txt (S0 = stop logging, S1 = log level WARN, S2 = log level INFO, S3 = log level DEBUG)
M118 S"Info: Begin config.g" L2

;Default Parameters
if !{exists(global.defaultParametersLastRun)}
    M98 P"defaultparameters.g"

;Machine-specific settings
M98 P"machinespecific.g"

;Network
M550 P{global.machineName}
M118 S{{global.machineName}} L1
M552 S1 ; Enable network

; General preferences
G90 ; Absolute Positioning
M83 ; Relative Extrusions

; Drive orientation
if {global.machineModel} == "H4" || {global.machineModel} == "H5A"
    if global.e3Drive == -1
        set global.e3Drive = global.e4Drive
        set global.e4Drive = -1
    if global.fA3Drive == -1
        set global.fA3Drive = global.fA4Drive
        set global.fA4Drive = -1
    
    M569 P{global.vDrive} S{global.vDirection}                          ; Set motor driver direction. Line 60/70: V (Turret Lock)
    if {boards[0].firmwareVersion == "3.3"}
        M569 P1.0 S{global.e1Direction}                        ; Set motor driver direction. Line 60/70: E (Extruder)
        M569 P1.1 S{global.e3Direction}                        ; Set motor driver direction. Line 60/70: E (Extruder)
        M569 P1.2 S{global.e5Direction}                        ; Set motor driver direction. Line 60/70: E (Extruder)
        M569 P3.0 S{global.fA1Direction}                      ; Set motor driver direction. Line 60/70: E (Filament Assist)
        M569 P3.1 S{global.fA3Direction}                      ; Set motor driver direction. Line 60/70: E (Filament Assist)
        M569 P3.2 S{global.fA5Direction}                      ; Set motor driver direction. Line 60/70: E (Filament Assist)
        M569 P2.0 S{global.aDirection}                          ; Set motor driver direction. Line 60/70: A (Rotary)
        M569 P2.1 S{global.aPrimeDirection}                ; Set motor driver direction. Line 60/70: A' (Rotary)
        M569 P2.2 S{global.cDirection}                          ; Set motor driver direction. Line 60/70: C (Rotary)

    elif {boards[0].firmwareVersion != "3.3"}
        M569 P{global.e1Drive} S{global.e1Direction}                        ; Set motor driver direction. Line 60/70: E (Extruder)
        M569 P{global.e3Drive} S{global.e3Direction}                        ; Set motor driver direction. Line 60/70: E (Extruder)
        M569 P{global.e5Drive} S{global.e5Direction}                        ; Set motor driver direction. Line 60/70: E (Extruder)
        M569 P{global.fA1Drive} S{global.fA1Direction}                      ; Set motor driver direction. Line 60/70: E (Filament Assist)
        M569 P{global.fA3Drive} S{global.fA3Direction}                      ; Set motor driver direction. Line 60/70: E (Filament Assist)
        M569 P{global.fA5Drive} S{global.fA5Direction}                      ; Set motor driver direction. Line 60/70: E (Filament Assist)
        M569 P{global.aDrive} S{global.aDirection}                          ; Set motor driver direction. Line 60/70: A (Rotary)
        M569 P{global.aPrimeDrive} S{global.aPrimeDirection}                ; Set motor driver direction. Line 60/70: A' (Rotary)
        M569 P{global.cDrive} S{global.cDirection}                          ; Set motor driver direction. Line 60/70: C (Rotary)

elif {global.machineModel} == "H5B"
    if global.e3Drive == -1
        set global.e3Drive = global.e1Drive
        set global.e1Drive = -1
    if global.fA3Drive == -1
        set global.fA3Drive = global.fA1Drive
        set global.fA1Drive = -1
    if {boards[0].firmwareVersion == "3.3"}
        M569 P4.0 S{global.e1Direction}                        ; Set motor driver direction. - RT added on 3/17/2022 for H5014 customization
        M569 P4.1 S{global.fA1Direction}                       ; Set motor driver direction. - RT added on 3/17/2022 for H5014 customization
        M569 P1.1 S{global.e4Direction}                        ; Set motor driver direction. Line 60/70: E (Extruder)
        M569 P3.1 S{global.fA4Direction}                      ; Set motor driver direction. Line 60/70: E (Filament Assist)
        M569 P4 S{global.bDirection}                          ; Set motor driver direction. Line 60/70: B (Toolchanger)
        M569 P1.0 S{global.e3Direction}                        ; Set motor driver direction. Line 60/70: E (Extruder)
        M569 P1.2 S{global.e5Direction}                        ; Set motor driver direction. Line 60/70: E (Extruder)
        M569 P3.0 S{global.fA3Direction}                      ; Set motor driver direction. Line 60/70: E (Filament Assist)
        M569 P3.2 S{global.fA5Direction}                      ; Set motor driver direction. Line 60/70: E (Filament Assist)
        M569 P2.0 S{global.aDirection}                          ; Set motor driver direction. Line 60/70: A (Rotary)
        M569 P2.1 S{global.aPrimeDirection}                ; Set motor driver direction. Line 60/70: A' (Rotary)
        M569 P2.2 S{global.cDirection}                          ; Set motor driver direction. Line 60/70: C (Rotary)
    elif {boards[0].firmwareVersion != "3.3"}
        M569 P{global.e1Drive} S{global.e1Direction}                        ; Set motor driver direction. - RT added on 3/17/2022 for H5014 customization
        M569 P{global.fA1Drive} S{global.fA1Direction}                       ; Set motor driver direction. - RT added on 3/17/2022 for H5014 customization
        M569 P{global.e4Drive} S{global.e4Direction}                        ; Set motor driver direction. Line 60/70: E (Extruder)
        M569 P{global.fA4Drive} S{global.fA4Direction}                      ; Set motor driver direction. Line 60/70: E (Filament Assist)
        M569 P{global.bDrive} S{global.bDirection}                          ; Set motor driver direction. Line 60/70: B (Toolchanger)
        M569 P{global.e3Drive} S{global.e3Direction}                        ; Set motor driver direction. Line 60/70: E (Extruder)
        M569 P{global.e5Drive} S{global.e5Direction}                        ; Set motor driver direction. Line 60/70: E (Extruder)
        M569 P{global.fA3Drive} S{global.fA3Direction}                      ; Set motor driver direction. Line 60/70: E (Filament Assist)
        M569 P{global.fA5Drive} S{global.fA5Direction}                      ; Set motor driver direction. Line 60/70: E (Filament Assist)
        M569 P{global.aDrive} S{global.aDirection}                          ; Set motor driver direction. Line 60/70: A (Rotary)
        M569 P{global.aPrimeDrive} S{global.aPrimeDirection}                ; Set motor driver direction. Line 60/70: A' (Rotary)
        M569 P{global.cDrive} S{global.cDirection}                          ; Set motor driver direction. Line 60/70: C (Rotary)
M569 P{global.xDrive} S{global.xDirection}                          ; Set motor driver direction. Line 60/70: X (Linear)
M569 P{global.yDrive} S{global.yDirection}                          ; Set motor driver direction. Line 60/70: Y (Linear)
M569 P{global.zDrive} S{global.zDirection}                          ; Set motor driver direction. Line 60/70: Z (Linear)
M569 P{global.uDrive} S{global.uDirection}                          ; Set motor driver direction. Line 60/70: U (Turret)
M569 P{global.wDrive} S{global.wDirection}                          ; Set motor driver direction. Line 60/70: W (Cleaing Station)

; Drive settings
if {global.machineModel} == "H4" || {global.machineModel} == "H5A"
    if {boards[0].firmwareVersion == "3.3"}
        M118 S{"Setting motor drivers on lines "^{line+1}^" and "^{line+2}} L3
        M584 X{global.xDrive} Y{global.yDrive} Z{global.zDrive} U{global.uDrive} V{global.vDrive} W{global.wDrive} A2.0:2.1 C2.2 ; Map stepper drivers for motion
        M584 E1.0:1.1:1.2:3.0:3.1:3.2 ; Map stepper drivers for extruders
    elif {boards[0].firmwareVersion != "3.3"}
        M118 S{"Setting motor drivers on lines "^{line+1}^" and "^{line+2}} L3
        M584 X{global.xDrive} Y{global.yDrive} Z{global.zDrive} U{global.uDrive} V{global.vDrive} W{global.wDrive} A{global.aDrive}:{global.aPrimeDrive} C{global.cDrive} ; Map stepper drivers for motion
        M584 E{global.e1Drive}:{global.e3Drive}:{global.e5Drive}:{global.fA1Drive}:{global.fA3Drive}:{global.fA5Drive} ; Map stepper drivers for extruders
    M208 X{global.xMin} Y{global.yMin} Z{global.zMin} U{global.uMin} V{global.vMin} W{global.wMin} A{global.aMin} C{global.cMin} S1 ; Set axis minima
    M208 X{global.xMax} Y{global.yMax} Z{global.zMax} U{global.uMax} V{global.vMax} W{global.wMax} A{global.aMax} C{global.cMax} S0 ; Set axis maxima
    M350 X16 Y16 Z16 U16 V16 W16 A16 C16 E16 I1 ; Configure microstepping with interpolation - high lead cleaning station motor
    M92 X320 Y320 Z320 U230.22 V1600 W400 A53.33 C53.33 E96 ; Set steps per mm
    M566 X300 Y300 Z300 U120 V500 W200 A1000 C1000 E1200 ; Set maximum instantaneous speed changes (mm/min)
    M203 X10000 Y10000 Z3000 U8000 V10000 W13000 A20000 C20000 E6000 ; Set maximum speeds (mm/min)
    M201 X600 Y600 Z450 U600 V500 W5000 A600 C600 E250 ; Set accelerations (mm/s^2)
    ;M906 X1800 Y2100 Z2400 U1440 V1000 W1000 A1600 C1600 E1500:1500:1500:1000:1000:1000 I30 ; Set motor currents (mA) and motor idle factor percent ; RT removed on 3/17/2022 for H5014 customization
    M906 X1800 Y2100 Z2400 U1440 V1000 W1000 A1600 C1600 E1500:1500:1500:1500:1000:1000:1000:1000 I30 ; Set motor currents (mA) and motor idle factor percent ; RT added on 3/17/2022 for H5014 customization
elif {global.machineModel} == "H5B"
    if {boards[0].firmwareVersion == "3.3"}
        M118 S{"Setting motor drivers on lines "^{line+1}^" and "^{line+2}} L3
        M584 X{global.xDrive} Y{global.yDrive} Z{global.zDrive} U{global.uDrive} W{global.wDrive} A2.0:2.1 B{global.bDrive} C2.2 ; Map stepper drivers for motion
        ; M584 E1.0:1.1:1.2:3.0:3.1:3.2 ; Map stepper drivers for extruders ; RT removed on 3/17/2022 for H5014 customization
        M584 E4.0:1.0:1.1:1.2:4.1:3.0:3.1:3.2 ; Map stepper drivers for extruders - RT added on 3/17/2022 for H5014 customization
    elif {boards[0].firmwareVersion != "3.3"}
        M118 S{"Setting motor drivers on lines "^{line+1}^" and "^{line+2}} L3
        M584 X{global.xDrive} Y{global.yDrive} Z{global.zDrive} U{global.uDrive} W{global.wDrive} A{global.aDrive,global.aPrimeDrive} B{global.bDrive} C{global.cDrive} ; Map stepper drivers for motion
        ;M584 E{global.e3Drive,global.e4Drive,global.e5Drive,global.fA3Drive,global.fA4Drive,global.fA5Drive} ; RT removed on 3/17/2022 for H5014 customization
        M584 E{global.e1Drive,global.e3Drive,global.e4Drive,global.e5Drive,global.fA1Drive,global.fA3Drive,global.fA4Drive,global.fA5Drive} ; RT added on 3/17/2022 for H5014 customization
    M208 X{global.xMin} Y{global.yMin} Z{global.zMin} U{global.uMin} W{global.wMin} A{global.aMin} B{global.bMin} C{global.cMin} S1 ; Set axis minima
    M208 X{global.xMax} Y{global.yMax} Z{global.zMax} U{global.uMax} W{global.wMax} B{global.bMax} A{global.aMax} C{global.cMax} S0 ; Set axis maxima
    M350 X16 Y16 Z16 U16 W16 A16 B16 C16 E16 I1 ; Configure microstepping with interpolation - high lead cleaning station motor
    M92 X320 Y320 Z320 U230.22 W400 A53.33 B80 C53.33 E96 ; Set steps per mm
    M566 X300 Y300 Z500 U120 W200 A1000 B400 C1000 E1200 ; Set maximum instantaneous speed changes (mm/min)
    M203 X10000 Y10000 Z7000 U8000 W13000 A20000 B30000 C20000 E6000 ; Set maximum speeds (mm/min)
    M201 X600 Y600 Z1000 U600 W5000 A600 B2000 C600 E250 ; Set accelerations (mm/s^2)
    ; M906 X1800 Y2100 Z3000 U1750 W1000 A1600 B1500 C1600 E1500:1500:1500:1000:1000:1000 I70 ; Set motor currents (mA) and motor idle factor percent ; RT removed on 3/17/2022 for H5014 customization
    M906 X1800 Y2100 Z3000 U1750 W1000 A1600 B1500 C1600 E1500:1500:1500:1500:1000:1000:1000:1000 I70 ; Set motor currents (mA) and motor idle factor percent ; RT added on 3/17/2022 for H5014 customization

M84 S5 ; Allow all motors to drop hold current to idle after 5 seconds

; Endstops
M574 X1 S1 P{global.xSwitchPin}
M574 Y1 S1 P{global.ySwitchPin}
M574 Z2 S1 P{global.zSwitchPin}
M574 U1 S1 P{global.uSwitchPin}
M574 A1 S1 P{global.aSwitchPin}
M574 C1 S1 P{global.cSwitchPin}
if {global.machineModel} == "H4" || {global.machineModel} == "H5A"
    M574 V2 S1 P{global.vSwitchPin}
if {global.machineModel} == "H5B"
    M574 B1 S1 P{global.bSwitchPin}

; Probes
M558 K0 P8 C{global.zProbePin} H2 F150 T10000           ; Set Z probe type for Probe 0 (Turret Probe). 2mm dive height, 150mm/min probing speed, and 10000 mm/min travel speed between probe points
G31 K0 Z0                                               ; Set Probe 0 trigger height to 0mm
M558 K1 P8 C{global.touchOffPlatePin} I0 F200 T10000 ; Set Z probe type for Probe 1 (touchoff plate). It's on the pin designated in machinespecific.g, 200mm/min probing speed, and 10000 mm/min travel speed between probe points
if {global.machineModel} == "H5B"
    M558 K2 P8 C{global.tCTouchOffPin} I0 F200 T10000 ; Set Z probe type for Probe 2 (Tool Changer Touch Off). It's on the pin designated in machinespecific.g, 200mm/min probing speed, and 10000 mm/min travel speed between probe points

; Tools
M98 P"heatedbed.g" ; Configure heated bed
M98 P"tcreate-universal.g"  ; Create Tools, Fans, GPIO
M98 P"cleaningstation.g" ; Configure cleaning station
M98 P"toolpriming.g" ; Configure tool priming parameters
M98 P"drycabinet.g" ; Configure filament drying cabinet
M911 S19 R22 P"M98 P""estop.g"""  ; Run estop.g on power loss during a print
M575 P1 B115200 S1; Set up UART for pendant input

; Post Config.g Commands
M501 ; Set active parameters to those stored in config-override.g
M98 P"maxoffset.g"     ;set maxoffset to maximum tool length

;Machine-specific settings
M98 P"machinespecific.g"

if {global.machineModel} == "H5B"
        if sensors.gpIn[{global.airPressureInNum}].value == 0
            M291 P"Warning: Incoming air pressure low. Resolve before continuing." R"Warning" S3            ; Display a blocking warning with no timeout.

set global.configLastRun = state.upTime

M98 P"0:/sys/sys-macros/loadedtoolrecovery.g"

M118 S"Info: End config.g" L2
