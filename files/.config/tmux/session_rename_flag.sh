#!/bin/bash
CURRENT_SESSION=$(tmux display-message -p '#S' 2>/dev/null)
SESSION_RENAME_FLAG="/tmp/tmux_session_renamed_${CURRENT_SESSION}"

if [[ "$(tmux show-option -qv -t "$CURRENT_SESSION:" @manual_session_renamed 2>/dev/null)" == "1" || -f "$SESSION_RENAME_FLAG" ]]; then
    # Session was manually renamed, don't auto-rename
    exit 0
else
    # Session was not manually renamed, proceed with auto-rename
    PANE_PATH=$(tmux list-panes -s -t "$CURRENT_SESSION:" -F '#{window_index}:#{pane_index}:#{pane_current_path}' 2>/dev/null | sort -t: -k1,1n -k2,2n | sed -n '1s/^[^:]*:[^:]*://p')
    BASE_NAME=$(basename "$PANE_PATH" | tr '.' '_')

    if [[ -n "$PANE_PATH" ]]; then
        PROJECT_ROOT=$(git -C "$PANE_PATH" rev-parse --show-toplevel 2>/dev/null)
        if [[ -n "$PROJECT_ROOT" ]]; then
            PROJECT_PATH=$(git -C "$PANE_PATH" rev-parse --show-prefix 2>/dev/null)
            PROJECT_NAME=$(basename "$PROJECT_ROOT")

            if [[ -n "$PROJECT_PATH" ]]; then
                BASE_NAME="$PROJECT_NAME/${PROJECT_PATH%/}"
            else
                BASE_NAME="$PROJECT_NAME"
            fi

            BASE_NAME=$(printf '%s' "$BASE_NAME" | tr '.' '_')
        fi
    fi

    SESSION_NAME="$BASE_NAME"
    COUNT=2

    while tmux list-sessions -F '#S' 2>/dev/null | grep -Fxq "$SESSION_NAME"; do
        if [[ "$SESSION_NAME" == "$CURRENT_SESSION" ]]; then
            break
        fi

        SESSION_NAME="${BASE_NAME}-${COUNT}"
        ((COUNT++))
    done

    tmux rename-session "$SESSION_NAME"
fi
