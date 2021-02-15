M291 P"Bed will now move. Is Probe to the right of a wall?" R"Crash Check" S3
G38.2 X{{ move.axes[0].userPosition - 10 }} ; This uses feed of probe 0 (F150 by default) use M558 Fnn n to change beforehand0
