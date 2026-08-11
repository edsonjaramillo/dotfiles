#!/usr/bin/env bash

zinit() {
	local -a entries=()
	local -a directories=()
	local path

	while IFS= read -r path; do
		entries+=("$path")
	done < <(zoxide query --list)

	if ((${#entries[@]})); then
		zoxide remove "${entries[@]}"
	fi

	while IFS= read -r -d '' path; do
		directories+=("$path")
	done < <(find "$HOME/code" -mindepth 2 -maxdepth 2 -type d -print0)

	directories+=(
		"$HOME/.config/nvim/"
		"$HOME/.config/system-packages/"
		"$HOME/code/"
		"$HOME/code/oss/"
		"$HOME/code/personal/"
		"$HOME/code/playground/"
		"$HOME/code/plugins/"
		"$HOME/code/work/"
		"$HOME/dotfiles/"
	)

	zoxide add "${directories[@]}"
}

zlist() {
	zoxide query -l -- "$1" | sed "s|^$HOME/||"
}
