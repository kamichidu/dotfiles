#!/bin/bash

set -e -u -o pipefail

readonly repository_url="${DOTFILES_REPOSITORY_URL:-https://github.com/kamichidu/dotfiles.git}"
readonly checkout_dir="${DOTFILES_DIR:-$HOME/dotfiles}"
script_dir="$(cd "$(dirname "$0")" 2>/dev/null && pwd || true)"

if [[ "$(uname -s)" != "Linux" ]]; then
    echo "This bootstrap script supports Linux only." 1>&2
    exit 1
fi

if [[ ! -r /etc/os-release ]]; then
    echo "Unable to identify this Linux distribution." 1>&2
    exit 1
fi

# shellcheck disable=SC1091
. /etc/os-release
case " ${ID:-} ${ID_LIKE:-} " in
    *debian*|*ubuntu*) ;;
    *)
        echo "This bootstrap script currently supports Debian-based Linux only." 1>&2
        exit 1
        ;;
esac

if ! command -v git >/dev/null 2>&1; then
    if ! command -v sudo >/dev/null 2>&1; then
        echo "sudo is required to install git." 1>&2
        exit 1
    fi
    echo "Installing git" 1>&2
    sudo apt-get update
    sudo apt-get install -y git
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
