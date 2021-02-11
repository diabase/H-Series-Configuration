; sleep.g
; If the axes are homed and if a print is being cancelled (M25), cancel.g is called when M1 is sent.
; If M1 is sent at any other time, stop.g is called.

; We don't ever expect to encounter a sleep command, but if we do, we want the behavior to be identical to a stop command.

M98 P"stop.g" ; Call stop.g
