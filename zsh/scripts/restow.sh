#!/usr/bin/env bash


init(){
	shopt -s nullglob
	shopt -s failglob
  	local stow_packages
  	stow_packages=$(fd . -t directory -d 1)

  	for package in $stow_packages; do
		stow -v -R -t "$HOME" "$package"
  	done
}

init