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
		"$HOME/.config/" \
		"$HOME/.config/bond/instructions/" \
		"$HOME/.config/bond/resources/" \
		"$HOME/.config/bond/skills/" \
		"$HOME/.config/nvim/" \
		"$HOME/.config/system-packages/" \
		"$HOME/.config/system-packages/brew/" \
		"$HOME/.config/system-packages/bun/" \
		"$HOME/.config/system-packages/nix/" \
		"$HOME/.config/system-packages/npm/" \
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
