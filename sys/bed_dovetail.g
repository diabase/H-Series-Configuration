M291 P"Is Dovetail Bed Installed?" R"First open" S3

M140 H-1                    ;disable bed heater

T{global.zProbeToolNum}     ; Select Probe
M561                        ;ensure user coordinated

G1 X0 Y-45 Z8 F8000         ;go to starting position
G30                         ;probe once to find Z=0
M557 X-180:180 Y-45:45 S90  ;define mesh levelling
G29                         ;run mesh levelling

