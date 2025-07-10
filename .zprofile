# >>> HOMEBREW <<<
eval "$(/opt/homebrew/bin/brew shellenv)"

# >>> OH-MY-POSH <<<
eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/themes/earthshine.omp.json)"

# >>> NVM <<<
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"                                       # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

# >>> HSTR <<<
export HSTR_CONFIG=hicolor,favorites-view,no-confirm,regexp-matching # get more colors and show favorites view

# >>> EDITOR <<<
export EDITOR="code"

# >>> PNPM <<<
export PNPM_HOME="/Users/edson/Library/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
