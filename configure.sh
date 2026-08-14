#!/bin/bash

set -euo pipefail

os-release-value() {
    local name="${1:?}"

    awk -F= -v name="${name}" '
        $1 == name {
            value = substr($0, index($0, "=") + 1)
            gsub(/^["\047]|["\047]$/, "", value)
            print value
        }
    ' /etc/os-release
}

platform() {
    local kernel_name
    local os_id
    local os_id_like

    kernel_name="$(uname -s | awk '{ print tolower($0) }')"
    case "${kernel_name}" in
        darwin)
            printf '%s\n' 'macos'
            ;;
        linux)
            if [[ ! -r /etc/os-release ]]; then
                printf '%s\n' 'Unable to identify this Linux distribution.' 1>&2
                return 1
            fi

            os_id="$(os-release-value ID)"
            os_id_like="$(os-release-value ID_LIKE)"

            case " ${os_id} ${os_id_like} " in
                *debian*|*ubuntu*)
                    printf '%s\n' 'debian'
                    ;;
                *)
                    printf '%s\n' 'This Linux distribution is not supported.' 1>&2
                    return 1
                    ;;
            esac
            ;;
        *)
            printf '%s\n' 'This operating system is not supported.' 1>&2
            return 1
            ;;
    esac
}

main() {
    local script_dir
    local platform_name
    local platform_configure

    script_dir="$(cd "$(dirname "${0}")" && pwd)"
    if ! platform_name="$(platform)"; then
        return 1
    fi
    platform_configure="${script_dir}/configurator/${platform_name}/configure.sh"

    "${script_dir}/configurator/directories.sh"
    "${script_dir}/configurator/git.sh"
    if [[ -x "${platform_configure}" ]]; then
        "${platform_configure}"
    fi
}

main "$@"
