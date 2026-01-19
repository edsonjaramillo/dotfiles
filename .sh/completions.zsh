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
