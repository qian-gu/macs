iverilog:
	iverilog -f vlogfiles.f -g2012 -o a.out
	vvp a.out
