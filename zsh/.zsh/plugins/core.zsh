#!/usr/bin/env zsh

# Syntax highlighting 
source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
# Autosuggestions
source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
# Load compinit
autoload -U +X compinit && compinit