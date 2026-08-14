#!/bin/bash

set -euo pipefail

main() {
    mkdir -p \
        "${HOME}/local/bin" \
        "${HOME}/local/var/tmp"
}

main "$@"
