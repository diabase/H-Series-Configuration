; trigger10.g
; Behavior for Closing Build Enclosure
; Written by Diabase Engineering
; Last Updated: October 13, 2021

M118 S{"Debug: Begin trigger10.g"} L3

set global.BECloseTime = state.upTime
M118 S{"Info: Build Enclosure -- Enclosure Closed"} L2    ; Log informational event

M118 S{"Debug: End trigger10.g"} L3
