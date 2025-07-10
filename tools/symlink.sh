#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$PWD"

# Array of dotfiles to link
VALID_FILES=(
    "$SCRIPT_DIR/.hstr_favorites"
    "$SCRIPT_DIR/.node-version"
    "$SCRIPT_DIR/.tmux.conf"
    "$SCRIPT_DIR/.wezterm.lua"
    "$SCRIPT_DIR/.zprofile"
    "$SCRIPT_DIR/.zshrc"
    "$SCRIPT_DIR/.config/fastfetch/ascii/pikachu.txt"
    "$SCRIPT_DIR/.config/fastfetch/config.jsonc"
    "$SCRIPT_DIR/.config/oh-my-posh/themes/earthshine.omp.json"
    "$SCRIPT_DIR/.config/wezterm/wallpapers/151.jpg"
    "$SCRIPT_DIR/.config/yazi/yazi.toml"
    "$SCRIPT_DIR/.sh/aliases/docker.aliases.sh"
    "$SCRIPT_DIR/.sh/aliases/replacement.aliases.sh"
    "$SCRIPT_DIR/.sh/aliases/scripts.aliases.sh"
    "$SCRIPT_DIR/.sh/aliases/system.aliases.sh"
    "$SCRIPT_DIR/.sh/functions/search.functions.zsh"
    "$SCRIPT_DIR/.sh/functions/utility.functions.zsh"
    "$SCRIPT_DIR/.sh/functions/zoxide.functions.sh"
    "$SCRIPT_DIR/.sh/plugins/core.plugins.zsh"
    "$SCRIPT_DIR/.sh/plugins/history.plugins.zsh"
    "$SCRIPT_DIR/scripts/start-tmux.sh"
)

# >>>>>>>>>>>>>>> Functions <<<<<<<<<<<<<<<

_get_link_path() {
    local file="$1"
    # Strip the SCRIPT_DIR portion from the front
    local relative_path="${file#"$SCRIPT_DIR"/}"
    # Construct the new path in the user's home directory
    echo "$HOME/$relative_path"
}

# >>>>>>>>>>>>>>> Commands <<<<<<<<<<<<<<<

link() {
    for FILE in "${VALID_FILES[@]}"; do
        # Check if the file exists
        if [[ ! -e "$FILE" ]]; then
            echo "WARNING: $FILE does not exist. Skipping..." >&2
            continue
        fi

        # check if the file is a symlink
        if [[ -L "$FILE" ]]; then
            echo "Skipping $FILE because it is a symlink." >&2
            continue
        fi

        link_path=$(_get_link_path "$FILE")
        # If the file already exists, skip it
        if [[ -e "$link_path" ]]; then
            continue
        fi

        # Create the directory if it doesn't exist
        mkdir -p "$(dirname "$link_path")"

        # Create the symlink
        ln -sf "$FILE" "$link_path"
        SANITIZED_FILE="${FILE//$HOME/\~}"
        echo "$SANITIZED_FILE -> $link_path"
    done

}

unlink() {

    for FILE in "${VALID_FILES[@]}"; do
        link_path=$(_get_link_path "$FILE")
        # Check if the symlink exists and remove it
        if [[ -L "$link_path" ]]; then
            rm -f "$link_path"
        elif [[ -e "$link_path" ]]; then
            printf "Skipping %s because it exists but is not a symlink.\n" "$link_path" >&2
        fi
    done

}

usage() {
    printf "Usage: %s <link|unlink>\n" "$0"
    printf "  link   - Create symbolic links in %s\n" "$HOME"
    printf "  unlink - Remove symbolic links in %s\n" "$HOME"
    exit 1
}

run() {
    case "${1:-}" in
    link) link ;;
    unlink) unlink ;;
    *) usage ;;
    esac
}

# >>>>>>>>>>>>>>> Main <<<<<<<<<<<<<<<

# If no arguments are provided, show the usage
if [[ $# -eq 0 ]]; then
    usage
fi

run "$1"
