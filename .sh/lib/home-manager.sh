#!/usr/bin/env bash

hms() {
	# Check if nix is installed
	if ! command -v nix &>/dev/null; then
		echo "Error: nix is not installed." >&2
		return 1
	fi

	# Make username configurable
	local username="${1:-edsonjaramillo}" # Use first argument or default

	# Determine architecture
	local arch
	case "$(uname -m)" in
	x86_64) arch="x86_64" ;;
	aarch64 | arm64) arch="aarch64" ;;
	*)
		echo "Error: Unsupported architecture: $(uname -m)" >&2
		return 1
		;;
	esac

	# Determine OS
	local os
	case "$(uname -s)" in
	Darwin) os="darwin" ;;
	Linux) os="linux" ;;
	*)
		echo "Error: Unsupported OS: $(uname -s)" >&2
		return 1
		;;
	esac

	local config_name="${username}-${arch}-${os}"
	local home_manager_path="$HOME/.config/home-manager/"
	local flake_uri="${home_manager_path}#${config_name}"

	# Check if home-manager exists
	if [ -f "$HOME/.nix-profile/bin/home-manager" ]; then
		echo "Using installed home-manager..."
		if ! home-manager switch --flake "$flake_uri"; then
			echo "Error: home-manager switch failed" >&2
			return 1
		fi
	else
		echo "Home-manager not installed. Running via nix..."
		if ! nix run home-manager/master -- switch --flake "$flake_uri"; then
			echo "Error: nix run home-manager failed" >&2
			return 1
		fi
	fi

	return 0
}
