/*
 * Function prototypes
 */

#include <stdarg.h>
#include <stdint.h>
#include <stdbool.h>
#include <stddef.h>

#include "lib.h"

extern void init_led();
extern void led(char c);

extern void init_cons();
extern void cons_putc(char c);
extern int cons_getc();

extern void init_cf();
extern void *cf_read(uint32_t lba);

typedef int (*cmd_handler_fn)(const char *input_buffer);
#define COMMAND(handler_function)                               \
    static int handler_function(const char *input_buffer);      \
    static const                                                \
    __attribute__((section("COMMANDS")))                        \
    __attribute__((used))                                       \
    cmd_handler_fn cmdptr_ ## handler_function = handler_function;
extern cmd_handler_fn   __commands, __commands_end;
