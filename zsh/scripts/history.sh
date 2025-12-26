hsd() {
	# Check if atuin is installed
	if ! command -v atuin &>/dev/null; then
		echo "Error: atuin is not installed or not in PATH" >&2
		return 1
	fi

	# Check if an argument was provided
	if [[ $# -lt 1 ]]; then
		echo "Usage: hsd <search_pattern>" >&2
		echo "Searches atuin history with the pattern and prompts for deletion" >&2
		return 1
	fi

	atuin search "$1" --delete
}
