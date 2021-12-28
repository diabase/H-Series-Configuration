if !{exists(global.t1primeextra)}
	global t1primeextra = 0;
else
	set global.t1primeextra = 0;
M207 P1 S15 F3600 T180 R-7
if !{exists(global.t3primeextra)}
	global t3primeextra = 0;
else
	set global.t3primeextra = 0;
M207 P3 S15 F3600 T240 R-7
if !{exists(global.t5primeextra)}
	global t5primeextra = 0;
else
	set global.t5primeextra = 0;
M207 P5 S15 F3600 T300 R-7
