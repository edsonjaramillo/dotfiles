dots() {
	local use_all=false
	local action
	local dotfiles_dir="$HOME/dotfiles"

	# Parse arguments
	if [[ "$1" == "--all" ]]; then
		use_all=true
		action="$2"
	else
		action="$1"
	fi

	if [[ "$action" != "link" && "$action" != "unlink" ]]; then
		echo "Usage: dotfiles [--all] {link|unlink}"
		return 1
	fi

	# Determine preview command
	local preview_cmd="cat"
	if command -v bat &>/dev/null; then
		preview_cmd="bat --color=always --style=numbers"
	fi

	# Select or get all files
	local selected
	if [[ "$use_all" == true ]]; then
		selected=$(find "$dotfiles_dir" -type f -not -path '*/\.git/*' |
			sed "s|^$dotfiles_dir/||")
	else
		selected=$(
			find "$dotfiles_dir" -type f -not -path '*/\.git/*' |
				sed "s|^$dotfiles_dir/||" |
				fzf --multi --preview "$preview_cmd $dotfiles_dir/{}"
		)
	fi

	if [[ -z "$selected" ]]; then
		echo "No files selected"
		return 0
	fi

	while IFS= read -r rel_path; do
		local source="$dotfiles_dir/$rel_path"
		local target="$HOME/$rel_path"

		if [[ "$action" == "link" ]]; then
			mkdir -p "$(dirname "$target")"

			if [[ -e "$target" && ! -L "$target" ]]; then
				echo "Warning: $target exists and is not a symlink. Skipping."
			else
				ln -sf "$source" "$target"
				echo "✓ Linked: $rel_path"
			fi
		else
			if [[ -L "$target" ]]; then
				rm "$target"
				echo "✓ Unlinked: $rel_path"
			else
				echo "Not a symlink: $target. Skipping."
			fi
		fi
	done <<<"$selected"
}
