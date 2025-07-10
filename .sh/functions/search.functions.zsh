_get_start_dir() {
    # Use parameter substitution for default value
    local dir="${1:-$HOME}"

    case "$dir" in
    ".")
        printf "%s\n" "$PWD"
        ;;
    *)
        if [ -d "$dir" ]; then
            printf "%s\n" "$dir"
        else
            printf "Error: '%s' is not a valid directory\n" "$dir" >&2
            exit 1
        fi
        ;;
    esac
}

_get_depth() {
    # if no depth argument #2 is not provided, use 5
    local depth
    depth="${1:-4}"

    echo "$depth"
}

# cd to selected directory
fcd() {
    local selected_dir
    selected_dir=$(find_dirs "$HOME" | fzf --reverse --multi --prompt="cd> ")
    cd "$selected_dir" || exit 1
}

find_files() {
    local start_dir
    start_dir=$(_get_start_dir "$1")

    local depth
    depth=$(_get_depth "$2")

    local AVAILABLE_FILES
    AVAILABLE_FILES=$(
        fd --hidden \
            --exclude ".cache" \
            --exclude ".DS_Store" \
            --exclude ".git" \
            --exclude ".local" \
            --exclude "Library" \
            --glob "*" \
            --follow \
            --max-depth "$depth" \
            --no-ignore \
            --type f \
            "$start_dir"
    )

    echo "$AVAILABLE_FILES"

}

# find directories
find_dirs() {
    local start_dir
    start_dir=$(_get_start_dir "$1")

    local depth
    depth=$(_get_depth "$2")

    local available_dirs
    available_dirs=$(fd --hidden \
        --exclude ".cache" \
        --exclude ".DS_Store" \
        --exclude ".git" \
        --exclude ".local" \
        --exclude "Library" \
        --glob "*" \
        --follow \
        --max-depth "$depth" \
        --no-ignore \
        --type d \
        "$start_dir")

    echo "$available_dirs"
}

fzf_widget() {
    # Define choices and common fzf options
    local choices=(
        "Directories"
        "Directories (Relative)"
        "Files"
        "Files (Relative)"
    )
    local fzf_opts=(--reverse --multi --prompt="Find> ")

    # Let the user choose between files or directories
    local choice
    choice=$(printf '%s\n' "${choices[@]}" | fzf "${fzf_opts[@]}") || return 0

    # Based on the choice, run the appropriate finder and let fzf filter the results
    local response=""
    case "$choice" in
    "Directories")
        response=$(find_dirs "$HOME" 4 | fzf "${fzf_opts[@]}")
        ;;
    "Directories (Relative)")
        response=$(find_dirs "." 4 | fzf "${fzf_opts[@]}")
        ;;
    "Files")
        response=$(find_files "$HOME" 4 | fzf "${fzf_opts[@]}")
        ;;
    "Files (Relative)")
        response=$(find_files "." 4 | fzf "${fzf_opts[@]}")
        ;;
    esac

    # replace the new line with a space
    response=$(echo "$response" | tr '\n' ' ')

    # If a valid response was selected, append it to the command line buffer
    if [[ -n "$response" ]]; then
        LBUFFER+="$response"
        zle reset-prompt
    fi
}

# Tell zsh that this is a widget
zle -N fzf_widget

# Bind to ctrl-f
bindkey '^F' fzf_widget
