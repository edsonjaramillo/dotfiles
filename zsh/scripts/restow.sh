#!/usr/bin/env bash

restow() {
  shopt -s nullglob failglob
  local stow_packages
  stow_packages=$(fd . -t directory -d 1)

  for package in $stow_packages; do
    stow -v -R -t "$HOME" "$package"
  done
}

restow