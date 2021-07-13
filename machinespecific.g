; machinespecific.g
; Configuration parameters specific to this individual H-Series machine.
; Produced by Diabase H-Series Configurizer
; Written by Diabase Engineering
; Last Updated: July 12, 2021
M118 S"Begin machinespecific.g" L2

if !{exists(global.MachineName)}
    global MachineName = "H5006" ; Machine name for web interface and local network discovery.
else
    set global.MachineName = "H5006"

if !{exists(global.MachineModel)}
    global MachineModel = "H5" ; Machine model number
else
    set global.MachineModel = "H5"

if !{exists(global.UMin)}
    global UMin = -10 ; Physical u-axis position when USwitchPin triggers.
else
    set global.UMin = -10

if !{exists(global.CSType)}
    global CSType = "Motor" ; Cleaning station type. Options are "None", "Solenoid", or "Motor"
else
    set global.CSType = "Motor"

if !{exists(global.WCleanPosition)}
    global WCleanPosition = 22 ; W-axis position for forming filament button during priming cycle.
else
    set global.WCleanPosition = 22

if !{exists(global.LogFileName)}
    global LogFileName = "eventlog.txt"
else
    set global.LogFileName = "eventlog.txt"

if !{exists(global.LogLevel)}
    global LogLevel = 0 ; Verbosity for logging to eventlog.txt. (Options: "0" for Off, "1" for Warnings, "2" for Information, and "3" for Debug)
else
    set global.LogLevel = 0

if !{exists(global.XSwitchPin)}
    global XSwitchPin = "io2.in"
else
    set global.XSwitchPin = "io2.in"

if !{exists(global.YSwitchPin)}
    global YSwitchPin = "io3.in"
else
    set global.YSwitchPin = "io3.in"

if !{exists(global.ZSwitchPin)}
    global ZSwitchPin = "io4.in"
else
    set global.ZSwitchPin = "io4.in"

if !{exists(global.USwitchPin)}
    global USwitchPin = "1.io1.in"
else
    set global.USwitchPin = "1.io1.in"

if !{exists(global.VSwitchPin)}
    global VSwitchPin = "1.io2.in"
else
    set global.VSwitchPin = "1.io2.in"

; if !{exists(global.WSwitchPin)}
;     global WSwitchPin = ""
; else
;     set global.WSwitchPin = ""

if !{exists(global.ASwitchPin)}
    global ASwitchPin = "2.io1.in"
else
    set global.ASwitchPin = "2.io1.in"

if !{exists(global.CSwitchPin)}
    global CSwitchPin = "2.io2.in"
else
    set global.CSwitchPin = "2.io2.in"

if !{exists(global.XDrive)}
    global XDrive = 0
else
    set global.XDrive = 0

if !{exists(global.YDrive)}
    global YDrive = 1
else
    set global.YDrive = 1

if !{exists(global.ZDrive)}
    global ZDrive = 2
else
    set global.ZDrive = 2

if !{exists(global.UDrive)}
    global UDrive = 3
else
    set global.UDrive = 3

if !{exists(global.VDrive)}
    global VDrive = 4
else
    set global.VDrive = 4

if !{exists(global.WDrive)}
    global WDrive = 5
else
    set global.WDrive = 5

if !{exists(global.ADrive)}
    global ADrive = 2.0
else
    set global.ADrive = 2.0

if !{exists(global.APrimeDrive)}
    global APrimeDrive = 2.1
else
    set global.APrimeDrive = 2.1

if !{exists(global.CDrive)}
    global CDrive = 2.2
else
    set global.CDrive = 2.2

if !{exists(global.E1Drive)}
    global E1Drive = 1.0
else
    set global.E1Drive = 1.0

; if !{exists(global.E2Drive)}
;     global E2Drive = 
; else
;     set global.E2Drive = 

if !{exists(global.E3Drive)}
    global E3Drive = 1.1
else
    set global.E3Drive = 1.1

; if !{exists(global.E4Drive)}
;     global E4Drive = 
; else
;     set global.E4Drive = 

if !{exists(global.E5Drive)}
    global E5Drive = 1.2
else
    set global.E5Drive = 1.2

if !{exists(global.FA1Drive)}
    global FA1Drive = 3.0
else
    set global.FA1Drive = 3.0

; if !{exists(global.FA2Drive)}
;     global FA2Drive = 
; else
;     set global.FA2Drive = 

if !{exists(global.FA3Drive)}
    global FA3Drive = 3.1
else
    set global.FA3Drive = 3.1

; if !{exists(global.FA4Drive)}
;     global FA4Drive = 
; else
;     set global.FA4Drive = 

if !{exists(global.FA5Drive)}
    global FA5Drive = 3.2
else
    set global.FA5Drive = 3.2

if !{exists(global.XDirection)}
    global XDirection = 0
else
    set global.XDirection = 0

if !{exists(global.YDirection)}
    global YDirection = 0
else
    set global.YDirection = 0

if !{exists(global.ZDirection)}
    global ZDirection = 0
else
    set global.ZDirection = 0

if !{exists(global.UDirection)}
    global UDirection = 0
else
    set global.UDirection = 0

if !{exists(global.VDirection)}
    global VDirection = 1
else
    set global.VDirection = 1

if !{exists(global.WDirection)}
    global WDirection = 0
else
    set global.WDirection = 0

if !{exists(global.ADirection)}
    global ADirection = 1
else
    set global.ADirection = 1

if !{exists(global.APrimeDirection)}
    global APrimeDirection = 0
else
    set global.APrimeDirection = 0

if !{exists(global.CDirection)}
    global CDirection = 1
else
    set global.CDirection = 1

if !{exists(global.E1Direction)}
    global E1Direction = 0
else
    set global.E1Direction = 0

; if !{exists(global.E2Direction)}
;     global E2Direction = 
; else
;     set global.E2Direction = 

if !{exists(global.E3Direction)}
    global E3Direction = 0
else
    set global.E3Direction = 0

; if !{exists(global.E4Direction)}
;     global E4Direction = 
; else
;     set global.E4Direction = 

if !{exists(global.E5Direction)}
    global E5Direction = 0
else
    set global.E5Direction = 0

if !{exists(global.FA1Direction)}
    global FA1Direction = 0
else
    set global.FA1Direction = 0

; if !{exists(global.FA2Direction)}
;     global FA2Direction = 
; else
;     set global.FA2Direction = 

if !{exists(global.FA3Direction)}
    global FA3Direction = 0
else
    set global.FA3Direction = 0

; if !{exists(global.FA4Direction)}
;     global FA4Direction = 
; else
;     set global.FA4Direction = 

if !{exists(global.FA5Direction)}
    global FA5Direction = 0
else
    set global.FA5Direction = 0

if !{exists(global.CSPinchPin)}
    global CSPinchPin = "out1"
else
    set global.CSPinchPin = "out1"

if !{exists(global.ZBrakePin)}
    global ZBrakePin = "!out2"
else
    set global.ZBrakePin = "!out2"

if !{exists(global.BELedPin)}
    global BELedPin = "3.out4"
else
    set global.BELedPin = "3.out4"

if !{exists(global.FCLedPin)}
    global FCLedPin = "3.out5"
else
    set global.FCLedPin = "3.out5"

if !{exists(global.FffFanPin)}
    global FffFanPin = "1.out7"
else
    set global.FffFanPin = "1.out7"

if !{exists(global.LayerFanPin)}
    global LayerFanPin = "1.out8"
else
    set global.LayerFanPin = "1.out8"

; if !{exists(global.Spindle1SpeedPin)}
;     global Spindle1SpeedPin = ""
; else
;     set global.Spindle1SpeedPin = ""

if !{exists(global.Spindle2SpeedPin)}
    global Spindle2SpeedPin = "io5.out"
else
    set global.Spindle2SpeedPin = "io5.out"

; if !{exists(global.Spindle3SpeedPin)}
;     global Spindle3SpeedPin = ""
; else
;     set global.Spindle3SpeedPin = ""

if !{exists(global.Spindle4SpeedPin)}
    global Spindle4SpeedPin = "io7.out"
else
    set global.Spindle4SpeedPin = "io7.out"

; if !{exists(global.Spindle5SpeedPin)}
;     global Spindle5SpeedPin = ""
; else
;     set global.Spindle5SpeedPin = ""

; if !{exists(global.Spindle1DirectionPin)}
;     global Spindle1DirectionPin = ""
; else
;     set global.Spindle1DirectionPin = ""

if !{exists(global.Spindle2DirectionPin)}
    global Spindle2DirectionPin = "!io6.out"
else
    set global.Spindle2DirectionPin = "!io6.out"

; if !{exists(global.Spindle3DirectionPin)}
;     global Spindle3DirectionPin = ""
; else
;     set global.Spindle3DirectionPin = ""

if !{exists(global.Spindle4DirectionPin)}
    global Spindle4DirectionPin = "!io8.out"
else
    set global.Spindle4DirectionPin = "!io8.out"

; if !{exists(global.Spindle5DirectionPin)}
;     global Spindle5DirectionPin = ""
; else
;     set global.Spindle5DirectionPin = ""

; if !{exists(global.Spindle1AirPin)}
;     global Spindle1AirPin = ""
; else
;     set global.Spindle1AirPin = ""

if !{exists(global.Spindle2AirPin)}
    global Spindle2AirPin = "out5"
else
    set global.Spindle2AirPin = "out5"

; if !{exists(global.Spindle3AirPin)}
;     global Spindle3AirPin = ""
; else
;     set global.Spindle3AirPin = ""

if !{exists(global.Spindle4AirPin)}
    global Spindle4AirPin = "out6"
else
    set global.Spindle4AirPin = "out6"

; if !{exists(global.Spindle5AirPin)}
;     global Spindle5AirPin = ""
; else
;     set global.Spindle5AirPin = ""

if !{exists(global.MaxOffset)}
    global MaxOffset = 0
else
    set global.MaxOffset = 0

if !{exists(global.DiameterProbeHole)}
    global DiameterProbeHole = 14
else
    set global.DiameterProbeHole = 14

if !{exists(global.BedHeatPin)}
    global BedHeatPin = "out7"
else
    set global.BedHeatPin = "out7"

if !{exists(global.BedTempPin)}
    global BedTempPin = "temp0"
else
    set global.BedTempPin = "temp0"

if !{exists(global.BEDoorPin)}
    global BEDoorPin = "io1.in"
else
    set global.BEDoorPin = "io1.in"

if !{exists(global.EHeat1Pin)}
    global EHeat1Pin = "1.out0"
else
    set global.EHeat1Pin = "1.out0"

; if !{exists(global.EHeat2Pin)}
;     global EHeat2Pin = ""
; else
;     set global.EHeat2Pin = ""

if !{exists(global.EHeat3Pin)}
    global EHeat3Pin = "1.out1"
else
    set global.EHeat3Pin = "1.out1"

; if !{exists(global.EHeat4Pin)}
;     global EHeat4Pin = ""
; else
;     set global.EHeat4Pin = ""

if !{exists(global.EHeat5Pin)}
    global EHeat5Pin = "1.out2"
else
    set global.EHeat5Pin = "1.out2"

if !{exists(global.ProbeRetractPin)}
    global ProbeRetractPin = "1.out3"
else
    set global.ProbeRetractPin = "1.out3"

if !{exists(global.ProbePin)}
    global ProbePin = "1.io0.in"
else
    set global.ProbePin = "1.io0.in"

if !{exists(global.TouchOffPlatePin)}
    global TouchOffPlatePin = "1.io3.in"
else
    set global.TouchOffPlatePin = "1.io3.in"

if !{exists(global.ExtruderCrashDetectPin)}
    global ExtruderCrashDetectPin = "1.io4.in"
else
    set global.ExtruderCrashDetectPin = "1.io4.in"

if !{exists(global.DhtPin)}
    global DhtPin = "0.spi.cs1"
else
    set global.DhtPin = "0.spi.cs1"

if !{exists(global.FSense1Pin)}
    global FSense1Pin = "3.io2.in"
else
    set global.FSense1Pin = "3.io2.in"

; if !{exists(global.FSense2Pin)}
;     global FSense2Pin = ""
; else
;     set global.FSense2Pin = ""

if !{exists(global.FSense3Pin)}
    global FSense3Pin = "3.io3.in"
else
    set global.FSense3Pin = "3.io3.in"

; if !{exists(global.FSense4Pin)}
;     global FSense4Pin = ""
; else
;     set global.FSense4Pin = ""

if !{exists(global.FSense5Pin)}
    global FSense5Pin = "3.io4.in"
else
    set global.FSense5Pin = "3.io4.in"

if !{exists(global.EStopSwitchPin)}
    global EStopSwitchPin = "1.io5.in"
else
    set global.EStopSwitchPin = "1.io5.in"

if !{exists(global.ToolType1)}
    global ToolType1 = "Extruder"
else
    set global.ToolType1 = "Extruder"

if !{exists(global.ToolType2)}
    global ToolType2 = "Spindle"
else
    set global.ToolType2 = "Spindle"

if !{exists(global.ToolType3)}
    global ToolType3 = "Extruder"
else
    set global.ToolType3 = "Extruder"

if !{exists(global.ToolType4)}
    global ToolType4 = "Spindle"
else
    set global.ToolType4 = "Spindle"

if !{exists(global.ToolType5)}
    global ToolType5 = "Extruder"
else
    set global.ToolType5 = "Extruder"

if !{exists(global.E1TempPin)}
    global E1TempPin = "1.temp0"
else
    set global.E1TempPin = "1.temp0"

; if !{exists(global.E2TempPin)}
;     global E2TempPin = ""
; else
;     set global.E2TempPin = ""

if !{exists(global.E3TempPin)}
    global E3TempPin = "1.temp1"
else
    set global.E3TempPin = "1.temp1"

; if !{exists(global.E4TempPin)}
;     global E4TempPin = ""
; else
;     set global.E4TempPin = ""

if !{exists(global.E5TempPin)}
    global E5TempPin = "1.temp2"
else
    set global.E5TempPin = "1.temp2"

if !{exists(global.FCFanPin)}
    global FCFanPin = "3.out3"
else
    set global.FCFanPin = "3.out3"

if !{exists(global.FCSwitchPin)}
    global FCSwitchPin = "!3.io0.in"
else
    set global.FCSwitchPin = "!3.io0.in"

if !{exists(global.CDOnTrigger)}
    global CDOnTrigger = 2
else
    set global.CDOnTrigger = 2

if !{exists(global.CDOffTrigger)}
    global CDOffTrigger = 3
else
    set global.CDOffTrigger = 3

if !{exists(global.EStopOnTrigger)}
    global EStopOnTrigger = 4
else
    set global.EStopOnTrigger = 4

if !{exists(global.EStopOffTrigger)}
    global EStopOffTrigger = 5
else
    set global.EStopOffTrigger = 5

if !{exists(global.FCSwitchOnTrigger)}
    global FCSwitchOnTrigger = 6
else
    set global.FCSwitchOnTrigger = 6

if !{exists(global.FCSwitchOffTrigger)}
    global FCSwitchOffTrigger = 7
else
    set global.FCSwitchOffTrigger = 7

if !{exists(global.FCRH)}
    global FCRH = -273.15
else
    set global.FCRH = -273.15

if !{exists(global.FCDoorOpenTime)}
    global FCDoorOpenTime = 0
else
    set global.FCDoorOpenTime = 0

if !{exists(global.FCDoorCloseTime)}
    global FCDoorCloseTime = 0
else
    set global.FCDoorCloseTime = 0

M118 S"End machinespecific.g" L2
