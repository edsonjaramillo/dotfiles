source_dir() {
	local dir="${1:-.}"
	local file

	[[ -d "$dir" ]] || {
		print -u2 "source_dir: not a directory: $dir"
		return 1
	}

	for file in "$dir"/*(.N); do
		source "$file" || return
	done
}

has_command() {
	(( $# )) && command -v "$1" >/dev/null 2>&1
}
