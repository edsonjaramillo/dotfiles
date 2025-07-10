#!/usr/bin/env bash

# Docker process management
alias d='docker'
alias dc='docker compose'
alias dps='docker ps'
alias dpsa='docker ps -a'

# Docker container lifecycle
alias dstart='docker start'
alias dstop='docker stop'
alias drestart='docker restart'
alias drm='docker rm'
alias drmi='docker rmi'

# Docker container interaction
alias dex='docker exec -it'
alias dlogs='docker logs'
alias dlog='docker logs -f'

# Docker compose shortcuts
alias dcu='docker compose up'
alias dcud='docker compose up -d'
alias dcd='docker compose down'
alias dcr='docker compose restart'
alias dcl='docker compose logs -f'

# Docker system maintenance
alias dprune='docker system prune -af'
alias dvprune='docker volume prune -f'
alias dclean='docker system prune -af --volumes'

# Docker build
alias dbuild='docker build'
alias dbuildtag='docker build -t'
alias dtag='docker tag'
alias dpush='docker push'
alias dpull='docker pull'
