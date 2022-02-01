; workpieceprobe_Zmax.g
; It should not be possible to run this file.
; Written by Diabase Engineering
; Last Updated: January 31, 2022

; M291 P"WRONG ONE" R"Crash Check" S3
; G38.4 Z{{ move.axes[2].userPosition - 10 }}; This uses feed of probe 0 (F150 by default) use M558 Fnn n to change beforehand
