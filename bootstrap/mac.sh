#!/bin/bash

set -euo pipefail

main() {
    local repository_url="${DOTFILES_REPOSITORY_URL:-https://github.com/kamichidu/dotfiles.git}"
    local checkout_dir="${DOTFILES_DIR:-${HOME}/dotfiles}"
    local script_dir
    local dotfiles_dir

    script_dir="$(cd "$(dirname "${0}")" 2>/dev/null && pwd || true)"

    if [[ "$(uname -s)" != "Darwin" ]]; then
        printf '%s\n' 'This bootstrap script supports macOS only.' 1>&2
        exit 1
    fi

    if ! command -v curl >/dev/null 2>&1; then
        printf '%s\n' 'curl is required.' 1>&2
        exit 1
    fi

    if ! command -v git >/dev/null 2>&1; then
        printf '%s\n' 'git is required. Install the Xcode Command Line Tools first:' 1>&2
        printf '%s\n' '  xcode-select --install' 1>&2
        exit 1
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
