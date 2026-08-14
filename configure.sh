#!/bin/bash

set -euo pipefail

main() {
    local script_dir
    local platform_configure
    local os_id
    local os_id_like

    script_dir="$(cd "$(dirname "${0}")" && pwd)"

    case "$(uname -s)" in
        Darwin)
            platform_configure="${script_dir}/configurator/macos/configure.sh"
            ;;
        Linux)
            if [[ ! -r /etc/os-release ]]; then
                printf '%s\n' 'Unable to identify this Linux distribution.' 1>&2
                exit 1
            fi

            # shellcheck disable=SC1091
            os_id="$(. /etc/os-release; printf '%s' "${ID:-}")"
            # shellcheck disable=SC1091
            os_id_like="$(. /etc/os-release; printf '%s' "${ID_LIKE:-}")"
            case " ${os_id} ${os_id_like} " in
                *debian*|*ubuntu*)
                    platform_configure="${script_dir}/configurator/debian/configure.sh"
                    ;;
                *)
                    printf '%s\n' 'This Linux distribution is not supported.' 1>&2
                    exit 1
                    ;;
            esac
            ;;
        *)
            printf '%s\n' 'This operating system is not supported.' 1>&2
            exit 1
            ;;
    esac

    "${script_dir}/configurator/directories.sh"
    "${script_dir}/configurator/git.sh"
    "${platform_configure}"
}

main "$@"
