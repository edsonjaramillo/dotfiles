TOOLS_DIR     := tools
SYMLINK_SCRIPT := $(TOOLS_DIR)/symlink.sh

.PHONY: help link unlink dump install

help:
	@echo "Usage: make [target]"
	@echo
	@echo "Targets:"
	@echo "  link     - Create symlinks"
	@echo "  unlink   - Remove symlinks"
	@echo "  dump     - Dump the current state of brew packages"
	@echo "  install  - Install brew packages from Brewfile"


link:
	@sh $(SYMLINK_SCRIPT) link

unlink:
	@sh $(SYMLINK_SCRIPT) unlink

dump:
	@brew bundle dump --describe --file=~/code/personal/dotfiles/Brewfile

install:
	@cd ~/code/personal/dotfiles
	@brew bundle install --file=~/code/personal/dotfiles/.brew/Brewfile
