source_dir() {
	local dir="${1:-.}"

	if [[ ! -d "$dir" ]]; then
		echo "Error: '$dir' is not a valid directory" >&2
		return 1
	fi

	for file in "$dir"/*; do
		if [[ -f "$file" ]]; then
			source "$file"
		fi
	done
}

has_command() {
	if command -v "$1" >/dev/null; then
		return 0
	fi
	[[ "$2" == "--verbose" ]] && echo "Command '$1' not found." >&2
	return 1
}
