__prompt() {
    eval "$(bash-prompt)"
}

if [[ "${PROMPT_COMMAND}" != *'__prompt'* ]]; then
    PROMPT_COMMAND="__prompt${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
fi
