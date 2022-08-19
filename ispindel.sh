#!/usr/bin/env bash
set -Eeuo pipefail
# Usage:
#   ./ispindel.sh [<port>] [<basic|pretty>]

PORT="${1:-5001}"
FORMAT="${2:-basic}"

listen() {
    echo "Listening on port ${PORT}..."
    echo 'Press Ctrl+C to exit'

    while true; do
        INPUT="$(nc -l 0.0.0.0 "$PORT")"

        echo
        echo "Received $(date -Ins):"
        echo "$INPUT" | format
    done
}

format() {
    format_cmd='cat'
    [ "$FORMAT" == 'pretty' ] && format_cmd='jq'
    echo "$INPUT" | "$format_cmd"
}

listen
