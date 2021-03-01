; Called to home only the A axis

G91 ; Relative Positioning
G1 A-370 H1 F6000 ; Attempt to move A -370mm at 6000 mm/min, but halt if endstop triggered and set axis position to axis limit as defined by previous M208 or G1 H3 special move
G1 A2 H2 ; Move A +2mm, ignoring endstop
G1 A-4 H1 F200 ; Attempt to move A -4mm at 200 mm/min, but halt if endstop triggered and set axis position to axis limit as defined by previous M208 or G1 H3 special move
G92 A0 ; Set current A position as 0 mm

G90 ; Absolute Positioning
