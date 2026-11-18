# Nix's ncurses doesn't look at the system terminfo folders on non-NixOS Linux
if [[ "$OSTYPE" == linux* ]]; then
	export TERMINFO_DIRS="${TERMINFO_DIRS:+$TERMINFO_DIRS:}/usr/share/terminfo:/etc/terminfo:/lib/terminfo:"
fi
