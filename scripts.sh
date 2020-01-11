set -e

source ./scripts/emsdk.sh
source ./scripts/common.sh
source ./scripts/bridge.sh
source ./scripts/ffmpeg.sh
source ./scripts/x264.sh

if [ 0 == $# ] || [ '-h' == "$1" ] || [ '--help' == "$1" ]; then
    echo "Usage:"
    echo "  [options] ./script.sh [target] [action]"
    common_public_help
    emsdk_public_help
    bridge_public_help
    ffmpeg_public_help
    x264_public_help
    exit 0
fi

emsdk_public_enable

$1_public_$2
