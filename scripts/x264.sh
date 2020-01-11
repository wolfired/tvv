X264_BUILT_ROOT=${x264_built_root:-"./x264_built"}
X264_RECONFIGURE=${x264_reconfigure:-"false"}

function x264_public_help() {
    echo ""
    echo "x264 options:"
    echo "  x264_built_root=\"$X264_BUILT_ROOT\""
    echo "  x264_reconfigure=$X264_RECONFIGURE"
}

function x264_public_clean() {
    rm -rf $X264_BUILT_ROOT
}

function x264_public_build_pre() {
    local reconfigure=$X264_RECONFIGURE
    if [ ! -d $X264_BUILT_ROOT ]; then
        reconfigure=true
    fi

    mkdir -p $X264_BUILT_ROOT
    pushd $X264_BUILT_ROOT

    if [ "true" = "$reconfigure" ]; then
        x264_private_configure
    fi
}

function x264_public_build() {
    x264_public_build_pre
    common_public_make make -j$COMMON_NPROC install-lib-static
    x264_public_build_post
}

function x264_public_build_post() {
    popd
}

function x264_private_fetch() {
    cd x264
    # git fetch --depth 1 origin refs/tags/n4.2.1:refs/tags/n4.2.1
    # git checkout n4.2.1
    cd ..
}

function x264_private_configure() {
    common_public_configure ../x264/configure \
    --prefix=$COMMON_INSTALL_ROOT \
    --extra-cflags="-m32" \
    --extra-ldflags="-m32" \
    --disable-asm \
    --disable-thread
}
