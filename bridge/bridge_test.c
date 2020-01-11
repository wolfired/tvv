#include <stdio.h>

#include "c4js.h"

int main(int argc, char** argv) {
    printf("bridge_test inited!!\n");

    uint32_t raw[] = {0, 1, 2, 3};

    printf("c4js_sum_and_times = %d\n", c4js_sum_and_times(raw, 4));

    return 0;
}
