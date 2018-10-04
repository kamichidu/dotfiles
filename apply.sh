#!/bin/bash

set -u -e -o pipefail

dotfilesdir="$(cd "$(dirname "$0")"; pwd)"

if [[ -z "${1+xxx}" ]]; then
    basedir="$HOME"
else
    basedir="$1"
fi

if [[ ! -d "$basedir" ]]; then
    echo "make directory $basedir" 1>&2
    mkdir -p "$basedir"
fi

function apply()
{
    local srcpath="$1"
    local destpath="$2"

    if [[ -x "$destpath" ]]; then
        echo "[skip] $srcpath ===> $destpath" 1>&2
	return 0
    fi

    # mkdir for parent dir
    local destparentdir="$(dirname "$destpath")"
    local destbasename="$(basename "$destpath")"
    if [[ ! -d "$destparentdir" ]]; then
        echo "make directory $destparentdir" 1>&2
        mkdir -p "$destparentdir"
    fi

    echo "[symlink] $srcpath ===> $destpath" 1>&2
    ln -s "$srcpath" "$destpath"
}

echo "applying to $basedir" 1>&2
apply "$dotfilesdir/vimrc" "$basedir/.vimrc"
apply "$dotfilesdir/gvimrc" "$basedir/.gvimrc"
apply "$dotfilesdir/vimfiles" "$basedir/.vim"
apply "$dotfilesdir/bundles" "$basedir/.hariti/bundles"
