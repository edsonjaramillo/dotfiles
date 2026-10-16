# Syntax highlighting
source "$HOME/.nix-profile/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Autosuggestions
source "$HOME/.nix-profile/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Fzf Tab
source "$HOME/.nix-profile/share/fzf-tab/fzf-tab.zsh"

# autopair
source "$HOME/.nix-profile/share/zsh/zsh-autopair/autopair.zsh"

# Load compinit
autoload -Uz +X compinit && compinit
autoload -Uz +X bashcompinit && bashcompinit
