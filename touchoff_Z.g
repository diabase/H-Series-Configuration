M291 P"Turret will now move. Is a tool above the touch-off pin?" R"Crash Check" S3
;G38.2 Z0 P1

G38.2 Z{{ move.axes[2].userPosition - 10 }} P1
