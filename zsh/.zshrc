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

[[ -f "$HOME/.helpers/gumh.bash" ]] && source "$HOME/.helpers/gumh.bash"