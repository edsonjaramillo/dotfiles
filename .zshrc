# functions coming from prerequistites.sh
# has_command (checks if a command exists)
# source_dir (sources all files in a directory)
source "$HOME/.sh/prerequistites.sh"

source "$HOME/.sh/plugins.zsh"

# source
source_dir "$HOME/.sh/lib/"

# aliases
source_dir "$HOME/.sh/aliases/"

# initialization
source "$HOME/.sh/init.sh"

# completions
source "$HOME/.sh/completions.zsh"
