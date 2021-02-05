; Called to home only the rotary Y axis

G91 ; Relative Positioning
G1 Y-365 H1 F6000 ; Attempt to move Y -370mm at 6000 mm/min, but halt if endstop triggered and set axis position to axis limit as defined by previous M208 or G1 H3 special move
G1 Y2 H2 ; Move Y +2mm, ignoring endstop
G1 Y-4 H1 F200 ; Attempt to move Y -4mm at 200 mm/min, but halt if endstop triggered and set axis position to axis limit as defined by previous M208 or G1 H3 special move
G92 Y0 ; Set current Y position as 0 mm

G90 ; Absolute Positioning
