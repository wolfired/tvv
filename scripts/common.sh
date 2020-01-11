COMMON_INSTALL_ROOT=${common_install_root:-"$PWD/built"}

COMMON_NPROC=$(grep -c ^processor /proc/cpuinfo)

function common_public_help() {
    echo ""
    echo "common options:"
}

function common_public_configure {
    local emsdk_script_emconfigure=
    if [ "true" = "$EMSDK_ENABLE" ]; then
        emsdk_script_emconfigure=emconfigure
    fi
    $emsdk_script_emconfigure "$@"
}

function common_public_cmake() {
    local emsdk_script_emcmake=
    if [ "true" = "$EMSDK_ENABLE" ]; then
        emsdk_script_emcmake=emcmake
    fi
    $emsdk_script_emcmake "$@"
}

function common_public_make() {
    local emsdk_script_emmake=
    if [ "true" = "$EMSDK_ENABLE" ]; then
        emsdk_script_emmake=emmake
    fi
    
    $emsdk_script_emmake "$@"
}
