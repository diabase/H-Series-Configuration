; machinespecific.g
; Configuration parameters specific to this individual H-Series machine.
; Produced by Diabase H-Series Configurizer
; Written by Diabase Engineering
; Last Updated: July 6, 2021

if !exists(global.MachineName)
    global MachineName = "H5006" ; Machine name for web interface and local network discovery.
else
    set global.MachineName = "H5006"

if !exists(global.UMin)
    global UMin = -10 ; Physical u-axis position when USwitchPin triggers.
else
    set global.UMin = -10

if !exists(global.CSType)
    global CSType = "Motor" ; Cleaning station type. Options are "None", "Solenoid", or "Motor"
else
    set global.CSType = "Motor"

if !exists(global.WCleanPosition)
    global WCleanPosition = 22 ; W-axis position for forming filament button during priming cycle.
else
    set global.WCleanPosition = 22

if !exists(global.LogFileName)
    global LogFileName = "eventlog.txt"
else
    set global.LogFileName = "eventlog.txt"

if !exists(global.LogLevel)
    global LogLevel = 0 ; Verbosity for logging to eventlog.txt. (Options: "0" for Off, "1" for Warnings, "2" for Information, and "3" for Debug)
else
    set global.LogLevel = 0

if !exists(global.XSwitchPin)
    global XSwitchPin = "io2.in"
else
    set global.XSwitchPin = "io2.in"

if !exists(global.YSwitchPin)
    global YSwitchPin = "io3.in"
else
    set global.YSwitchPin = "io3.in"

if !exists(global.ZSwitchPin)
    global ZSwitchPin = "io4.in"
else
    set global.ZSwitchPin = "io4.in"

if !exists(global.USwitchPin)
    global USwitchPin = "1.io1.in"
else
    set global.USwitchPin = "1.io1.in"

if !exists(global.VSwitchPin)
    global VSwitchPin = "1.io2.in"
else
    set global.VSwitchPin = "1.io2.in"

; if !exists(global.WSwitchPin)
;     global WSwitchPin = ""
; else
;     set global.WSwitchPin = ""

if !exists(global.ASwitchPin)
    global ASwitchPin = "3.io1.in"
else
    set global.ASwitchPin = "3.io1.in"

if !exists(global.CSwitchPin)
    global CSwitchPin = "3.io2.in"
else
    set global.CSwitchPin = "3.io2.in"

if !exists(global.XDrive)
    global XDrive = 0
else
    set global.XDrive = 0

if !exists(global.YDrive)
    global YDrive = 1
else
    set global.YDrive = 1

if !exists(global.ZDrive)
    global ZDrive = 2
else
    set global.ZDrive = 2

if !exists(global.UDrive)
    global UDrive = 3
else
    set global.UDrive = 3

if !exists(global.VDrive)
    global VDrive = 4
else
    set global.VDrive = 4

if !exists(global.WDrive)
    global WDrive = 5
else
    set global.WDrive = 5

if !exists(global.ADrive)
    global ADrive = 3.0
else
    set global.ADrive = 3.0

if !exists(global.APrimeDrive)
    global APrimeDrive = 3.1
else
    set global.APrimeDrive = 3.1

if !exists(global.CDrive)
    global CDrive = 3.2
else
    set global.CDrive = 3.2

if !exists(global.E1Drive)
    global E1Drive = 1.0
else
    set global.E1Drive = 1.0

; if !exists(global.E2Drive)
;     global E2Drive = 
; else
;     set global.E2Drive = 

if !exists(global.E3Drive)
    global E3Drive = 1.1
else
    set global.E3Drive = 1.1

; if !exists(global.E4Drive)
;     global E4Drive = 
; else
;     set global.E4Drive = 

if !exists(global.E5Drive)
    global E5Drive = 1.2
else
    set global.E5Drive = 1.2

if !exists(global.FA1Drive)
    global FA1Drive = 3.0
else
    set global.FA1Drive = 3.0

; if !exists(global.FA2Drive)
;     global FA2Drive = 
; else
;     set global.FA2Drive = 

if !exists(global.FA3Drive)
    global FA3Drive = 3.1
else
    set global.FA3Drive = 3.1

; if !exists(global.FA4Drive)
;     global FA4Drive = 
; else
;     set global.FA4Drive = 

if !exists(global.FA5Drive)
    global FA5Drive = 3.5
else
    set global.FA5Drive = 3.5

if !exists(global.XDirection)
    global XDirection = 0
else
    set global.XDirection = 0

if !exists(global.YDirection)
    global YDirection = 0
else
    set global.YDirection = 0

if !exists(global.ZDirection)
    global ZDirection = 0
else
    set global.ZDirection = 0

if !exists(global.UDirection)
    global UDirection = 0
else
    set global.UDirection = 0

if !exists(global.VDirection)
    global VDirection = 1
else
    set global.VDirection = 1

if !exists(global.WDirection)
    global WDirection = 0
else
    set global.WDirection = 0

if !exists(global.ADirection)
    global ADirection = 1
else
    set global.ADirection = 1

if !exists(global.APrimeDirection)
    global APrimeDirection = 0
else
    set global.APrimeDirection = 0

if !exists(global.CDirection)
    global CDirection = 1
else
    set global.CDirection = 1

if !exists(global.E1Direction)
    global E1Direction = 0
else
    set global.E1Direction = 0

if !exists(global.E2Direction)
    global E2Direction = 0
else
    set global.E2Direction = 0

if !exists(global.E3Direction)
    global E3Direction = 0
else
    set global.E3Direction = 0

if !exists(global.E4Direction)
    global E4Direction = 0
else
    set global.E4Direction = 0

if !exists(global.E5Direction)
    global E5Direction = 0
else
    set global.E5Direction = 0

if !exists(global.FA1Direction)
    global FA1Direction = 0
else
    set global.FA1Direction = 0

if !exists(global.FA2Direction)
    global FA2Direction = 0
else
    set global.FA2Direction = 0

if !exists(global.FA3Direction)
    global FA3Direction = 0
else
    set global.FA3Direction = 0

if !exists(global.FA4Direction)
    global FA4Direction = 0
else
    set global.FA4Direction = 0

if !exists(global.FA5Direction)
    global FA5Direction = 0
else
    set global.FA5Direction = 0

if !exists(global.CSPinchPin)
    global CSPinchPin = "out1"
else
    set global.CSPinchPin = "out1"

if !exists(global.ZBrakePin)
    global ZBrakePin = "out2"
else
    set global.ZBrakePin = "out2"

if !exists(global.BELedPin)
    global BELedPin = "out3"
else
    set global.BELedPin = "out3"

if !exists(global.FCLedPin)
    global FCLedPin = "3.out4"
else
    set global.FCLedPin = "3.out4"

if !exists(global.FffFanPin)
    global FffFanPin = "1.out7"
else
    set global.FffFanPin = "1.out7"

if !exists(global.ToolFanPin)
    global ToolFanPin = "1.out8"
else
    set global.ToolFanPin = "1.out8"

; if !exists(global.Spindle1SpeedPin)
;     global Spindle1SpeedPin = ""
; else
;     set global.Spindle1SpeedPin = ""

if !exists(global.Spindle2SpeedPin)
    global Spindle2SpeedPin = "io5.out"
else
    set global.Spindle2SpeedPin = "io5.out"

; if !exists(global.Spindle3SpeedPin)
;     global Spindle3SpeedPin = ""
; else
;     set global.Spindle3SpeedPin = ""

if !exists(global.Spindle4SpeedPin)
    global Spindle4SpeedPin = "io7.out"
else
    set global.Spindle4SpeedPin = "io7.out"

; if !exists(global.Spindle5SpeedPin)
;     global Spindle5SpeedPin = ""
; else
;     set global.Spindle5SpeedPin = ""

; if !exists(global.Spindle1DirectionPin)
;     global Spindle1DirectionPin = ""
; else
;     set global.Spindle1DirectionPin = ""

if !exists(global.Spindle2DirectionPin)
    global Spindle2DirectionPin = "io6.out"
else
    set global.Spindle2DirectionPin = "io6.out"

; if !exists(global.Spindle3DirectionPin)
;     global Spindle3DirectionPin = ""
; else
;     set global.Spindle3DirectionPin = ""

if !exists(global.Spindle4DirectionPin)
    global Spindle4DirectionPin = "io8.out"
else
    set global.Spindle4DirectionPin = "io8.out"

; if !exists(global.Spindle5DirectionPin)
;     global Spindle5DirectionPin = ""
; else
;     set global.Spindle5DirectionPin = ""

; if !exists(global.Spindle1AirPin)
;     global Spindle1AirPin = ""
; else
;     set global.Spindle1AirPin = ""

if !exists(global.Spindle2AirPin)
    global Spindle2AirPin = "out5"
else
    set global.Spindle2AirPin = "out5"

; if !exists(global.Spindle3AirPin)
;     global Spindle3AirPin = ""
; else
;     set global.Spindle3AirPin = ""

if !exists(global.Spindle4AirPin)
    global Spindle4AirPin = "out6"
else
    set global.Spindle4AirPin = "out6"

; if !exists(global.Spindle5AirPin)
;     global Spindle5AirPin = ""
; else
;     set global.Spindle5AirPin = ""

if !exists(global.MaxOffset)
    global MaxOffset = 0
else
    set global.MaxOffset = 0

if !exists(global.DiameterProbeHole)
    global DiameterProbeHole = 0
else
    set global.DiameterProbeHole = 0

if !exists(global.BedHeatPin)
    global BedHeatPin = "out7"
else
    set global.BedHeatPin = "out7"

if !exists(global.BEDoorPin)
    global BEDoorPin = "io1.in"
else
    set global.BEDoorPin = "io1.in"

if !exists(global.EHeat1Pin)
    global EHeat1Pin = "1.out0"
else
    set global.EHeat1Pin = "1.out0"

; if !exists(global.EHeat2Pin)
;     global EHeat2Pin = ""
; else
;     set global.EHeat2Pin = ""

if !exists(global.EHeat3Pin)
    global EHeat3Pin = "1.out2"
else
    set global.EHeat3Pin = "1.out2"

; if !exists(global.EHeat4Pin)
;     global EHeat4Pin = ""
; else
;     set global.EHeat4Pin = ""

if !exists(global.EHeat5Pin)
    global EHeat5Pin = "1.out5"
else
    set global.EHeat5Pin = "1.out5"

if !exists(global.ProbeRetractPin)
    global ProbeRetractPin = "1.out3"
else
    set global.ProbeRetractPin = "1.out3"

if !exists(global.ProbePin)
    global ProbePin = "1.io1.in"
else
    set global.ProbePin = "1.io1.in"

if !exists(global.TouchOffPlatePin)
    global TouchOffPlatePin = "1.io3.in"
else
    set global.TouchOffPlatePin = "1.io3.in"

if !exists(global.ExtruderCrashDetectPin)
    global ExtruderCrashDetectPin = "1.io4.in"
else
    set global.ExtruderCrashDetectPin = "1.io4.in"

if !exists(global.DhtPin)
    global DhtPin = "3.io1.in"
else
    set global.DhtPin = "3.io1.in"

if !exists(global.FSense1Pin)
    global FSense1Pin = "3.io2.in"
else
    set global.FSense1Pin = "3.io2.in"

; if !exists(global.FSense2Pin)
;     global FSense2Pin = ""
; else
;     set global.FSense2Pin = ""

if !exists(global.FSense3Pin)
    global FSense3Pin = "3.io3.in"
else
    set global.FSense3Pin = "3.io3.in"

; if !exists(global.FSense4Pin)
;     global FSense4Pin = ""
; else
;     set global.FSense4Pin = ""

if !exists(global.FSense5Pin)
    global FSense5Pin = "3.io4.in"
else
    set global.FSense5Pin = "3.io4.in"
