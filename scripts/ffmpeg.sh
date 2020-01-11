FFMPEG_BUILT_ROOT=${ffmpeg_built_root:-"./ffmpeg_built"}
FFMPEG_RECONFIGURE=${ffmpeg_reconfigure:-"false"}

function ffmpeg_public_help() {
    echo ""
    echo "ffmpeg options:"
    echo "  ffmpeg_built_root=\"$FFMPEG_BUILT_ROOT\""
    echo "  ffmpeg_reconfigure=$FFMPEG_RECONFIGURE"
}

function ffmpeg_public_clean() {
    rm -rf $FFMPEG_BUILT_ROOT
}

function ffmpeg_public_build_pre() {
    local reconfigure=$FFMPEG_RECONFIGURE
    if [ ! -d $FFMPEG_BUILT_ROOT ]; then
        reconfigure=true
    fi

    mkdir -p $FFMPEG_BUILT_ROOT
    pushd $FFMPEG_BUILT_ROOT

    if [ "true" = "$reconfigure" ]; then
        ffmpeg_private_configure
    fi
}

function ffmpeg_public_build() {
    ffmpeg_public_build_pre
    common_public_make make -j$COMMON_NPROC && common_public_make make -j$COMMON_NPROC install
    # ffmpeg_private_build_wasm
    # ffmpeg_public_build_post
}

function ffmpeg_public_build_post() {
    cp ffmpeg.js ../bin
    cp ffmpeg.wasm ../bin
    popd
}

function ffmpeg_private_fetch() {
    cd ffmpeg
    git fetch --depth 1 origin refs/tags/n4.2.1:refs/tags/n4.2.1
    git checkout n4.2.1
    cd ..
}

function ffmpeg_private_configure() {
    common_public_configure ../ffmpeg/configure \
    --prefix=$COMMON_INSTALL_ROOT \
    --extra-cflags="-I$COMMON_INSTALL_ROOT/include" \
    --extra-cxxflags="-I$COMMON_INSTALL_ROOT/include" \
    --extra-ldflags="-L$COMMON_INSTALL_ROOT/lib" \
    --enable-gpl \
    --enable-libx264 \
    --disable-pthreads \
    --disable-x86asm \
    --disable-inline-asm \
    --disable-doc \
    --disable-stripping \
    --disable-ffprobe \
    --disable-ffplay \
    --disable-ffmpeg \
    --nm="llvm-nm -g" \
    --ar=emar \
    --cc=emcc \
    --cxx=em++ \
    --objcc=emcc \
    --dep-cc=emcc \
    --ranlib=emranlib
}

function ffmpeg_private_build_error_fix() {
    sed -i "s/#define HAVE_CBRT 0/#define HAVE_CBRT 1/g" ./config.h
    sed -i "s/#define HAVE_CBRTF 0/#define HAVE_CBRTF 1/g" ./config.h
    sed -i "s/#define HAVE_COPYSIGN 0/#define HAVE_COPYSIGN 1/g" ./config.h
    sed -i "s/#define HAVE_ERF 0/#define HAVE_ERF 1/g" ./config.h
    sed -i "s/#define HAVE_HYPOT 0/#define HAVE_HYPOT 1/g" ./config.h
    sed -i "s/#define HAVE_RINT 0/#define HAVE_RINT 1/g" ./config.h
    sed -i "s/#define HAVE_LRINT 0/#define HAVE_LRINT 1/g" ./config.h
    sed -i "s/#define HAVE_LRINTF 0/#define HAVE_LRINTF 1/g" ./config.h
    sed -i "s/#define HAVE_TRUNC 0/#define HAVE_TRUNC 1/g" ./config.h
    sed -i "s/#define HAVE_TRUNCF 0/#define HAVE_TRUNCF 1/g" ./config.h
    sed -i "s/#define HAVE_ROUND 0/#define HAVE_ROUND 1/g" ./config.h
    sed -i "s/#define HAVE_ROUNDF 0/#define HAVE_ROUNDF 1/g" ./config.h
}

function ffmpeg_private_build_wasm() {
    emcc -Llibavcodec -Llibavdevice -Llibavfilter -Llibavformat -Llibavresample -Llibavutil -Llibpostproc -Llibswscale -Llibswresample -Wl,--as-needed -Wl,-z,noexecstack -Wl,--warn-common -Wl,-rpath-link=:libpostproc:libswresample:libswscale:libavfilter:libavdevice:libavformat:libavcodec:libavutil:libavresample -Qunused-arguments   -o ffmpeg.js fftools/ffmpeg_opt.o fftools/ffmpeg_filter.o fftools/ffmpeg_hw.o fftools/cmdutils.o fftools/ffmpeg.o  -lavdevice -lavfilter -lavformat -lavcodec -lswresample -lswscale -lavutil  -lm -s USE_SDL=2 -lm -lm -lm -lm -lm -lm -s TOTAL_MEMORY=33554432
}
