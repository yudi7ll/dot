#!/usr/bin/env bash
set -euo pipefail

target="$*"
if [[ -z "$target" ]]; then
    tmux display-message 'sesh: no session selected for deletion'
    exit 1
fi

if [[ -n "${TMUX_PANE:-}" ]]; then
    current_session=$(tmux display-message -p -t "$TMUX_PANE" '#{session_name}')
else
    current_session=$(tmux display-message -p '#S')
fi

if [[ "$target" == "$current_session" ]]; then
    next_session=
    while IFS= read -r session; do
        if [[ "$session" != "$target" ]]; then
            next_session=$session
            break
        fi
    done < <(tmux list-sessions -F '#{session_name}')

    if [[ -z "$next_session" ]]; then
        next_session=$(tmux new-session -d -P -F '#{session_id}' -c "$HOME")
    fi

    tmux switch-client -t "$next_session"
fi

tmux kill-session -t "$target"
