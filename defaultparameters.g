; defaultparameters.g
; Default configuration parameters for H-Series machines
; Produced by Diabase H-Series Configurizer
; Written by Diabase Engineering
; Last Updated: December 13, 2021

M118 S"Begin defaultparameters.g" L2

if !{exists(global.machineName)}
    global machineName = "H5XXX" ; Machine name for web interface and local network discovery.
else
    set global.machineName = "H5XXX"

if !{exists(global.machineModel)}
    global machineModel = "H5A" ; Machine model number
else
    set global.machineModel = "H5A"

if !{exists(global.xMin)}
    global xMin = -208
else
    set global.xMin = -208

if !{exists(global.xMax)}
    global xMax = 208
else
    set global.xMax = 208

if !{exists(global.yMin)}
    global yMin = -90
else
    set global.yMin = -90

if !{exists(global.yMax)}
    global yMax = 90
else
    set global.yMax = 90

if !{exists(global.zMin)}
    global zMin = -10
else
    set global.zMin = -10

if !{exists(global.zMax)}
    global zMax = 410
else
    set global.zMax = 410

if !{exists(global.uMin)}
    global uMin = -10 ; Physical u-axis position when USwitchPin triggers.
else
    set global.uMin = -10

if !{exists(global.uMax)}
    global uMax = 360
else
    set global.uMax = 360

if !{exists(global.vMin)}
    global vMin = -100
else
    set global.vMin = -100

if !{exists(global.vMax)}
    global vMax = 200
else
    set global.vMax = 200

if !{exists(global.wMin)}
    global wMin = 0
else
    set global.wMin = 0

if !{exists(global.wMax)}
    global wMax = 35
else
    set global.wMax = 35

if !{exists(global.aMin)}
    global aMin = -365
else
    set global.aMin = -365

if !{exists(global.aMax)}
    global aMax = 365
else
    set global.aMax = 365

if !{exists(global.bMin)}
    global bMin = -217.5
else
    set global.bMin = -217.5

if !{exists(global.bMax)}
    global bMax = 217.5
else
    set global.bMax = 217.5

if !{exists(global.cMin)}
    global cMin = -1000
else
    set global.cMin = -1000

if !{exists(global.cMax)}
    global cMax = 10000
else
    set global.cMax = 10000

if !{exists(global.cSType)}
    global cSType = "Motor" ; Cleaning station type. Options are "None", "Solenoid", or "Motor"
else
    set global.cSType = "Motor"

if !{exists(global.wPrimeSurface)}
    global wPrimeSurface = 22 ; W-axis position for forming filament button during priming cycle.
else
    set global.wPrimeSurface = 22

if !{exists(global.wClearance)}
    global wClearance = -1
else
    set global.wClearance = -1

if !{exists(global.wClean)}
    global wClean = -1
else
    set global.wClean = -1

if !{exists(global.wGrab)}
    global wGrab = -1
else
    set global.wGrab = -1

if !{exists(global.logFileName)}
    global logFileName = "eventlog.txt"
else
    set global.logFileName = "eventlog.txt"

if !{exists(global.logLevel)}
    global logLevel = 0 ; Verbosity for logging to eventlog.txt. (Options: "0" for Off, "1" for Warnings, "2" for Information, and "3" for Debug)
else
    set global.logLevel = 0

if !{exists(global.xSwitchPin)}
    global xSwitchPin = "io2.in"
else
    set global.xSwitchPin = "io2.in"

if !{exists(global.ySwitchPin)}
    global ySwitchPin = "io3.in"
else
    set global.ySwitchPin = "io3.in"

if !{exists(global.zSwitchPin)}
    global zSwitchPin = "io4.in"
else
    set global.zSwitchPin = "io4.in"

if !{exists(global.uSwitchPin)}
    global uSwitchPin = "1.io1.in"
else
    set global.uSwitchPin = "1.io1.in"

if !{exists(global.vSwitchPin)}
    global vSwitchPin = "1.io2.in"
else
    set global.vSwitchPin = "1.io2.in"

; if !{exists(global.wSwitchPin)}
;     global wSwitchPin = ""
; else
;     set global.wSwitchPin = ""

if !{exists(global.aSwitchPin)}
    global aSwitchPin = "2.io0.in"
else
    set global.aSwitchPin = "2.io0.in"

; if !{exists(global.aPrimeSwitchPin)}
;     global aPrimeSwitchPin = ""
; else
;     set global.aPrimeSwitchPin = ""

if !{exists(global.bSwitchPin)}
    global bSwitchPin = "io8.in"
else
    set global.bSwitchPin = "io8.in"

if !{exists(global.cSwitchPin)}
    global cSwitchPin = "2.io2.in"
else
    set global.cSwitchPin = "2.io2.in"

if !{exists(global.xDrive)}
    global xDrive = 0
else
    set global.xDrive = 0

if !{exists(global.yDrive)}
    global yDrive = 1
else
    set global.yDrive = 1

if !{exists(global.zDrive)}
    global zDrive = 2
else
    set global.zDrive = 2

if !{exists(global.uDrive)}
    global uDrive = 3
else
    set global.uDrive = 3

if !{exists(global.vDrive)}
    global vDrive = 4
else
    set global.vDrive = 4

if !{exists(global.wDrive)}
    global wDrive = 5
else
    set global.wDrive = 5

if !{exists(global.aDrive)}
    global aDrive = 2.0
else
    set global.aDrive = 2.0

if !{exists(global.aPrimeDrive)}
    global aPrimeDrive = 2.1
else
    set global.aPrimeDrive = 2.1

if !{exists(global.bDrive)}
    global bDrive = 4
else
    set global.bDrive = 4

if !{exists(global.cDrive)}
    global cDrive = 2.2
else
    set global.cDrive = 2.2

if !{exists(global.e1Drive)}
    global e1Drive = 1.0
else
    set global.e1Drive = 1.0

; if !{exists(global.e2Drive)}
;     global e2Drive = 
; else
;     set global.e2Drive = 

if !{exists(global.e3Drive)}
    global e3Drive = 1.1
else
    set global.e3Drive = 1.1

if !{exists(global.e4Drive)}
    global e4Drive = 3.3
else
    set global.e4Drive = 3.3

if !{exists(global.e5Drive)}
    global e5Drive = 1.2
else
    set global.e5Drive = 1.2

if !{exists(global.fA1Drive)}
    global fA1Drive = 3.0
else
    set global.fA1Drive = 3.0

; if !{exists(global.fA2Drive)}
;     global fA2Drive = 
; else
;     set global.fA2Drive = 

if !{exists(global.fA3Drive)}
    global fA3Drive = 3.1
else
    set global.fA3Drive = 3.1

if !{exists(global.fA4Drive)}
    global fA4Drive = 3.5
else
    set global.fA4Drive = 3.5

if !{exists(global.fA5Drive)}
    global fA5Drive = 3.2
else
    set global.fA5Drive = 3.2

if !{exists(global.xDirection)}
    global xDirection = 0
else
    set global.xDirection = 0

if !{exists(global.yDirection)}
    global yDirection = 0
else
    set global.yDirection = 0

if !{exists(global.zDirection)}
    global zDirection = 0
else
    set global.zDirection = 0

if !{exists(global.uDirection)}
    global uDirection = 0
else
    set global.uDirection = 0

if !{exists(global.vDirection)}
    global vDirection = 1
else
    set global.vDirection = 1

if !{exists(global.wDirection)}
    global wDirection = 0
else
    set global.wDirection = 0

if !{exists(global.aDirection)}
    global aDirection = 0
else
    set global.aDirection = 0

if !{exists(global.aPrimeDirection)}
    global aPrimeDirection = 1
else
    set global.aPrimeDirection = 1

if !{exists(global.bDirection)}
    global bDirection = 1
else
    set global.bDirection = 1

if !{exists(global.cDirection)}
    global cDirection = 1
else
    set global.cDirection = 1

if !{exists(global.e1Direction)}
    global e1Direction = 0
else
    set global.e1Direction = 0

; if !{exists(global.e2Direction)}
;     global e2Direction = 
; else
;     set global.e2Direction = 

if !{exists(global.e3Direction)}
    global e3Direction = 0
else
    set global.e3Direction = 0

if !{exists(global.e4Direction)}
    global e4Direction = 0
else
    set global.e4Direction = 0

if !{exists(global.e5Direction)}
    global e5Direction = 0
else
    set global.e5Direction = 0

if !{exists(global.fA1Direction)}
    global fA1Direction = 0
else
    set global.fA1Direction = 0

; if !{exists(global.fA2Direction)}
;     global fA2Direction = 
; else
;     set global.fA2Direction = 

if !{exists(global.fA3Direction)}
    global fA3Direction = 0
else
    set global.fA3Direction = 0

if !{exists(global.fA4Direction)}
    global fA4Direction = 0
else
    set global.fA4Direction = 0

if !{exists(global.fA5Direction)}
    global fA5Direction = 0
else
    set global.fA5Direction = 0

if !{exists(global.cSPinchPin)}
    global cSPinchPin = "out1"
else
    set global.cSPinchPin = "out1"

if !{exists(global.zBrakePin)}
    global zBrakePin = "!out2"
else
    set global.zBrakePin = "!out2"

if !{exists(global.bELedPin)}
    global bELedPin = "3.out4"
else
    set global.bELedPin = "3.out4"

if !{exists(global.fCLedPin)}
    global fCLedPin = "3.out5"
else
    set global.fCLedPin = "3.out5"

if !{exists(global.fffFanPin)}
    global fffFanPin = "1.out7"
else
    set global.fffFanPin = "1.out7"

if !{exists(global.layerFanPin)}
    global layerFanPin = "1.out8"
else
    set global.layerFanPin = "1.out8"

; if !{exists(global.spindle1SpeedPin)}
;     global spindle1SpeedPin = ""
; else
;     set global.spindle1SpeedPin = ""

if !{exists(global.spindle2SpeedPin)}
    global spindle2SpeedPin = "io5.out"
else
    set global.spindle2SpeedPin = "io5.out"

; if !{exists(global.spindle3SpeedPin)}
;     global spindle3SpeedPin = ""
; else
;     set global.spindle3SpeedPin = ""

if !{exists(global.spindle4SpeedPin)}
    global spindle4SpeedPin = "io7.out"
else
    set global.spindle4SpeedPin = "io7.out"

; if !{exists(global.spindle5SpeedPin)}
;     global spindle5SpeedPin = ""
; else
;     set global.spindle5SpeedPin = ""

; if !{exists(global.spindle1DirectionPin)}
;     global spindle1DirectionPin = ""
; else
;     set global.spindle1DirectionPin = ""

if !{exists(global.spindle2DirectionPin)}
    global spindle2DirectionPin = "!io6.out"
else
    set global.spindle2DirectionPin = "!io6.out"

; if !{exists(global.spindle3DirectionPin)}
;     global spindle3DirectionPin = ""
; else
;     set global.spindle3DirectionPin = ""

if !{exists(global.spindle4DirectionPin)}
    global spindle4DirectionPin = "!io8.out"
else
    set global.spindle4DirectionPin = "!io8.out"

; if !{exists(global.spindle5DirectionPin)}
;     global spindle5DirectionPin = ""
; else
;     set global.spindle5DirectionPin = ""

; if !{exists(global.spindle1AirPin)}
;     global spindle1AirPin = ""
; else
;     set global.spindle1AirPin = ""

if !{exists(global.spindle2AirPin)}
    global spindle2AirPin = "out5"
else
    set global.spindle2AirPin = "out5"

; if !{exists(global.spindle3AirPin)}
;     global spindle3AirPin = ""
; else
;     set global.spindle3AirPin = ""

if !{exists(global.spindle4AirPin)}
    global spindle4AirPin = "out6"
else
    set global.spindle4AirPin = "out6"

; if !{exists(global.spindle5AirPin)}
;     global spindle5AirPin = ""
; else
;     set global.spindle5AirPin = ""

; if !{exists(global.spindle1AirIndex)}
;     global spindle1AirIndex = 
; else
;     set global.spindle1AirIndex = 

if !{exists(global.spindle2AirIndex)}
    global spindle2AirIndex = -1
else
    set global.spindle2AirIndex = -1

; if !{exists(global.spindle3AirIndex)}
;     global spindle3AirIndex = 
; else
;     set global.spindle3AirIndex = 

if !{exists(global.spindle4AirIndex)}
    global spindle4AirIndex = -1
else
    set global.spindle4AirIndex = -1

; if !{exists(global.spindle5AirIndex)}
;     global spindle5AirIndex = 
; else
;     set global.spindle5AirIndex = 

if !{exists(global.maxOffset)}
    global maxOffset = 0
else
    set global.maxOffset = 0

if !{exists(global.diameterProbeHole)}
    global diameterProbeHole = 14
else
    set global.diameterProbeHole = 14

if !{exists(global.bedHeatPin)}
    global bedHeatPin = "out7"
else
    set global.bedHeatPin = "out7"

if !{exists(global.bedTempPin)}
    global bedTempPin = "temp0"
else
    set global.bedTempPin = "temp0"

if !{exists(global.bEDoorPin)}
    global bEDoorPin = "1.io5.in"
else
    set global.bEDoorPin = "1.io5.in"

if !{exists(global.eHeat1Pin)}
    global eHeat1Pin = "1.out0"
else
    set global.eHeat1Pin = "1.out0"

; if !{exists(global.eHeat2Pin)}
;     global eHeat2Pin = ""
; else
;     set global.eHeat2Pin = ""

if !{exists(global.eHeat3Pin)}
    global eHeat3Pin = "1.out1"
else
    set global.eHeat3Pin = "1.out1"

if !{exists(global.eHeat4Pin)}
    global eHeat4Pin = "3.out1"
else
    set global.eHeat4Pin = "3.out1"

if !{exists(global.eHeat5Pin)}
    global eHeat5Pin = "1.out2"
else
    set global.eHeat5Pin = "1.out2"

if !{exists(global.e1HeatIndex)}
    global e1HeatIndex = -1
else
    set global.e1HeatIndex = -1

; if !{exists(global.e2HeatIndex)}
;     global e2HeatIndex = 
; else
;     set global.e2HeatIndex = 

if !{exists(global.e3HeatIndex)}
    global e3HeatIndex = -1
else
    set global.e3HeatIndex = -1

if !{exists(global.e4HeatIndex)}
    global e4HeatIndex = -1
else
    set global.e4HeatIndex = -1

if !{exists(global.e5HeatIndex)}
    global e5HeatIndex = -1
else
    set global.e5HeatIndex = -1

if !{exists(global.zProbeRetractPin)}
    global zProbeRetractPin = "out4"
else
    set global.zProbeRetractPin = "out4"

if !{exists(global.zProbePin)}
    global zProbePin = "io5.in"
else
    set global.zProbePin = "io5.in"

if !{exists(global.touchOffPlatePin)}
    global touchOffPlatePin = "io7.in"
else
    set global.touchOffPlatePin = "io7.in"

if !{exists(global.tCTouchOffPin)}
    global tCTouchOffPin = "io6.in"
else
    set global.tCTouchOffPin = "io6.in"

if !{exists(global.extruderCrashDetectPin)}
    global extruderCrashDetectPin = "1.io4.in"
else
    set global.extruderCrashDetectPin = "1.io4.in"

if !{exists(global.dhtPin)}
    global dhtPin = "io1.out"
else
    set global.dhtPin = "io1.out"

if !{exists(global.fSense1Pin)}
    global fSense1Pin = "3.io2.in"
else
    set global.fSense1Pin = "3.io2.in"

; if !{exists(global.fSense2Pin)}
;     global fSense2Pin = ""
; else
;     set global.fSense2Pin = ""

if !{exists(global.fSense3Pin)}
    global fSense3Pin = "3.io3.in"
else
    set global.fSense3Pin = "3.io3.in"

if !{exists(global.fSense4Pin)}
    global fSense4Pin = "3.io5.in"
else
    set global.fSense4Pin = "3.io5.in"

if !{exists(global.fSense5Pin)}
    global fSense5Pin = "3.io4.in"
else
    set global.fSense5Pin = "3.io4.in"

if !{exists(global.eStopSwitchPin)}
    global eStopSwitchPin = "io1.in"
else
    set global.eStopSwitchPin = "io1.in"

if !{exists(global.toolType1)}
    global toolType1 = "Extruder"
else
    set global.toolType1 = "Extruder"

if !{exists(global.toolType2)}
    global toolType2 = "Spindle"
else
    set global.toolType2 = "Spindle"

if !{exists(global.toolType3)}
    global toolType3 = "Extruder"
else
    set global.toolType3 = "Extruder"

; if !{exists(global.toolType4)}
;     global toolType4 = "" ; toolType4 is defined by machineType in tcreate-universal.g
; else
;     set global.toolType4 = ""

if !{exists(global.toolType5)}
    global toolType5 = "HT Extruder"
else
    set global.toolType5 = "HT Extruder"

if !{exists(global.e1TempPin)}
    global e1TempPin = "1.temp0"
else
    set global.e1TempPin = "1.temp0"

; if !{exists(global.e2TempPin)}
;     global e2TempPin = ""
; else
;     set global.e2TempPin = ""

if !{exists(global.e3TempPin)}
    global e3TempPin = "1.temp1"
else
    set global.e3TempPin = "1.temp1"

if !{exists(global.e4TempPin)}
    global e4TempPin = "3.temp0"
else
    set global.e4TempPin = "3.temp0"

if !{exists(global.e5TempPin)}
    global e5TempPin = "1.temp2"
else
    set global.e5TempPin = "1.temp2"

if !{exists(global.e1TempIndex)}
    global e1TempIndex = -1
else
    set global.e1TempIndex = -1

; if !{exists(global.e2TempIndex)}
;     global e2TempIndex = 
; else
;     set global.e2TempIndex = 

if !{exists(global.e3TempIndex)}
    global e3TempIndex = -1
else
    set global.e3TempIndex = -1

if !{exists(global.e4TempIndex)}
    global e4TempIndex = -1
else
    set global.e4TempIndex = -1

if !{exists(global.e5TempIndex)}
    global e5TempIndex = -1
else
    set global.e5TempIndex = -1

if !{exists(global.fCFanPin)}
    global fCFanPin = "3.out3"
else
    set global.fCFanPin = "3.out3"

if !{exists(global.fCSwitchPin)}
    global fCSwitchPin = "3.io0.in"
else
    set global.fCSwitchPin = "3.io0.in"

if !{exists(global.cDOnTrigger)}
    global cDOnTrigger = 2
else
    set global.cDOnTrigger = 2

if !{exists(global.cDOffTrigger)}
    global cDOffTrigger = 3
else
    set global.cDOffTrigger = 3

if !{exists(global.eStopOnTrigger)}
    global eStopOnTrigger = 4
else
    set global.eStopOnTrigger = 4

if !{exists(global.eStopOffTrigger)}
    global eStopOffTrigger = 5
else
    set global.eStopOffTrigger = 5

if !{exists(global.fCSwitchOnTrigger)}
    global fCSwitchOnTrigger = 6
else
    set global.fCSwitchOnTrigger = 6

if !{exists(global.fCSwitchOffTrigger)}
    global fCSwitchOffTrigger = 7
else
    set global.fCSwitchOffTrigger = 7

if !{exists(global.fCRH)}
    global fCRH = -273.15
else
    set global.fCRH = -273.15

if !{exists(global.fCDoorOpenTime)}
    global fCDoorOpenTime = 0
else
    set global.fCDoorOpenTime = 0

if !{exists(global.fCDoorCloseTime)}
    global fCDoorCloseTime = 0
else
    set global.fCDoorCloseTime = 0

if !{exists(global.uMotTempNum)}
    global uMotTempNum = -1
else
    set global.uMotTempNum = -1

if !{exists(global.uMotTemp)}
    global uMotTemp = -273.15
else
    set global.uMotTemp = -273.15

; if !{exists(global.uMotTempPin)}
;     global uMotTempPin = ""
; else
;     set global.uMotTempPin = ""

if !{exists(global.uMotTempTime)}
    global uMotTempTime = 0
else
    set global.uMotTempTime = 0

if !{exists(global.uMotTempTimeInterval)}
    global uMotTempTimeInterval = 30
else
    set global.uMotTempTimeInterval = 30

if !{exists(global.vacuumPin)}
    global vacuumPin = "1.out3"
else
    set global.vacuumPin = "1.out3"

if !{exists(global.vacuumFanNum)}
    global vacuumFanNum = -1
else
    set global.vacuumFanNum = -1

; if !{exists(global.cSSolenoidPin)}
;     global cSSolenoidPin = ""
; else
;     set global.cSSolenoidPin = ""

if !{exists(global.cSPinchOutNum)}
    global cSPinchOutNum = -1
else
    set global.cSPinchOutNum = -1

; if !{exists(global.cSSolenoidOutNum)}
;     global cSSolenoidOutNum = 
; else
;     set global.cSSolenoidOutNum = 

if !{exists(global.fffFanNum)}
    global fffFanNum = -1
else
    set global.fffFanNum = -1

if !{exists(global.layerFanNum)}
    global layerFanNum = -1
else
    set global.layerFanNum = -1

if !{exists(global.bELedFanNum)}
    global bELedFanNum = -1
else
    set global.bELedFanNum = -1

if !{exists(global.fCLedFanNum)}
    global fCLedFanNum = -1
else
    set global.fCLedFanNum = -1

if !{exists(global.zBrakeOutNum)}
    global zBrakeOutNum = -1
else
    set global.zBrakeOutNum = -1

if !{exists(global.eStopSwitchInNum)}
    global eStopSwitchInNum = -1
else
    set global.eStopSwitchInNum = -1

if !{exists(global.extruderCrashDetectInNum)}
    global extruderCrashDetectInNum = -1
else
    set global.extruderCrashDetectInNum = -1

if !{exists(global.zProbeRetractOutNum)}
    global zProbeRetractOutNum = -1
else
    set global.zProbeRetractOutNum = -1

if !{exists(global.bedHeaterNum)}
    global bedHeaterNum = -1
else
    set global.bedHeaterNum = -1

if !{exists(global.bedSensorNum)}
    global bedSensorNum = -1
else
    set global.bedSensorNum = -1

if !{exists(global.configLastRun)}
    global configLastRun = -1
else
    set global.configLastRun = -1

if !{exists(global.heatedBedLastRun)}
    global heatedBedLastRun = -1
else
    set global.heatedBedLastRun = -1

if !{exists(global.tCreateLastRun)}
    global tCreateLastRun = -1
else
    set global.tCreateLastRun = -1

if !{exists(global.cleaningStationLastRun)}
    global cleaningStationLastRun = -1
else
    set global.cleaningStationLastRun = -1

if !{exists(global.dryCabinetLastRun)}
    global dryCabinetLastRun = -1
else
    set global.dryCabinetLastRun = -1

if !{exists(global.maxOffsetLastRun)}
    global maxOffsetLastRun = -1
else
    set global.maxOffsetLastRun = -1

if !{exists(global.xMaxSpeed)}
    global xMaxSpeed = 10000
else
    set global.xMaxSpeed = 10000

if !{exists(global.xMaxSpeedRotary)}
    global xMaxSpeedRotary = 2000
else
    set global.xMaxSpeedRotary = 2000

if !{exists(global.machineSpecificLastRun)}
    global machineSpecificLastRun = -1
else
    set global.machineSpecificLastRun = -1

if !{exists(global.defaultParametersLastRun)}
    global defaultParametersLastRun = -1
else
    set global.defaultParametersLastRun = -1

if !{exists(global.dryCabinetFanNum)}
    global dryCabinetFanNum = -1
else
    set global.dryCabinetFanNum = -1

if !{exists(global.fCSwitchInNum)}
    global fCSwitchInNum = -1
else
    set global.fCSwitchInNum = -1

if !{exists(global.primeNextTC)}
    global primeNextTC = 1
else
    set global.primeNextTC = 1

if !{exists(global.tOSafeHeight)}
    global tOSafeHeight = 40
else
    set global.tOSafeHeight = 40

if !{exists(global.tOPlateHeight)}
    global tOPlateHeight = 12
else
    set global.tOPlateHeight = 12

if !{exists(global.tOPlateWidth)}
    global tOPlateWidth = 12
else
    set global.tOPlateWidth = 12

if !{exists(global.tOPlateXPos)}
    global tOPlateXPos = 0
else
    set global.tOPlateXPos = 0

if !{exists(global.tOPlateYPos)}
    global tOPlateYPos = 0
else
    set global.tOPlateYPos = 0

if !{exists(global.tOSCupHeight)}
    global tOSCupHeight = 10
else
    set global.tOSCupHeight = 10

if !{exists(global.tOSCupOD)}
    global tOSCupOD = 5
else
    set global.tOSCupOD = 5

if !{exists(global.tOSCupID)}
    global tOSCupID = 3
else
    set global.tOSCupID = 3

if !{exists(global.tOSCupDepth)}
    global tOSCupDepth = 2
else
    set global.tOSCupDepth = 2

if !{exists(global.isMovingProbe)}
    global isMovingProbe = 0
else
    set global.isMovingProbe = 0

if !{exists(global.airPressureInNum)}
    global airPressureInNum = -1
else
    set global.airPressureInNum = -1

if !{exists(global.airPressureSwitchPin)}
    global airPressureSwitchPin = "1.io3.in"
else
    set global.airPressureSwitchPin = "1.io3.in"

if !{exists(global.airPressureLowTrigger)}
    global airPressureLowTrigger = 8
else
    set global.airPressureLowTrigger = 8

if !{exists(global.bESwitchInNum)}
    global bESwitchInNum = -1
else
    set global.bESwitchInNum = -1

if !{exists(global.bESwitchPin)}
    global bESwitchPin = "1.io5.in"
else
    set global.bESwitchPin = "1.io5.in"

if !{exists(global.bESwitchHighTrigger)}
    global bESwitchHighTrigger = 10
else
    set global.bESwitchHighTrigger = 10

if !{exists(global.bESwitchLowTrigger)}
    global bESwitchLowTrigger = 11
else
    set global.bESwitchLowTrigger = 11

if !{exists(global.bEOpenTime)}
    global bEOpenTime = 0
else
    set global.bEOpenTime = 0

if !{exists(global.bECloseTime)}
    global bECloseTime = 0
else
    set global.bECloseTime = 0

if !{exists(global.t1AdditionalRetraction)}
    global t1AdditionalRetraction = 0
else
    set global.t1AdditionalRetraction = 0

if !{exists(global.t2AdditionalRetraction)}
    global t2AdditionalRetraction = 0
else
    set global.t2AdditionalRetraction = 0

if !{exists(global.t3AdditionalRetraction)}
    global t3AdditionalRetraction = 0
else
    set global.t3AdditionalRetraction = 0

if !{exists(global.t4AdditionalRetraction)}
    global t4AdditionalRetraction = 0
else
    set global.t4AdditionalRetraction = 0

if !{exists(global.t5AdditionalRetraction)}
    global t5AdditionalRetraction = 0
else
    set global.t5AdditionalRetraction = 0

if !{exists(global.currentAdditionalRetraction)}
    global currentAdditionalRetraction = 0
else
    set global.currentAdditionalRetraction = 0

if !{exists(global.jobXMin)}
    global jobXMin = 0
else
    set global.jobXMin = 0

if !{exists(global.jobXMax)}
    global jobXMax = 0
else
    set global.jobXMax = 0

if !{exists(global.jobYMin)}
    global jobYMin = 0
else
    set global.jobYMin = 0

if !{exists(global.jobYMax)}
    global jobYMax = 0
else
    set global.jobYMax = 0

if !{exists(global.jobZMin)}
    global jobZMin = 0
else
    set global.jobZMin = 0

if !{exists(global.jobZMax)}
    global jobZMax = 0
else
    set global.jobZMax = 0

if !{exists(global.jobAMin)}
    global jobAMin = 0
else
    set global.jobAMin = 0

if !{exists(global.jobAMax)}
    global jobAMax = 0
else
    set global.jobAMax = 0

if !{exists(global.jobCMin)}
    global jobCMin = 0
else
    set global.jobCMin = 0

if !{exists(global.jobCMax)}
    global jobCMax = 0
else
    set global.jobCMax = 0

if !{exists(global.tLockPin)}
    global tLockPin = "out6"
else
    set global.tLockPin = "out6"

if !{exists(global.tLockOutNum)}
    global tLockOutNum = -1
else
    set global.tLockOutNum = -1

if !{exists(global.dbarPin)}
    global dbarPin = "1.out4"
else
    set global.dbarPin = "1.out4"

if !{exists(global.dbarOutNum)}
    global dbarOutNum = -1
else
    set global.dbarOutNum = -1

if !{exists(global.spindleIndexPin)}
    global spindleIndexPin = "2.out3"
else
    set global.spindleIndexPin = "2.out3"

if !{exists(global.spindleIndexOutNum)}
    global spindleIndexOutNum = -1
else
    set global.spindleIndexOutNum = -1

if !{exists(global.spindleIndexSensePin)}
    global spindleIndexSensePin = "!1.io2.in"
else
    set global.spindleIndexSensePin = "!1.io2.in"

if !{exists(global.spindleIndexSenseInNum)}
    global spindleIndexSenseInNum = -1
else
    set global.spindleIndexSenseInNum = -1

if !{exists(global.tCToolReleaseOutNum)}
    global tCToolReleaseOutNum = -1
else
    set global.tCToolReleaseOutNum = -1

if !{exists(global.tCToolReleasePin)}
    global tCToolReleasePin = "1.out5"
else
    set global.tCToolReleasePin = "1.out5"

if !{exists(global.probeOverTravelTCTouchOff)}
    global probeOverTravelTCTouchOff = -1 ; The distance to move above ZMax when probing the tool changer touch off plate.
else
    set global.probeOverTravelTCTouchOff = -1

if !{exists(global.tCOvertravelGetTool)}
    global tCOvertravelGetTool = 31.25 ; The distance to move above ZMax when retrieving a tool from the tool changer.
else
    set global.tCOvertravelGetTool = 31.25

if !{exists(global.tCOvertravelPutTool)}
    global tCOvertravelPutTool = 31.75 ; The distance to move above ZMax when returning a tool to the tool changer.
else
    set global.tCOvertravelPutTool = 31.75

if !{exists(global.keepProbeDeployed)}
    global keepProbeDeployed = 0 ; A status flag to prevent unwanted probe retraction
else
    set global.keepProbeDeployed = 0

M118 S"End defaultparameters.g" L2
