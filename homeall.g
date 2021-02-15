; called to home all axes
if state.status!="processing" || !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed || !move.axes[3].homed
  ; Deselect the current tool (if any) and enter FFF mode
  M84 E0
  T-1
  M451
  G92 A C
  ; Enable upper Z endstop and move away from the base plane
  M574 Z2 H1 P"zstop"
  G91
  G1 H1 Z60 F6000


  ; Unlock the turret and disable stall detection for it
  M98 P"unlock_turret.g"
  M915 U R0

  ; Home X Y Z U
  G1 H1 X-420 Y-180 Z220 U-380
  G1 H2 X2 Y2 Z-2 U2 F6000
  G1 H1 X-20 Y-20 Z20 U-29.7 F3000

  ; Move to the Z probe offset and lock the turret again
  G90
  G1 U0 F9900
  M98 P"lock_turret.g"
  G92 U0

  ; Go to X=0 Y=0
  G1 X0 Y0 F10000
  G91
  G1 Z-25
  G90
  G60 S1

  M453; CNC mode
  ; Put all the tools into standby mode and leave the Z probe tool activated
  T1 P0
  T2 P0
  T3 P0
  T4 P0
  T5 P0
  T10 P0


  M451 ;back to FFF mode

  ;Restore motor currents to X and Y axes
  M913 X100 Y100
