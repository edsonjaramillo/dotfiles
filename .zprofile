# Base
export EDITOR=nvim

# Eza
export EZA_ICONS_AUTO="always"

# add extracted language servers to PATH
CARGO_BIN="$HOME/.cargo/bin"
GEM_BIN="$HOME/.local/share/gem/ruby/4.0.0/bin"
LOCAL_BIN="$HOME/.local/bin"

export PNPM_HOME="$HOME/.local/share/pnpm"

export PATH="$CARGO_BIN:$GEM_BIN:$LOCAL_BIN:$PNPM_HOME:$PATH"
