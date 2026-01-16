#!/usr/bin/env bash

hh() {
	local command="${1:-}"
	shift

	case "$command" in
	dsearch)
		_hh_dsearch
		;;
	derrors)
		_hh_derrors
		;;
	sync)
		_hh_sync
		;;
	help | --help | -h | "")
		_hh_help
		;;
	*)
		echo "hh: unknown command: $command" >&2
		_hh_help >&2
		return 1
		;;
	esac
}

_hh_help() {
	cat <<EOF
Usage: hh <command> [arguments]

Commands:
  derrors              Delete all commands that failed (non-zero exit)
  dsearch              Interactively delete history with fzf (multi-select)
  sync                 Sync shell history from atuin to HISTFILE
  help                 Show this help message

Examples:
  hh derrors
  hh dsearch
  hh sync
EOF
}

_hh_derrors() {
	if ! command -v atuin &>/dev/null; then
		echo "hh: error: atuin is not installed or not in PATH" >&2
		return 1
	fi

	atuin search --exclude-exit=0 --delete-it-all 2>/dev/null
	echo "History cleaned!"
}

_hh_dsearch() {
	if ! command -v atuin &>/dev/null; then
		echo "hh: error: atuin is not installed or not in PATH" >&2
		return 1
	fi

	if ! command -v fzf &>/dev/null; then
		echo "hh: error: fzf is not installed or not in PATH" >&2
		return 1
	fi

	local selected
	selected=$(atuin search "" --format "{command}" --limit 2000 |
		fzf --multi --layout=reverse --height=80% \
			--bind "alt-a:select-all" \
			--prompt="Select entries to delete> " \
			--header="TAB: toggle | ALT-A: select all | ENTER: delete")

	if [[ -z "$selected" ]]; then
		return 0
	fi

	local count=0
	while IFS='|' read -r cmd; do
		if [[ -n "$cmd" ]]; then
			atuin search "$cmd" --delete 2>/dev/null
			((count++))
		fi
	done <<<"$selected"

	echo "Deleted $count entries"
}

_hh_sync() {
	atuin history list --format "{command}" | sort -u >"${HISTFILE}"
}
