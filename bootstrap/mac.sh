#!/bin/bash

set -e -u -o pipefail

readonly repository_url="${DOTFILES_REPOSITORY_URL:-https://github.com/kamichidu/dotfiles.git}"
readonly checkout_dir="${DOTFILES_DIR:-$HOME/dotfiles}"
script_dir="$(cd "$(dirname "$0")" 2>/dev/null && pwd || true)"

if [[ "$(uname -s)" != "Darwin" ]]; then
    echo "This bootstrap script supports macOS only." 1>&2
    exit 1
fi

if ! command -v curl >/dev/null 2>&1; then
    echo "curl is required." 1>&2
    exit 1
fi

if ! command -v git >/dev/null 2>&1; then
    echo "git is required. Install the Xcode Command Line Tools first:" 1>&2
    echo "  xcode-select --install" 1>&2
    exit 1
fi

if [[ -n "$script_dir" && -f "$script_dir/../apply.sh" ]]; then
    dotfiles_dir="$(cd "$script_dir/.." && pwd)"
elif [[ -d "$checkout_dir/.git" ]]; then
    dotfiles_dir="$checkout_dir"
elif [[ -e "$checkout_dir" ]]; then
    echo "$checkout_dir already exists but is not a git checkout." 1>&2
    exit 1
else
    echo "Cloning dotfiles into $checkout_dir" 1>&2
    git clone "$repository_url" "$checkout_dir"
    dotfiles_dir="$checkout_dir"
fi

"$dotfiles_dir/apply.sh"
