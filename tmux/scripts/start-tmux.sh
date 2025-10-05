#!/usr/bin/env bash

# Get current directory name (basename of $PWD)
base_name=$(basename "$PWD")

# Build possible tmux session names
session_primary="${base_name}-primary"
session_secondary="${base_name}-secondary"

# Use gum to let the user choose between them
session_choice=$(echo -e "${session_primary}\n${session_secondary}" | gum choose)

if [ -z "$session_choice" ]; then
	echo "No session selected. Exiting."
	exit 1
fi

# Check if the selected session already exists
if tmux has-session -t "$session_choice" 2>/dev/null; then
	echo "Attaching to existing session: $session_choice"
	tmux attach-session -t "$session_choice"
fi

tmux new-session -d -t "$base_name" -s "$session_choice" -A

echo "Created and attached to new session: $session_choice"

# Rename the first window to "editor"
tmux rename-window -t "$base_name:1" "editor"
tmux send-keys -t "$base_name:editor" "nvim" C-m

tmux new-window -d -t "$base_name" -n "shells" -c "$PWD"
tmux split-window -h -t "$base_name:shells" -c "$PWD"

# If git exists and .git directory exists, create a git window
if command -v git &>/dev/null && [ -d ".git" ]; then
	tmux new-window -d -t "$base_name" -n "git" -c "$PWD"
	tmux send-keys -t "$base_name:git" "lazygit" C-m
fi

tmux attach-session -t "$session_choice"
