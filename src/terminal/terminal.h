#ifndef _TERMINAL_H
#define _TERMINAL_H

#include <stddef.h>
#include <stdint.h>

void terminal_init(void);
void terminal_write(char *, size_t);
void terminal_putchar(uint8_t);
#endif
