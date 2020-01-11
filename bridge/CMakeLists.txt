set(CMAKE_C_FLAGS "-O0 \
-s ALLOW_MEMORY_GROWTH=1 \
-s EXTRA_EXPORTED_RUNTIME_METHODS=\"[\"ccall\", \"cwrap\"]\" \
-s EXPORTED_FUNCTIONS=\"[\"_main\",\"_c4js_max\",\"_c4js_min\"]\" \
-s INVOKE_RUN=1 \
-s RESERVED_FUNCTION_POINTERS=20 \
-s TOTAL_MEMORY=33554432 \
--pre-js ../../bridge/jspre.js \
--js-library ../../bridge/jslib.js \
--post-js ../../bridge/jspost.js")

add_executable(
    bridge_test
    bridge_test.c
    js4c.h
    c4js.h
    c4js.c
    utils.h
    utils.c
)

target_link_libraries(
    bridge_test
    avcodec
    avutil
    swresample
    swscale
    x264
)

# set_target_properties(
#     bridge
#     PROPERTIES
#         OUTPUT_NAME "bridge"
#         SUFFIX ".wasm"
# )

add_executable(
    bridge_tvs
    bridge_tvs.c
    js4c.h
    c4js.h
    c4js.c
    utils.h
    utils.c
)

target_link_libraries(
    bridge_tvs
    avcodec
    avutil
    swresample
    swscale
    x264
)

add_executable(
    bridge_tvc
    bridge_tvc.c
    js4c.h
    c4js.h
    c4js.c
    utils.h
    utils.c
)

target_link_libraries(
    bridge_tvc
    avcodec
    avutil
    swresample
    swscale
    x264
)
