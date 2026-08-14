#!/bin/bash

set -euo pipefail

main() {
    local repository_url="${DOTFILES_REPOSITORY_URL:-https://github.com/kamichidu/dotfiles.git}"
    local checkout_dir="${DOTFILES_DIR:-${HOME}/dotfiles}"
    local script_dir
    local dotfiles_dir
    local os_id
    local os_id_like

    script_dir="$(cd "$(dirname "${0}")" 2>/dev/null && pwd || true)"

    if [[ "$(uname -s)" != "Linux" ]]; then
        printf '%s\n' 'This bootstrap script supports Linux only.' 1>&2
        exit 1
    fi

    if [[ ! -r /etc/os-release ]]; then
        printf '%s\n' 'Unable to identify this Linux distribution.' 1>&2
        exit 1
    fi

    # shellcheck disable=SC1091
    os_id="$(. /etc/os-release; printf '%s' "${ID:-}")"
    # shellcheck disable=SC1091
    os_id_like="$(. /etc/os-release; printf '%s' "${ID_LIKE:-}")"
    case " ${os_id} ${os_id_like} " in
        *debian*|*ubuntu*) ;;
        *)
            printf '%s\n' 'This bootstrap script currently supports Debian-based Linux only.' 1>&2
            exit 1
            ;;
    esac

    if ! command -v git >/dev/null 2>&1; then
        if ! command -v sudo >/dev/null 2>&1; then
            printf '%s\n' 'sudo is required to install git.' 1>&2
            exit 1
        fi
        printf '%s\n' 'Installing git' 1>&2
        sudo apt-get update
        sudo apt-get install -y git
    fi

    if [[ -n "${script_dir}" && -f "${script_dir}/../apply.sh" ]]; then
        dotfiles_dir="$(cd "${script_dir}/.." && pwd)"
    elif [[ -d "${checkout_dir}/.git" ]]; then
        dotfiles_dir="${checkout_dir}"
    elif [[ -e "${checkout_dir}" ]]; then
        printf '%s already exists but is not a git checkout.\n' "${checkout_dir}" 1>&2
        exit 1
    else
        printf 'Cloning dotfiles into %s\n' "${checkout_dir}" 1>&2
        git clone "${repository_url}" "${checkout_dir}"
        dotfiles_dir="${checkout_dir}"
    fi

    "${dotfiles_dir}/apply.sh"
}

main "$@"
