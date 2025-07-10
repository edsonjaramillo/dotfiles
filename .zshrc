# >>> Source all .zsh files from ~/.zsh and its subdirectories or .zsh or .sh files <<<
for file in ~/.sh/**/*.{sh,zsh}; do
  # shellcheck source=/dev/null
  source "$file"
done


# >>> Fastfetch <<<
fastfetch --config ~/.config/fastfetch/config.jsonc

# >>> Fzf <<<
# shellcheck source=/dev/null
source <(fzf --zsh)

# >>> Zoxide <<<
eval "$(zoxide init zsh)"

# >>> Fnm <<<
eval "$(fnm env --use-on-cd --shell zsh)"