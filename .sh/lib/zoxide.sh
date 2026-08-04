#!/usr/bin/env bash

zinit() {
	zoxide query --list | while read -r line; do
		zoxide remove "$line"
	done

	find "$HOME/code" -mindepth 1 -maxdepth 1 -type d | while read -r dir; do
		find "$dir" -mindepth 1 -maxdepth 1 -type d | while read -r subdir; do
			zoxide add "$subdir"
		done
	done

	zoxide add "$HOME/.config/nvim/"
	zoxide add "$HOME/.config/system-packages/"
	zoxide add "$HOME/code/"
	zoxide add "$HOME/code/oss/"
	zoxide add "$HOME/code/personal/"
	zoxide add "$HOME/code/playground/"
	zoxide add "$HOME/code/plugins/"
	zoxide add "$HOME/code/work/"
	zoxide add "$HOME/dotfiles/"
}

zlist() {
	zoxide query -l -- "$1" | sed "s|^$HOME/||"
}
