iabbr() {
	echo >"$ABBR_USER_ABBREVIATIONS_FILE"
	################ Abbreviations #################
	abbr add abl='abbr list' --quiet --force
	abbr add abs='abbr list | rg' --quiet --force

	############### zsh ##################
	abbr add zrs='source ~/.zshrc' --quiet --force

	############### core ###############
	abbr add cl='clear' --quiet --force
	abbr add ee="exit" --quiet --force

	################## git ##################
	# core
	abbr add gs='git status' --quiet --force
	abbr add gl='git log --oneline --graph --decorate' --quiet --force
	# commit
	abbr add gc='git commit' --quiet --force
	abbr add gca='git commit --amend' --quiet --force
	abbr add gcu='git reset --soft HEAD~1' --quiet --force
	# branching
	abbr add gco='git checkout' --quiet --force
	abbr add gsc='git switch --create' --quiet --force
	abbr add gsm='git switch main' --quiet --force
	abbr add gb='git branch' --quiet --force
	abbr add gbd='git branch --delete' --quiet --force
	# io
	abbr add gP='git push' --quiet --force
	abbr add gp='git pull' --quiet --force
	abbr add gf='git fetch' --quiet --force
	# restore
	abbr add grs='git restore --staged' --quiet --force
	# reset
	abbr add grsh='git reset --soft HEAD~' --quiet --force
	abbr add grhh='git reset --hard HEAD~' --quiet --force

	############### files ###############
	abbr add fdf='fd -H -I -t f -E .git' --quiet --force
	abbr add fdd='fd -H -I -t d -E .git' --quiet --force
	abbr add fde='fd -H -I -t f -E .git -e' --quiet --force

	############### lazy ###############
	abbr add lg='lazygit' --quiet --force
	abbr add ld='lazydocker' --quiet --force

	############### tm ###############
	abbr add tms='tm start' --quiet --force
	abbr add tmsw='tm start --switch' --quiet --force
	abbr add tmd='tm detach' --quiet --force
	abbr add tmk='tm kill' --quiet --force
	abbr add tmka='tm kill --all' --quiet --force
	abbr add tme='tm editor' --quiet --force
	abbr add tmo='tm opencode' --quiet --force
	abbr add tmg='tm git' --quiet --force
	abbr add tmq='tm quads' --quiet --force

	################ history ###############
	abbr add hre='hst remove errors' --quiet --force
	abbr add hrs='hst remove search' --quiet --force
	abbr add hrf='hst remove fewer' --quiet --force
	abbr add hs='hst sync' --quiet --force

	############### ordo ###############
	abbr add oi='ordo install' --quiet --force
	abbr add ou='ordo uninstall' --quiet --force
	abbr add oup='ordo update' --quiet --force
	abbr add or='ordo run' --quiet --force
	abbr add ogi='ordo global install' --quiet --force
	abbr add ogu='ordo global uninstall' --quiet --force
	abbr add ogup='ordo global update' --quiet --force

	############### bond ###############
	abbr add bsa='bond skills add' --quiet --force
	abbr add bsr='bond skills remove' --quiet --force

	############### ai ###############
	abbr add oc="opencode" --quiet --force
	abbr add co="codex" --quiet --force
}
