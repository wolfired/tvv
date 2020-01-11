#include "c4js.h"

#ifdef __cplusplus
extern "C" {
#endif

/**
 * 测试用
 */
uint32_t c4js_max(uint32_t x, uint32_t y) { return x > y ? x : y; }

/**
 * 测试用
 */
uint32_t c4js_min(uint32_t x, uint32_t y) { return x < y ? x : y; }

/**
 * 测试用
 */
EMSCRIPTEN_KEEPALIVE uint32_t c4js_sum_and_times(void* raw, uint32_t len) {
    uint32_t result = 0;

    for (uint32_t i = 0; i < len; ++i) {
        result += *((uint32_t*)raw + i);
        *((uint32_t*)raw + i) *= 2;
    }

    return result;
}

#ifdef __cplusplus
}
#endif
