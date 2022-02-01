; workpieceprobe_Ymin.g
; Called to probe a workpiece with the turret probe by moving toward Ymin
; Written by Diabase Engineering
; Last Updated: January 31, 2022

if sensors.probes[0].value[0] == 1000
    M291 P{"Error: :Probe already triggered. Check probe and try again."} R"Probe Already Triggered" S2
    abort

M291 P"Bed will now move. Is Probe behind a wall?" R"Crash Check" S3
G38.2 Y{{ move.axes[1].userPosition - 10 }}
