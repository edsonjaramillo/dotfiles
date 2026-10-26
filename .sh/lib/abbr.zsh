# Abbreviation definitions. Run `iabbr` after editing to regenerate the
# zsh-abbr user file and reload it into the current session.
typeset -gA _ABBRS=(
	################ Abbreviations #################
	abl 'abbr list'
	abs 'abbr list | rg'

	############### zsh ##################
	zrs 'source ~/.zshrc'

	############### core ###############
	cl 'clear'
	ee 'exit'

	################## git ##################
	# core
	gs 'git status'
	gl 'git log --oneline --graph --decorate'
	# commit
	gc 'git commit'
	gca 'git commit --amend'
	# branching
	gco 'git checkout'
	gsc 'git switch --create'
	gsm 'git switch main'
	gb 'git branch'
	gbd 'git branch --delete'
	# io
	gP 'git push'
	gp 'git pull'
	gf 'git fetch'
	# restore
	grs 'git restore --staged'
	# reset
	grsh 'git reset --soft HEAD~'  # undo last commit, keep changes staged
	grhh 'git reset --hard'        # discard uncommitted changes
	grhh1 'git reset --hard HEAD~' # drop last commit AND its changes

	############### files ###############
	fdf 'fd -H -I -t f -E .git'
	fdd 'fd -H -I -t d -E .git'
	fde 'fd -H -I -t f -E .git -e'

	############### lazy ###############
	lg 'lazygit'

	############### tm ###############
	tms 'tm start'
	tmsw 'tm start --switch'
	tmd 'tm detach'
	tmk 'tm kill'
	tmka 'tm kill --all'
	tme 'tm editor'
	tmo 'tm opencode'
	tmg 'tm git'
	tmq 'tm quads'

	################ history ###############
	hre 'hst remove errors'
	hrs 'hst remove search'
	hrf 'hst remove fewer'
	hs 'hst sync'

	############### ordo ###############
	oi 'ordo install'
	ou 'ordo uninstall'
	oup 'ordo update'
	or 'ordo run'
	ogi 'ordo global install'
	ogu 'ordo global uninstall'
	ogup 'ordo global update'

	############### bond ###############
	bsa 'bond skills add'
	bsr 'bond skills remove'

	############### pi ###############
	piue 'pi update --extensions'
	pic 'pi --continue'
)

iabbr() {
	local file=${ABBR_USER_ABBREVIATIONS_FILE:?ABBR_USER_ABBREVIATIONS_FILE is not set}
	local key

	{
		for key in ${(ok)_ABBRS}; do
			print -r -- "abbr ${(qqq)key}=${(qqq)_ABBRS[$key]}"
		done
	} >|"$file" || return 1

	# Reload so removed abbreviations disappear from the current session too.
	abbr load
}
