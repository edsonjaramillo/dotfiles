#!/usr/bin/env bash

# Appends a directory and its depth-1 subdirectories (non-hidden) to the
# caller's `directories` array.
_zinit_with_children() {
	local parent="$1"
	local child

	[[ -d "$parent" ]] || return 0

	directories+=("$parent")
	while IFS= read -r -d '' child; do
		directories+=("$child")
	done < <(fd --no-ignore --type directory --exact-depth 1 --print0 . "$parent")
}

zinit() {
	local -a entries=()
	local -a directories=()
	local directory

	while IFS= read -r directory; do
		entries+=("$directory")
	done < <(zoxide query --list)

	if ((${#entries[@]})); then
		zoxide remove "${entries[@]}"
	fi

	if [[ -d "$HOME/code" ]]; then
		while IFS= read -r -d '' directory; do
			directories+=("$directory")
		done < <(fd --hidden --no-ignore --type directory --exact-depth 2 --print0 . "$HOME/code")
	fi

	for directory in \
		"$HOME/.config/bond/" \
		"$HOME/.config/system-packages/" \
		"$HOME/code/"; do
		_zinit_with_children "$directory"
	done

	for directory in \
		"$HOME/.config/" \
		"$HOME/.config/nvim/" \
		"$HOME/.pi/agent/" \
		"$HOME/dotfiles/"; do
		if [[ -d "$directory" ]]; then
			directories+=("$directory")
		fi
	done

	if ((${#directories[@]})); then
		zoxide add "${directories[@]}"
	fi
}

zlist() {
	zoxide query -l -- "$1" | sed "s|^$HOME/||"
}
