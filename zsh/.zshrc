# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# {# Starship (prompt)
if [[ -x "$(command -v starship)" ]]; then
  eval "$(starship init zsh)"
fi

# Source zsh files
[[ -f "$HOME/.zsh/plugins/core.zsh" ]] && source "$HOME/.zsh/plugins/core.zsh"
[[ -f "$HOME/.zsh/plugins/history.zsh" ]] && source "$HOME/.zsh/plugins/history.zsh"
[[ -f "$HOME/.zsh/plugins/eza.zsh" ]] && source "$HOME/.zsh/plugins/eza.zsh"

# FNN (Fast Node Manager)
eval "$(fnm env --use-on-cd --shell zsh)"
source <(fnm completions --shell zsh)

# Load script launcher
[[ -f "$HOME/.zsh/scripts/script-launcher.sh" ]] && source "$HOME/.zsh/scripts/script-launcher.sh"

# Load gum lib
[[ -f "$HOME/libs/gumh.sh" ]] && source "$HOME/libs/gumh.sh"

# zoxide
eval "$(zoxide init zsh)"
[[ -f "$HOME/.zoxide/zoxide.sh" ]] && source "$HOME/.zoxide/zoxide.sh"