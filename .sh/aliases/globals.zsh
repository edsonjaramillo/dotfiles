alias -g CL="wc -l"
alias -g CW="wc -w"

alias -g JS='| jq -r "."'

alias -g S="| sort"
alias -g SN="| sort -n"
alias -g SR="| sort -r"
alias -g SU="| sort -u"

alias -g G="| rg"
alias -g H="| head"
alias -g L="| les"
alias -g T="| tail"
alias -g TBL="| column -t"

alias -g FZ="| fzf --reverse"
alias -g FZM="| fzf --multi --reverse"

alias -g FF='$(fd -H -I -t f | fzf --reverse)'
alias -g FD='$(fd -H -I -t d | fzf --reverse)'

alias -g XA="| xargs"
