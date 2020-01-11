#ifndef UTILS_H
#define UTILS_H

#include <libavcodec/avcodec.h>
#include <libswscale/swscale.h>

#include <stddef.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct _Buf {
    void* raw;
    size_t p;
} Buf;

Buf* buf_init(Buf* buf, size_t size);
void buf_write(Buf* buf, const void* data, size_t size);
void buf_cover(Buf* buf, const void* data, size_t size);
void buf_free(Buf** target);

uint8_t* generate_rgba(uint8_t* rgba, int64_t pts, int wid, int hei);

struct SwsContext* rgba2yuv(struct SwsContext* sws_context, AVFrame* frame, uint8_t* rgba);
struct SwsContext* yuv2rgba(struct SwsContext* sws_context, AVFrame* frame, uint8_t* rgba);

#ifdef __cplusplus
}
#endif

#endif
