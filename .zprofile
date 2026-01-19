# Base
export EDITOR=nvim

# Eza
export EZA_ICONS_AUTO="always"

# add extracted language servers to PATH
CARGO_BIN="$HOME/.cargo/bin"
CUSTOM_BIN="$HOME/.sh/bin"
GEM_BIN="$HOME/.local/share/gem/ruby/4.0.0/bin"
NIX_PROFILE_BIN="$HOME/.nix-profile/bin"
VSCODE_LANGSERVERS_EXTRACTED_BIN="$HOME/.nix-profile/lib/node_modules/vscode-langservers-extracted/bin"

export PATH="CARGO_BIN:$CUSTOM_BIN:$GEM_BIN:$NIX_PROFILE_BIN:$VSCODE_LANGSERVERS_EXTRACTED_BIN:$PATH"
