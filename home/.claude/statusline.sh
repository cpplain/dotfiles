#!/bin/bash

input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
TOTAL=$(echo "$input" | jq -r '.context_window.context_window_size // 0')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
USED=$((PCT * TOTAL / 100))

fmt_k() {
    local n=$1
    if [ "$n" -ge 1000000 ]; then
        echo "$((n / 1000000))M"
    elif [ "$n" -ge 1000 ]; then
        echo "$((n / 1000))k"
    else
        echo "${n}"
    fi
}

USED_FMT=$(fmt_k "$USED")
TOTAL_FMT=$(fmt_k "$TOTAL")

CWD=$(echo "$input" | jq -r ".workspace.current_dir")
DIR=$(basename "$CWD")
BRANCH=$(git rev-parse --git-dir >/dev/null 2>&1 && git branch --show-current 2>/dev/null)

echo "$MODEL · ${USED_FMT}/${TOTAL_FMT} (${PCT}%) · $DIR${BRANCH:+ ($BRANCH)}"
