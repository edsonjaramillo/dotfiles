# Syntax highlighting
source "$HOME/.nix-profile/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
# Autosuggestions
source "$HOME/.nix-profile/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
# Fzf Tab
source "$HOME/.nix-profile/share/fzf-tab/fzf-tab.zsh"
# autopair
source "$HOME/.nix-profile/share/zsh/zsh-autopair/autopair.zsh"
# vi-mode
source "$HOME/.nix-profile/share/zsh-vi-mode/zsh-vi-mode.zsh"
export ZVM_VI_ESCAPE_BINDKEY=jk
# Load compinit
autoload -U +X compinit && compinit
