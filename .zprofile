# Base
export EDITOR=nvim

# Eza
export EZA_ICONS_AUTO="always"

# add extracted language servers to PATH
BUN_PATH="$HOME/.bun/bin"
BUN_SYSTEM_BIN="$HOME/.config/system-packages/node_modules/.bin"
CARGO_BIN="$HOME/.cargo/bin"
GEM_BIN="$HOME/.local/share/gem/ruby/4.0.0/bin"
LOCAL_BIN="$HOME/.local/bin"
export PATH="$BUN_PATH:$BUN_SYSTEM_BIN:$CARGO_BIN:$GEM_BIN:$LOCAL_BIN:$PATH"
