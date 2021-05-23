#!/usr/bin/awk -f
# -v file=FILENAME
BEGIN {
	format = "%H:%M:%S"
	start = systime()
	if(file == "") file = "unnamed"
	filename = file"-"strftime("%Y%m%d-%H%M%S",start)".log"
}
{
	time = systime()
	s = time - start
	elapsed = sprintf("%02d:%02d:%02d", s/3600, s/60%60, s%60)
	string = "| "strftime(format, time)" | "elapsed" | "$0
	print string
	print string >> filename
	fflush(filename)
}

