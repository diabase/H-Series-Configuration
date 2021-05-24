M98 p"unlock_turret.g"
G92 U180  ;set U to arbitrary position
M291 P"Jog turret to a safe location" R"Tool Recovery Confirmation" S3 U1;blocking confirmation window
M106 P4 S1						;release tool collet
G4 P500
M291 P"Remove tool" R"Tool Recovery Confirmation" S2;blocking confirmation window
M18 U   ;releave arbitrary U position

  