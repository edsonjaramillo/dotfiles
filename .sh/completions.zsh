# FNN (Fast Node Manager)
if has_command fnm; then
	eval "$(fnm env --use-on-cd --shell zsh)"
	source <(fnm completions --shell zsh)
fi

if has_command uv; then
	eval "$(uv generate-shell-completion zsh)"
	eval "$(uvx --generate-shell-completion zsh)"
fi

if has_command jj; then
	source <(jj util completion zsh)
fi

if has_command gh; then
	eval "$(gh completion -s zsh)"
fi

if has_command task; then
	eval "$(task --completion zsh)"
fi

if has_command atuin; then
	source <(atuin gen-completions --shell zsh)
fi

if has_command codex; then
	source <(codex completion zsh)
fi

if has_command bond; then
	source <(bond completion zsh)
fi

# Homebrew
if has_command brew; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# {# Starship (prompt)
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

if has_command tm; then
	source <(tm completion zsh)
fi

if has_command dots; then
	source <(dots completion zsh)
fi

if has_command hst; then
	source <(hst completion zsh)
fi

if has_command sr; then
	source <(sr completion zsh)
fi

if has_command ordo; then
	source <(ordo completion zsh)
fi

if has_command pnpm; then
	eval "$(pnpm completion zsh)"
fi

if has_command bun; then
	source <(vidmini completion zsh)
fi
