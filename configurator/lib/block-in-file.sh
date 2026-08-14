#!/bin/bash

set -euo pipefail

line-number() {
    local target_file="${1}"
    local marker="${2}"
    local match

    match="$(grep -nFxm 1 -- "${marker}" "${target_file}" || true)"
    printf '%s\n' "${match%%:*}"
}

main() {
    local target_file="${1}"
    local marker_template="${2}"
    local begin_marker
    local end_marker
    local block_file
    local output_file
    local begin_count
    local end_count
    local begin_line
    local end_line

    if [[ "${marker_template}" != *'{mark}'* ]]; then
        printf '%s\n' 'marker template must contain {mark}.' 1>&2
        return 1
    fi

    begin_marker="${marker_template/\{mark\}/BEGIN}"
    end_marker="${marker_template/\{mark\}/END}"

    mkdir -p "$(dirname "${target_file}")"
    touch "${target_file}"

    begin_count="$(grep -Fxc -- "${begin_marker}" "${target_file}" || true)"
    end_count="$(grep -Fxc -- "${end_marker}" "${target_file}" || true)"
    if [[ "${begin_count}" != "${end_count}" || "${begin_count}" -gt 1 ]]; then
        printf 'invalid markers in %s\n' "${target_file}" 1>&2
        return 1
    fi

    block_file="$(mktemp "${target_file}.block.XXXXXX")"
    output_file="$(mktemp "${target_file}.output.XXXXXX")"
    cat >"${block_file}"

    if [[ "${begin_count}" -eq 1 ]]; then
        begin_line="$(line-number "${target_file}" "${begin_marker}")"
        end_line="$(line-number "${target_file}" "${end_marker}")"
        if [[ "${begin_line}" -ge "${end_line}" ]]; then
            printf 'invalid marker order in %s\n' "${target_file}" 1>&2
            rm -f "${block_file}" "${output_file}"
            return 1
        fi

        if [[ "${begin_line}" -gt 1 ]]; then
            head -n "$((begin_line - 1))" "${target_file}" >"${output_file}"
        else
            : >"${output_file}"
        fi
    else
        cat "${target_file}" >"${output_file}"
        if [[ -s "${target_file}" ]]; then
            printf '\n' >>"${output_file}"
        fi
    fi

    printf '%s\n' "${begin_marker}" >>"${output_file}"
    cat "${block_file}" >>"${output_file}"
    if [[ -s "${block_file}" && -n "$(tail -c 1 "${block_file}")" ]]; then
        printf '\n' >>"${output_file}"
    fi
    printf '%s\n' "${end_marker}" >>"${output_file}"

    if [[ "${begin_count}" -eq 1 ]]; then
        tail -n "+$((end_line + 1))" "${target_file}" >>"${output_file}"
    fi

    cat "${output_file}" >"${target_file}"
    rm -f "${block_file}" "${output_file}"
}

main "$@"
