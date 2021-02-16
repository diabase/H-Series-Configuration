M291 P"Turret will now move. Is a tool above the touch-off pin?" R"Crash Check" S3
; G38.2 Z0 P1 ; Original line was updated on 12/30/2020
G10 P{state.currentTool} Z0 ; New added 12/30/2020
G38.2 Z{move.axes[2].userPosition - 8} P1 ; New added 12/30/2020 Compare to original G38.2 above
