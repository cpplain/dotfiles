#!/bin/bash

input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)

BAR_WIDTH=10
FILLED=$((PCT * BAR_WIDTH / 100))
EMPTY=$((BAR_WIDTH - FILLED))
BAR=""
[ "$FILLED" -gt 0 ] && BAR=$(printf "%${FILLED}s" | tr ' ' '▓')
[ "$EMPTY" -gt 0 ] && BAR="${BAR}$(printf "%${EMPTY}s" | tr ' ' '░')"

CWD=$(echo "$input" | jq -r ".workspace.current_dir")
DIR=$(basename "$CWD")
BRANCH=$(git rev-parse --git-dir >/dev/null 2>&1 && git branch --show-current 2>/dev/null)

echo "[$MODEL] $BAR $PCT% | $DIR${BRANCH:+ ($BRANCH)}"
