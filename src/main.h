#ifndef _MAIN_H_
#define _MAIN_H_

#include "types.h"

extern u8 *main_BSS_START[];

void mainproc(void);
void thread1_main(void *);
void thread3_verify_stack(void);

#endif
