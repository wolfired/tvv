EMSDK_ROOT=${emsdk_root:-"$HOME/workspace_labs/emsdk"}
EMSDK_ENABLE=${emsdk_enable:-"true"}

function emsdk_public_help() {
    echo ""
    echo "emsdk options:"
    echo "  emsdk_root=\"$EMSDK_ROOT\""
    echo "  emsdk_enable=$EMSDK_ENABLE"
}

function emsdk_public_enable() {
    if [ "true" = "$EMSDK_ENABLE" ]; then
        source "$EMSDK_ROOT/emsdk_env.sh"
    fi
}
