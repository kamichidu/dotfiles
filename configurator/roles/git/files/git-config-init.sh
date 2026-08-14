#!/bin/bash

set -e -u

__script_dir="${HOME}/.config/git-config-init/"
mkdir -p "${__script_dir}"
__script="$(ls "${__script_dir}" 2>/dev/null | peco)"
if [[ -z "${__script}" ]]; then
    exit 0
fi

"${SHELL}" "${__script_dir}/${__script}"
