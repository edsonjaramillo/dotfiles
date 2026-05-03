iabbr() {
	echo >"$ABBR_USER_ABBREVIATIONS_FILE"
	################ Abbreviations #################
	abbr add abl='abbr list' --quiet
	abbr add abs='abbr list | rg' --quiet

	############### zsh ##################
	abbr add zrs='source ~/.zshrc' --quiet

	############### core ###############
	abbr add cl='clear' --quiet

	################## git ##################
	# core
	abbr add gs='git status' --quiet
	abbr add gl='git log --oneline --graph --decorate' --quiet
	# commit
	abbr add gc='git commit' --quiet
	abbr add gca='git commit --amend' --quiet
	abbr add gcu='git reset --soft HEAD~1' --quiet
	# branching
	abbr add gco='git checkout' --quiet
	abbr add gsc='git switch --create' --quiet
	abbr add gsm='git switch main' --quiet
	abbr add gb='git branch' --quiet
	abbr add gbd='git branch --delete' --quiet
	# io
	abbr add gP='git push' --quiet
	abbr add gp='git pull' --quiet
	abbr add gf='git fetch' --quiet
	# restore
	abbr add grs='git restore --staged' --quiet
	# reset
	abbr add grsh='git reset --soft HEAD~' --quiet
	abbr add grhh='git reset --hard HEAD~' --quiet

	############### files ###############
	abbr add fdf='fd -H -I -t f -E .git' --quiet
	abbr add fdd='fd -H -I -t d -E .git' --quiet
	abbr add fde='fd -H -I -t f -E .git -e' --quiet

	############### lazy ###############
	abbr add lg='lazygit' --quiet
	abbr add ld='lazydocker' --quiet

	############### tm ###############
	abbr add tms='tm start' --quiet
	abbr add tmsw='tm start --switch' --quiet
	abbr add tmd='tm detach' --quiet
	abbr add tmk='tm kill' --quiet
	abbr add tmka='tm kill --all' --quiet
	abbr add tme='tm editor' --quiet
	abbr add tmo='tm opencode' --quiet
	abbr add tmg='tm git' --quiet
	abbr add tmq='tm quads' --quiet

	################ history ###############
	abbr add hre='hst remove errors' --quiet
	abbr add hrs='hst remove search' --quiet
	abbr add hrf='hst remove fewer' --quiet
	abbr add hs='hst sync' --quiet

	############### ordo ###############
	abbr add oi='ordo install' --quiet
	abbr add ou='ordo uninstall' --quiet
	abbr add oup='ordo update' --quiet
	abbr add or='ordo run' --quiet
	abbr add ogi='ordo global install' --quiet
	abbr add ogu='ordo global uninstall' --quiet
	abbr add ogup='ordo global update' --quiet
}
