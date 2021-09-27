#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function print_help() {
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  -h, --help          display this help info"
}

TEMP=$( \
    getopt \
        -n $(basename "$0") \
        -o h \
        --long help \
        -- "$@"
    )

if [ $? != 0 ]; then echo "Terminating..." >&2; exit 1; fi

eval set -- "$TEMP"

while true; do
    case "$1" in
        -h|--help)      print_help              ; exit 0    ;;
        --)             shift                   ; break     ;;
        *)              echo "Internal error!"  ; exit 1    ;;
    esac
done

num_req=0
if [[ $# -ne $num_req ]]; then
    print_help
    echo "ERROR: Script requires $num_req arguments, but got $#"
    exit 1
fi

set -e

cd "${DIR}"
if [[ ! -e flysight-viewer-qt ]]; then
    git clone https://github.com/atkenny15/flysight-viewer-qt.git
    cd flysight-viewer-qt

    if [[ -e "${DIR}/secrets.h" ]]; then
        echo "Note: Found secrets file: '${DIR}/secrets.h'"
        cp -v "${DIR}/secrets.h" "src/"
    else
        cat <<'EOT' > "src/secrets.h"
#ifndef __SECRETS_H__
#define __SECRETS_H__

#define GOOGLE_MAPS_API_KEY "GOOGLE_MAPS_API_KEY"

#endif
EOT
    fi
fi

if [[ ! -e nvidia.run ]]; then
    echo "#!/bin/bash" >nvidia.run
fi
