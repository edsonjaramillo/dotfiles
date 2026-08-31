# Search from $HOME and insert the selected paths at the cursor.
# Inside fzf: Ctrl-A = all, Ctrl-F = files, Ctrl-D = directories.
_fzf_home_widget() {
	if ! command -v fzf >/dev/null || ! command -v fd >/dev/null; then
		zle -M 'Ctrl-T requires fzf and fd'
		return 1
	fi

	local -a fd_options
	fd_options=(
		--hidden
		--no-ignore
		--follow
		--exclude .cache
		--exclude .git
		--exclude .local/share
		--exclude .local/state
		--exclude .npm
		--exclude /Applications
		--exclude /Desktop
		--exclude /Documents
		--exclude /Downloads
		--exclude /Library
		--exclude /Movies
		--exclude /Music
		--exclude /Pictures
		--exclude /Public
		--exclude node_modules
	)

	# fzf's reload action executes these commands through the shell.
	local options="${(j: :)${(@q)fd_options}}"
	local home="${(q)HOME}"
	local all_cmd="fd $options . $home"
	local files_cmd="fd $options --type file . $home"
	local dirs_cmd="fd $options --type directory . $home"
	# Do not use `path` as a local name: in zsh it is tied to PATH.
	local selected selected_path

	selected=$(fd "${fd_options[@]}" . "$HOME" | fzf \
		--multi \
		--layout=reverse \
		--border \
		--prompt='All> ' \
		--header='Ctrl-A: all  Ctrl-F: files  Ctrl-D: directories' \
		--bind "ctrl-a:reload($all_cmd)+change-prompt(All> )" \
		--bind "ctrl-f:reload($files_cmd)+change-prompt(Files> )" \
		--bind "ctrl-d:reload($dirs_cmd)+change-prompt(Directories> )") || return

	for selected_path in ${(f)selected}; do
		LBUFFER+="${(q)selected_path} "
	done
	zle redisplay
}

zle -N _fzf_home_widget
bindkey -M emacs '^T' _fzf_home_widget
bindkey -M viins '^T' _fzf_home_widget

# Open the current command line in $VISUAL or $EDITOR, then return it to the prompt.
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M emacs '^G' edit-command-line
bindkey -M viins '^G' edit-command-line
bindkey -M vicmd '^G' edit-command-line
