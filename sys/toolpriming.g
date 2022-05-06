if !{exists(global.t1AdditionalRetraction)}
	global t1AdditionalRetraction = 0.6;
else
	set global.t1AdditionalRetraction = 0.6;
M207 P1 S6 F3600 T240 R2
if !{exists(global.t3AdditionalRetraction)}
	global t3AdditionalRetraction = 0.6;
else
	set global.t3AdditionalRetraction = 0.6;
M207 P3 S6 F3600 T240 R2
if !{exists(global.t4AdditionalRetraction)}
	global t4AdditionalRetraction = 0.6;
else
	set global.t4AdditionalRetraction = 0.6;
M207 P4 S6 F3600 T240 R2
if !{exists(global.t5AdditionalRetraction)}
	global t5AdditionalRetraction = 1;
else
	set global.t5AdditionalRetraction = 1;
M207 P5 S6 F3600 T240 R2
