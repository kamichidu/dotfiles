#!/bin/bash

set -euo pipefail

list-scripts() {
    local script_dir="${1}"
    local script

    for script in "${script_dir}"/*; do
        if [[ -f "${script}" ]]; then
            printf '%s\n' "${script}"
        fi
    done
}

main() {
    local script_dir="${HOME}/.config/git-config-init"
    local script

    if ! command -v peco >/dev/null 2>&1; then
        printf '%s\n' 'peco is required.' 1>&2
        return 1
    fi

    mkdir -p "${script_dir}"
    script="$(list-scripts "${script_dir}" | peco || true)"
    if [[ -z "${script}" ]]; then
        return 0
    fi

    "${SHELL}" "${script}"
}

main "$@"
