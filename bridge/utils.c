#include <stdlib.h>
#include <string.h>

#include "utils.h"

#ifdef __cplusplus
extern "C" {
#endif

Buf* buf_init(Buf* buf, size_t size) {
    if (NULL == buf) {
        buf = malloc(sizeof(Buf));
    }

    buf->raw = malloc(size);
    buf->p = 0;

    return buf;
}

void buf_write(Buf* buf, const void* data, size_t size) {
    memcpy(buf->raw + buf->p, data, size);
    buf->p += size;
}

void buf_cover(Buf* buf, const void* data, size_t size) {
    memcpy(buf->raw, data, size);
    buf->p = size;
}

void buf_free(Buf** target) {
    free((*target)->raw);
    (*target)->p = 0;

    free(*target);
    *target = 0;
}

uint8_t* generate_rgba(uint8_t* rgba, int64_t pts, int wid, int hei) {
    rgba = realloc(rgba, 4 * sizeof(uint8_t) * wid * hei);

    int cur;
    for (int y = 0; y < hei; ++y) {
        for (int x = 0; x < wid; ++x) {
            cur = 4 * (y * wid + x);
            rgba[cur + 0] = pts * 2;
            rgba[cur + 1] = 0;
            rgba[cur + 2] = 0;
            rgba[cur + 3] = 255;
        }
    }
    return rgba;
}

struct SwsContext* rgba2yuv(struct SwsContext* sws_context, AVFrame* frame, uint8_t* rgba) {
    const int in_linesize[1] = {4 * frame->width};
    sws_context = sws_getCachedContext(sws_context, frame->width, frame->height, AV_PIX_FMT_RGBA, frame->width, frame->height, AV_PIX_FMT_YUV420P, 0, 0, 0, 0);
    sws_scale(sws_context, (const uint8_t* const*)&rgba, in_linesize, 0, frame->height, frame->data, frame->linesize);
    return sws_context;
}

struct SwsContext* yuv2rgba(struct SwsContext* sws_context, AVFrame* frame, uint8_t* rgba) {
    const int in_linesize[1] = {4 * frame->width};
    sws_context = sws_getCachedContext(sws_context, frame->width, frame->height, AV_PIX_FMT_YUV420P, frame->width, frame->height, AV_PIX_FMT_RGBA, 0, 0, 0, 0);
    sws_scale(sws_context, (const uint8_t* const*)frame->data, frame->linesize, 0, frame->height, (uint8_t* const*)&rgba, in_linesize);
    return sws_context;
}

#ifdef __cplusplus
}
#endif
