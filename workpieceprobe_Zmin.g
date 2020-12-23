M291 P"Turret will now move. Is Probe above a surface?" R"Crash Check" S3
G38.2 Z{move.axes[2].userPosition - 10 }; This uses feed of probe 0 (F150 by default) use M558 Fnn n to change beforehand
