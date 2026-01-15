#!/usr/bin/env bash

main() {
	local scripts_dir="$HOME/dotfiles/.sh/scripts/"
	local bin_dir="$HOME/.sh/bin"
	mkdir -p "$bin_dir"

	# Remove bin files without corresponding scripts
	for bin_file in "$bin_dir"/*; do
		if [ -f "$bin_file" ]; then
			local filename
			filename=$(basename "$bin_file")
			local corresponding_script="${scripts_dir}${filename}.sh"

			if [ ! -f "$corresponding_script" ]; then
				rm "$bin_file"
			fi
		fi
	done
	#
	# # Copy scripts to bin and make executable
	for script_file in "$scripts_dir"*.sh; do
		if [ -f "$script_file" ]; then
			local script_basename
			script_basename=$(basename "$script_file")
			local basename_without_ext="${script_basename%.sh}"
			local dest_file="${bin_dir}/${basename_without_ext}"

			cp "$script_file" "$dest_file"
			chmod +x "$dest_file"
		fi
	done
}

main "$@"
