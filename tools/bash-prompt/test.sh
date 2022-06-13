#!/bin/bash

if [[ "${PROMPT_COMMAND}" != *'__prompt'* ]]; then
    echo "__prompt${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
fi
