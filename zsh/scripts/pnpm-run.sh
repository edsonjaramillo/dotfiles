#!/usr/bin/env bash

set -euo pipefail

# Find all package.json files
mapfile -t package_files < <(fd -t f '^package\.json$' -E node_modules)

if [ ${#package_files[@]} -eq 0 ]; then
	echo "No package.json files found"
	exit 1
fi

# Build a list of scripts with their locations
scripts=()
declare -A script_map

for pkg_file in "${package_files[@]}"; do
	pkg_dir=$(dirname "$pkg_file")
	pkg_name=$(jq -r '.name // "unnamed"' "$pkg_file")

	# Get all script names from this package.json
	readarray -t script_names < <(jq -r '.scripts // {} | keys[]' "$pkg_file")

	for script_name in "${script_names[@]}"; do
		# Create a display entry: "package-name: script-name (path)"
		display="$pkg_name: $script_name ($pkg_dir)"
		scripts+=("$display")

		# Map display to directory and script name
		script_map["$display"]="$pkg_dir|$script_name"
	done
done

if [ ${#scripts[@]} -eq 0 ]; then
	echo "No scripts found in package.json files"
	exit 1
fi

# Use fzf to select a script
selected=$(printf '%s\n' "${scripts[@]}" | fzf --prompt="Select script: " \
	--height=40% --layout=reverse --border)

if [ -z "$selected" ]; then
	echo "No script selected"
	exit 0
fi

# Extract directory and script name
IFS='|' read -r target_dir script_name <<<"${script_map[$selected]}"

# Run the script from its directory
echo "Running '$script_name' in $target_dir"
cd "$target_dir"
pnpm run "$script_name"
