depth-checker() {
    local DEPTH
    DEPTH=4

    local DEPTH_FILE
    DEPTH_FILE="$HOME/depth.txt"

    fd --exclude ".cache" \
        --exclude "Library" \
        --exclude "Movies" \
        --exclude "Music" \
        --type d \
        --follow \
        --exact-depth "$DEPTH" \
        --glob "*" \
        "$HOME" |
        sed "s|^$HOME/||" |
        sort \
            >"$DEPTH_FILE"

    printf "Depth file created: %s\n" "$DEPTH_FILE"
}

# check the depth of the current directory
depth-pwd() {
    local CURRENT_DIR
    CURRENT_DIR=$(pwd)
    DEPTH=$(echo "$CURRENT_DIR" | awk -F'/' '{print NF-3}')
    echo "$DEPTH"
}

# open the current pwd in VS Code and replace a vscode window
c.r() {
    code . -r
}

# open the current pwd in VS Code
c.() {
    code .
}
