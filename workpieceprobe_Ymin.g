M291 P"Bed will now move. Is Probe behind a wall?" R"Crash Check" S3
G38.2 Y{{ move.axes[1].userPosition - 10 }} ; This uses feed of probe 0 (F150 by default) use M558 Fnn n to change beforehand0
