#ifndef C4JS_H
#define C4JS_H

#include <stdint.h>

#include <emscripten.h>

#ifdef __cplusplus
extern "C" {
#endif

uint32_t c4js_max(uint32_t x, uint32_t y);
uint32_t c4js_min(uint32_t x, uint32_t y);
uint32_t c4js_sum_and_times(void* raw, uint32_t len);

#ifdef __cplusplus
}
#endif

#endif
