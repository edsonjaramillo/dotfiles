#!/usr/bin/env bash

zinit() {
    zoxide query --list | while read -r line; do
        zoxide remove "$line"
    done

    find "$HOME/code" -mindepth 1 -maxdepth 1 -type d | while read -r dir; do
        find "$dir" -mindepth 1 -maxdepth 1 -type d | while read -r subdir; do
            zoxide add "$subdir"
        done
    done
}
