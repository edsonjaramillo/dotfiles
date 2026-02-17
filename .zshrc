# functions coming from prerequistites.sh
# has_command (checks if a command exists)
# source_dir (sources all files in a directory)
source "$HOME/.sh/prerequistites.sh"

source "$HOME/.sh/plugins.zsh"

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
