; Called to home only the C axis

G91 ; Relative Positioning
G1 C-370 H1 F6000 ; Attempt to move C -370mm at 6000 mm/min, but halt if endstop triggered and set axis position to axis limit as defined by previous M208 or G1 H3 special move
G1 C2 H2 ; Move C +2mm, ignoring endstop
G1 C-4 H1 F200 ; Attempt to move C -4mm at 200 mm/min, but halt if endstop triggered and set axis position to axis limit as defined by previous M208 or G1 H3 special move
G92 C0 ; Set current C position as 0 mm

G90 ; Absolute Positioning
