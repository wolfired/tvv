BRIDGE_BUILT_ROOT=${bridge_built_root:-"./bridge_built"}

function bridge_public_help() {
    echo ""
    echo "bridge options:"
    echo "  bridge_built_root=\"$BRIDGE_BUILT_ROOT\""
}

function bridge_public_clean() {
    rm -rf $BRIDGE_BUILT_ROOT
}

function bridge_public_build_pre() {
    mkdir -p $BRIDGE_BUILT_ROOT
    pushd $BRIDGE_BUILT_ROOT
}

function bridge_public_build() {
    bridge_public_build_pre
    common_public_cmake cmake .. && common_public_make make -j$COMMON_NPROC
    bridge_public_build_post
}

function bridge_public_build_post() {
    local d=../bin/
    if [ ! -d $d ]; then mkdir -p $d; fi
    cp bridge_*.wasm $d
    cp bridge_*.js $d
    popd
}
