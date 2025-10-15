#!/usr/bin/env bash

set -euo pipefail

# Dependencies
readonly DEPS=("tmux" "fd" "gum")
readonly CODE_DIR="${CODE_DIR:-$HOME/code}"

# Manually defined projects (add your custom paths here)
readonly MANUAL_PROJECTS=(
	"$HOME/dotfiles/"
)

# Check dependencies
check_dependencies() {
	local missing=()
	for dep in "${DEPS[@]}"; do
		if ! command -v "$dep" &>/dev/null; then
			missing+=("$dep")
		fi
	done

	if [ ${#missing[@]} -gt 0 ]; then
		echo "Error: Missing dependencies: ${missing[*]}" >&2
		echo "Please install them before running this script." >&2
		exit 1
	fi
}

# Get all available projects
get_all_projects() {
	local projects=()

	# Add manual projects from array
	for project in "${MANUAL_PROJECTS[@]}"; do
		if [ -d "$project" ]; then
			projects+=("$project")
		fi
	done

	# Add projects found by fd
	if [ -d "$CODE_DIR" ]; then
		while IFS= read -r project; do
			projects+=("$project")
		done < <(
			fd --type d --max-depth 2 --min-depth 2 \
				--hidden --exclude .git . "$CODE_DIR" 2>/dev/null || true
		)
	fi

	# Remove duplicates and sort
	printf '%s\n' "${projects[@]}" | sort -u
}

# Create or attach to tmux session
create_or_attach_session() {
	local session_name="$1"
	local working_dir="$2"
	local needs_attachded="${3:-true}"

	if tmux has-session -t "$session_name" 2>/dev/null; then
		echo "Session '$session_name' already exists. Attaching..."
		tmux attach-session -t "$session_name"
		return 0
	fi

	# Create new session
	tmux new-session -d -s "$session_name" -c "$working_dir"

	# Setup editor window
	tmux rename-window -t "$session_name:1" "editor"
	tmux send-keys -t "$session_name:editor" "nvim" C-m

	# Setup shells window with horizontal split
	tmux new-window -d -t "$session_name" -n "shells" -c "$working_dir"
	tmux split-window -h -t "$session_name:shells" -c "$working_dir"

	if [ "$needs_attachded" = true ]; then
		tmux attach-session -t "$session_name"
	fi
}

# Open current workspace
open_current_workspace() {
	local session_name
	session_name=$(basename "$PWD")
	create_or_attach_session "$session_name" "$PWD"
}

# Select and attach to existing session
open_existing_session() {
	local sessions
	sessions=$(tmux ls 2>/dev/null | awk -F: '{print $1}') || {
		echo "No existing tmux sessions found."
		return 1
	}

	local selected
	selected=$(echo "$sessions" | gum choose --header "Select a session:")

	if [ -n "$selected" ]; then
		tmux attach-session -t "$selected"
	else
		echo "No session selected."
		return 1
	fi
}

# Create new session from project directory
create_new_session() {
	local projects
	projects=$(get_all_projects)

	if [ -z "$projects" ]; then
		echo "No projects found." >&2
		echo "Configure projects in:" >&2
		echo "  - Script: MANUAL_PROJECTS array" >&2
		echo "  - Auto-discover: $CODE_DIR" >&2
		return 1
	fi

	local selected_path
	selected_path=$(echo "$projects" | gum choose --header "Select a project:")

	if [ -n "$selected_path" ]; then
		local session_name
		session_name=$(basename "$selected_path")
		create_or_attach_session "$session_name" "$selected_path"
	else
		echo "No project selected."
		return 1
	fi
}

create_all_projects() {
	local projects
	projects=$(get_all_projects)

	if [ -z "$projects" ]; then
		echo "No projects found." >&2
		return 1
	fi

	while IFS= read -r project; do
		local session_name
		session_name=$(basename "$project")
		echo "Creating or attaching to session '$session_name' for project '$project'..."
		create_or_attach_session "$session_name" "$project" false
	done <<<"$projects"

	echo "All sessions created."
}

# Main menu
main() {
	check_dependencies

	local current_dir
	current_dir=$(basename "$PWD")

	local choice
	choice=$(
		gum choose \
			--header "Tmux Session Manager" \
			"Current Workspace: $current_dir" \
			"Open existing session" \
			"Create new session" \
			"Create sessions for all projects" \
			"Quit"
	)

	case "$choice" in
	"Current Workspace: $current_dir")
		open_current_workspace
		;;
	"Open existing session")
		open_existing_session
		;;
	"Create new session")
		create_new_session
		;;
	"Create sessions for all projects")
		create_all_projects
		;;
	"Quit")
		echo "Exiting..."
		exit 0
		;;
	*)
		echo "Invalid choice. Exiting..."
		exit 1
		;;
	esac
}

main "$@"
