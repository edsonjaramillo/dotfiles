#!/usr/bin/env bash
set -Eeuo pipefail

# Functions
needs_docker() {
    if ! command -v docker &>/dev/null; then
        return 1
    fi

    local ANY_DOCKERFILE
    ANY_DOCKERFILE=$(find . -type f \( -iname "dockerfile*" -o -iname "docker-compose*.yml" -o -iname "docker-compose*.yaml" \) -print -quit)
    if [ -n "$ANY_DOCKERFILE" ]; then
        return 0
    fi

    return 1
}

# Run the script
run() {

    # Check that tmux is installed
    if ! command -v tmux &>/dev/null; then
        printf "tmux is not installed. Please install tmux and try again." >&2
        exit 1
    fi

    # Determine session name based on current directory
    session_name="${PWD##*/}"

    # If a tmux session with this name already exists, attach to it.
    if tmux has-session -t "$session_name" 2>/dev/null; then
        tmux attach-session -t "$session_name"
        exit 0
    fi

    # Create new session with a window named "shells"
    tmux new-session -d -s "$session_name" -c "$PWD" -n "shells"
    tmux send-keys -t "$session_name:shells" "clear" C-m

    # Split the window -- and run yazi in it.
    tmux split-window -v -t "$session_name:shells"
    tmux resize-pane -t "$session_name:shells" -D 5
    tmux send-keys -t "$session_name:shells" "yazi" C-m

    if needs_docker; then
        tmux new-window -d -t "$session_name:" -n "docker" -c "$PWD"
        tmux send-keys -t "$session_name:docker" "lazydocker" C-m
    fi

    # If git is installed and the .git directory exists, create a new window named "git" and run lazygit in it.
    if command -v git &>/dev/null && [ -d ".git" ]; then
        tmux new-window -d -t "$session_name:" -n "git" -c "$PWD"
        tmux send-keys -t "$session_name:git" "lazygit" C-m
    fi

    # Finally, attach to the newly created session.
    tmux attach-session -t "$session_name"
}

run
