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
bindkey -M emacs '^E' edit-command-line
bindkey -M viins '^E' edit-command-line
bindkey -M vicmd '^E' edit-command-line

# Select a word from the current command line and move the cursor to its start.
_fzf_jump_to_word_widget() {
	if ! command -v fzf >/dev/null; then
		zle -M 'Ctrl-X Ctrl-W requires fzf'
		return 1
	fi

	local -a candidates
	local char word selected
	local -i index=1 start length=${#BUFFER}

	while ((index <= length)); do
		char=${BUFFER[index]}
		if [[ $char == [[:space:]] ]]; then
			((index++))
			continue
		fi

		start=$index
		word=''
		while ((index <= length)); do
			char=${BUFFER[index]}
			[[ $char == [[:space:]] ]] && break
			word+=$char
			((index++))
		done

		# CURSOR is zero-based; include the offset to distinguish duplicate words.
		candidates+=("$((start - 1))"$'\t'"$word")
	done

	if ((!${#candidates})); then
		zle -M 'The command line contains no words'
		return 1
	fi

	selected=$(printf '%s\n' "${candidates[@]}" | fzf \
		--layout=reverse \
		--border \
		--delimiter=$'\t' \
		--with-nth=2.. \
		--prompt='Jump to word> ') || return

	CURSOR=${selected%%$'\t'*}
	zle redisplay
}

zle -N _fzf_jump_to_word_widget
# Ctrl-F is currently free in the active vi insert keymap.
bindkey -M viins '^F' _fzf_jump_to_word_widget
# Keep the longer binding as a fallback in every keymap.
bindkey -M emacs '^X^W' _fzf_jump_to_word_widget
bindkey -M viins '^X^W' _fzf_jump_to_word_widget
bindkey -M vicmd '^X^W' _fzf_jump_to_word_widget

# Show unassigned Ctrl-letter and Ctrl-X Ctrl-letter bindings.
# Pass a keymap name to inspect another map, e.g. `available-keybinds emacs`.
available-keybinds() {
	local keymap=${1:-main}
	local description widget key prefix
	local -a letters ctrl_keys ctrl_x_keys
	local -i code prefix_code=24

	if ! bindkey -M "$keymap" >/dev/null 2>&1; then
		print -u2 -- "Unknown ZLE keymap: $keymap"
		return 1
	fi

	letters=({A..Z})
	prefix=${(#)prefix_code}

	for code in {1..26}; do
		key=${(#)code}

		description=$(bindkey -M "$keymap" "$key" 2>/dev/null)
		widget=${description##* }
		# Ctrl-X is a prefix for the two-key bindings below, not truly free.
		[[ $code != 24 && $widget == (undefined-key|self-insert) ]] && ctrl_keys+=("Ctrl-${letters[code]}")

		description=$(bindkey -M "$keymap" "$prefix$key" 2>/dev/null)
		widget=${description##* }
		[[ $widget == (undefined-key|self-insert) ]] && ctrl_x_keys+=("Ctrl-X Ctrl-${letters[code]}")
	done

	print -- "Available bindings in the '$keymap' keymap:"
	print -- "  Ctrl-letter:        ${(j:, :)ctrl_keys}"
	print -- "  Ctrl-X Ctrl-letter: ${(j:, :)ctrl_x_keys}"
	print -- 'A key is considered available when it is undefined or inserts itself.'
}
