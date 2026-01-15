#!/usr/bin/env bash

readonly COMPLETIONS_DIR="$HOME/dotfiles/.sh/completions"
readonly OUTPUT_DIR="$HOME/.sh/site-functions"

remove_extension() {
	local filename="${1##*/}" # Remove path
	echo "${filename%.yaml}"  # Remove .yaml extension
}

generate_completions() {
	local file="$1"
	local base_name
	base_name="$(remove_extension "$file")"
	local bash_filename="${base_name}.bash"

	echo "Generating: $bash_filename"
	completely generate "$file" "$OUTPUT_DIR/$bash_filename"
}

main() {
	if ! command -v completely &>/dev/null; then
		echo "Error: completely command not found" >&2
		exit 1
	fi

	if [[ ! -d "$COMPLETIONS_DIR" ]]; then
		echo "Error: completions directory not found: $COMPLETIONS_DIR" >&2
		exit 1
	fi

	mkdir -p "$OUTPUT_DIR"

	shopt -s nullglob
	local yaml_files=("$COMPLETIONS_DIR"/*.yaml)
	shopt -u nullglob

	if [[ ${#yaml_files[@]} -eq 0 ]]; then
		echo "No YAML completion files found in $COMPLETIONS_DIR"
		exit 0
	fi

	for file in "${yaml_files[@]}"; do
		generate_completions "$file"
	done

	echo "Successfully generated ${#yaml_files[@]} completion file(s)"
}

main "$@"
