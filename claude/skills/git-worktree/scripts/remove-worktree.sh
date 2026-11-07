#!/usr/bin/env bash
exec fish -c 'remove_worktree $argv' -- "$@"
