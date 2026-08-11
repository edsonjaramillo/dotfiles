zmodload zsh/stat

_completion_file_signature() {
	local path="$1"
	local resolved="${path:A}"
	local -A metadata

	if zstat -H metadata -- "$resolved" 2>/dev/null; then
		REPLY="$resolved:$metadata[mtime]:$metadata[size]"
	else
		REPLY="$resolved:missing"
	fi
}

_cache_completion() {
	local name="$1"
	shift

	local -a dependencies
	while (($#)) && [[ "$1" != -- ]]; do
		dependencies+=("$1")
		shift
	done
	shift

	local -a generator=("$@")
	local command_name="$generator[1]"
	has_command "$command_name" || return 0

	local cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/completions"
	local cache_file="$cache_dir/$name.zsh"
	local signature_file="$cache_file.signature"
	local temporary_file="$cache_file.$$.${RANDOM}.tmp"
	local temporary_signature="$signature_file.$$.${RANDOM}.tmp"
	local -a signature_parts

	_completion_file_signature "$commands[$command_name]"
	signature_parts+=("generator=$REPLY" "command=${(q)generator}")

	local dependency
	for dependency in $dependencies; do
		_completion_file_signature "$dependency"
		signature_parts+=("dependency=$REPLY")
	done

	local signature="${(j:\n:)signature_parts}"
	local cached_signature=""
	[[ -r "$signature_file" ]] && cached_signature="$(<"$signature_file")"

	if [[ ! -r "$cache_file" || "$cached_signature" != "$signature" ]]; then
		[[ -d "$cache_dir" ]] || mkdir -p -- "$cache_dir"

		if "$generator[@]" >|"$temporary_file" 2>/dev/null; then
			mv -f -- "$temporary_file" "$cache_file"
			print -rn -- "$signature" >|"$temporary_signature"
			mv -f -- "$temporary_signature" "$signature_file"
		else
			rm -f -- "$temporary_file" "$temporary_signature"
		fi
	fi

	[[ -r "$cache_file" ]] && source "$cache_file"
}

_cache_completion atuin -- atuin gen-completions --shell zsh
_cache_completion bond -- bond completion zsh
_cache_completion codex -- codex completion zsh
_cache_completion completely "$HOME/.sh/completions/z.yaml" -- completely preview "$HOME/.sh/completions/z.yaml"
_cache_completion dots -- dots completion zsh
_cache_completion fnm -- fnm completions --shell zsh
_cache_completion gh -- gh completion -s zsh
_cache_completion hst -- hst completion zsh
_cache_completion jj -- jj util completion zsh
_cache_completion opencode -- opencode completion
_cache_completion ordo -- ordo completion zsh
_cache_completion pnpm -- pnpm completion zsh
_cache_completion sr -- sr completion zsh
_cache_completion task -- task --completion zsh
_cache_completion tm -- tm completion zsh
_cache_completion uv -- uv generate-shell-completion zsh
_cache_completion uvx -- uvx --generate-shell-completion zsh

# bun completions
[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"

unfunction _cache_completion _completion_file_signature
