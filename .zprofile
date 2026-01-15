# Base
export EDITOR=nvim

# Eza
export EZA_ICONS_AUTO="always"

# add extracted language servers to PATH
VSCODE_LANGSERVERS_EXTRACTED_BIN="$HOME/.nix-profile/lib/node_modules/vscode-langservers-extracted/bin"
GEM_BIN="$HOME/.local/share/gem/ruby/4.0.0/bin"
CUSTOM_BIN="$HOME/.sh/bin"
NIX_PROFILE_BIN="$HOME/.nix-profile/bin"

export PATH="$VSCODE_LANGSERVERS_EXTRACTED_BIN:$GEM_BIN:$CUSTOM_BIN:$NIX_PROFILE_BIN:$PATH"

