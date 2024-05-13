#include <stdint.h>

uint32_t strlen(char *str) {
	int len = 0;
	if(str == NULL) 
		return len;

	while(*str) {
		len++;
		str++;
	}

	return len;
}
