# FNM (Fast Node Manager)
if has_command fnm; then
	eval "$(fnm env --use-on-cd --shell zsh)"
fi

# Homebrew
if [[ -x /opt/homebrew/bin/brew ]]; then
	eval "$(/opt/homebrew/bin/brew shellenv zsh)"
elif [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
fi

# Starship (prompt)
if has_command starship; then
	eval "$(starship init zsh)"
fi

if has_command atuin; then
	eval "$(atuin init zsh)"
fi

# zoxide
if has_command zoxide; then
	eval "$(zoxide init zsh)"
fi
