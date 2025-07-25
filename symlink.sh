#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Array of dotfiles to link
VALID_FILES=(
    ".gitconfig"
    ".hstr_favorites"
    ".node-version"
    ".tmux.conf"
    ".wezterm.lua"
    ".zprofile"
    ".zshrc"
    ".config/fastfetch/ascii/pikachu.txt"
    ".config/fastfetch/config.jsonc"
    ".config/oh-my-posh/themes/earthshine.omp.json"
    ".config/wezterm/earthshine/colors/init.lua"
    ".config/wezterm/earthshine/init.lua"
    ".config/wezterm/wallpapers/151.jpg"
    ".config/yazi/yazi.toml"
    ".sh/aliases/docker.aliases.sh"
    ".sh/aliases/replacement.aliases.sh"
    ".sh/aliases/scripts.aliases.sh"
    ".sh/aliases/system.aliases.sh"
    ".sh/functions/media.functions.zsh"
    ".sh/functions/search.functions.zsh"
    ".sh/functions/utility.functions.zsh"
    ".sh/functions/zoxide.functions.sh"
    ".sh/plugins/core.plugins.zsh"
    ".sh/plugins/history.plugins.zsh"
    "scripts/start-tmux.sh"
)

# >>>>>>>>>>>>>>> Commands <<<<<<<<<<<<<<<

link() {
    for relative_path in "${VALID_FILES[@]}"; do
        source_file="$SCRIPT_DIR/$relative_path"
        link_path="$HOME/$relative_path"

        # Check if the file exists
        if [[ ! -e "$source_file" ]]; then
            echo "WARNING: $source_file does not exist. Skipping..." >&2
            continue
        fi

        # check if the file is a symlink
        if [[ -L "$source_file" ]]; then
            echo "Skipping $source_file because it is a symlink." >&2
            continue
        fi

        # If the file already exists, skip it
        if [[ -e "$link_path" ]]; then
            continue
        fi

        # Create the directory if it doesn't exist
        mkdir -p "$(dirname "$link_path")"

        # Create the symlink
        ln -sf "$source_file" "$link_path"
        SANITIZED_FILE="${source_file//$HOME/\~}"
        echo "$SANITIZED_FILE -> $link_path"
    done
}

unlink() {
    for relative_path in "${VALID_FILES[@]}"; do
        link_path="$HOME/$relative_path"

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