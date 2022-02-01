; workpieceprobe_Zmin.g
; Called to probe in negative Z using the turret probe.
; Written by Diabase Engineering
; Last Updated: January 31, 2022

M291 P"Turret will now move. Is Probe above a surface?" R"Crash Check" S3
if sensors.probes[0].value[0] == 1000
    M291 P{"Error: :Probe already triggered. Check probe and try again."} R"Probe Already Triggered" S2
    abort
G38.2 Z{move.axes[2].userPosition - 10 }; This uses feed of probe 0 (F150 by default) use M558 Fnn n to change beforehand
