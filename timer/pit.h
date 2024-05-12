#ifndef _PIT_H
#define _PIT_H
void init_pit(void);
#endif

/*
PIT - usefuly chip for generating interrupts at regular time intervals
	
	3 channels:
		- channel 0 = irq0: to interrupt CPU at predictable and regular times
			*by default this channel is set to generate an irq0 18.222 times per second
		- channel 1 = system specific
		- channel 2 = connected to system speaker

*/


