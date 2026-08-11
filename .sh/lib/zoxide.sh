#!/usr/bin/env bash

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
		"$HOME/.config/nvim/" \
		"$HOME/.config/system-packages/" \
		"$HOME/.pi/agent/" \
		"$HOME/code/" \
		"$HOME/code/oss/" \
		"$HOME/code/personal/" \
		"$HOME/code/playground/" \
		"$HOME/code/plugins/" \
		"$HOME/code/work/" \
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
