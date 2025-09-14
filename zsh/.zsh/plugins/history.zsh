#!/usr/bin/env zsh

# ZSH HISTORY CONFIGURATION
HISTSIZE=100000           # in-memory history lines
SAVEHIST=200000           # lines to save to $HISTFILE

setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# HISTORY KEY BINDINGS
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward