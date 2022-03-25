; spindletemptest.g
; Gather temperature data on the first run of a spindle.
; Written by Diabase Engineering
; Last Updated: March 21, 2022

M118 S{"Begin spindletemptest.g"} L3

M291 P{"Are you ready to begin the spindle temperature test? This will take one hour to complete."} R"Spindle Temperature Test" S3

while iterations < #spindles
    if spindles[iterations].state != "stopped"
        M5 P{iterations}                ; Turn this spindle off
        G4 P1000                        ; Dwell for 1000 ms to allow it time to stop

M118 S{"Spindle stopped"} L2
set global.spinTempTime = state.upTime
set global.spinTemp = sensors.analog[{global.spinTempNum}].lastReading
M118 S{"Beginning spindle temperature is "^global.spinTemp^" at "^global.spinTempTime} L2

M118 S{"Starting spindle at 10000 RPM"} L2
M3 P0 S10000
G4 S1800

set global.spinTempTime = state.upTime
set global.spinTemp = sensors.analog[{global.spinTempNum}].lastReading
M118 S{"Current spindle temperature is "^global.spinTemp^" at "^global.spinTempTime} L2

M118 S{"Increasing spindle to 16000 RPM"} L2
M3 P0 S16000
G4 S1800

set global.spinTempTime = state.upTime
set global.spinTemp = sensors.analog[{global.spinTempNum}].lastReading
M118 S{"Current spindle temperature is "^global.spinTemp^" at "^global.spinTempTime} L2

M118 S{"Stopping Spindle"} L2
M5

M118 S{"End spindletemptest.g"} L3
