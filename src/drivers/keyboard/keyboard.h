#ifndef _KEYBOARD_H
#define _KEYBOARD_H

#include "idt.h"

void keyboard_handler(regs *);
void init_keyboard(void);
#endif
