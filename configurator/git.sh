#!/bin/bash

set -euo pipefail

main() {
    local script_dir

    if ! command -v git >/dev/null 2>&1; then
        printf '%s\n' 'git is required.' 1>&2
        return 1
    fi

    script_dir="$(cd "$(dirname "${0}")" && pwd)"

    "${script_dir}/lib/block-in-file.sh" \
        "${HOME}/.gitignore" \
        '# {mark} this section managed by dotfiles' \
        <"${script_dir}/assets/gitignore"

    git config --global url.git@github.com:.insteadOf https://github.com/
    git config --global core.excludesfile '~/.gitignore'
}

main "$@"
