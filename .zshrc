# functions coming from prerequistites.sh
# has_command (checks if a command exists)
# source_dir (sources all files in a directory)
source "$HOME/.sh/prerequistites.sh"

source "$HOME/.sh/plugins.zsh"

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

# FNN (Fast Node Manager)
if has_command fnm; then
	eval "$(fnm env --use-on-cd --shell zsh)"
	source <(fnm completions --shell zsh)
fi

# zoxide
if has_command zoxide; then
	eval "$(zoxide init zsh)"
fi

# source
source_dir "$HOME/.sh/lib/"

# aliases
source_dir "$HOME/.sh/aliases/"

# completions
source "$HOME/.sh/completions.zsh"

# Source all files in $HOME/.sh/site-functions/
if [[ -d "$HOME/.sh/site-functions" ]]; then
	for file in "$HOME/.sh/site-functions"/*; do
		[[ -f "$file" ]] && source "$file"
	done
fi
