#!/usr/bin/env bash

# File and directory operations
alias mkdir='mkdir -p'         # Create parent directories automatically
alias cp='cp -i'               # Prompt before overwriting files
alias mv='mv -i'               # Prompt before overwriting files
alias rm='rm -i'               # Prompt before removing files
alias df='df -h'               # Show disk space in human-readable format
alias du='du -sh * | sort -hr' # Show disk usage sorted by size

# Process management
alias psa='ps aux'        # List all running processes
alias psg='ps aux | grep' # Search for specific processes
alias kill9='kill -9'     # Force kill a process

# System information
alias raminfo='top -l 1 | grep PhysMem'
alias cpuinfo='top -l 1 | grep CPU'
alias paths='echo $PATH | tr ':' "\n"'
alias hh='hstr'

# Network utilities
alias ipe='curl -s ipinfo.io/ip'
alias ipl='ipconfig getifaddr en0' # Show local IP addresses
alias pong='ping -c 4 8.8.8.8'     # Ping Google's DNS server

# Archive operations
alias targz='tar -zcvf'   # Create .tar.gz archives (usage: targz archive.tar.gz directory/)
alias untar='tar -zxvf'   # Extract .tar.gz archives (usage: untar archive.tar.gz)
alias untargz='tar -zxvf' # Extract .tar.gz archives
alias untarbz2='tar -xjf' # Extract .tar.bz2 archives

# Shell
alias zsh-restart='source $HOME/.zshrc'

# Homebrew operations
alias brewup='brew update && brew upgrade' # Update Homebrew and upgrade packages
alias brewls='brew list'                   # List installed packages
alias brewo='brew outdated'                # List outdated packages
alias brewi='brew install'                 # Install a package
alias brewr='brew remove'                  # Remove a package              # Search for packages
alias brewc='brew cleanup'                 # Remove old versions
alias brewdr='brew doctor'                 # Check system for potential problems
alias brewinfo='brew info'                 # Show package information
alias brewdeps='brew deps --tree'          # Show dependency tree for a package
alias brewleaves='brew leaves'             # List installed formulae that aren't dependencies
