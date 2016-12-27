EXCLUDED_FILES := .DS_Store .git .gitignore .gitmodules
MACOS_FILES := .mackup .mackup.cfg .brewfile
X_FILES := $(filter-out $(EXCLUDED_FILES), $(wildcard .x?*) $(wildcard .X?*))
DOTFILES := $(filter-out $(EXCLUDED_FILES) $(MACOS_FILES) $(X_FILES), $(wildcard .??*))
DOTFILES_DIR := $(HOME)/.dotfiles
BINFILES := $(filter-out $(EXCLUDED_FILES), $(wildcard ./bin/*))
BINFILES_DIR := /usr/local/bin

default:
	@echo "Usage: make <task(s)>"
	@echo
	@echo "General tasks:"
	@echo "install     Create symlinks"
	@echo "uninstall   Remove symlinks"
	@echo "update      Update .dotfiles repo and sub repos"
	@echo "backup      Update backup file for Homebrew and Atom"
	@echo "atom        Install packages for Atom"
	@echo "neovim      Set up Python for Neovim"
	@echo "list        List all dotfiles amd bins"
	@echo
	@echo "macOS-specific tasks:"
	@echo "mac         Install Xcode CLT and Homebrew"
	@echo "xcode       Install Xcode Command Line Tools"
	@echo "homebrew    Install Homebrew and the basic packages"
	@echo
	@echo "Linux-specific tasks:"
	@echo "x           Create symlinks for X"
	@echo "unx         Remove symlinks for X"
help: default

# General tasks
install: update
	@$(foreach f, $(DOTFILES), ln -sfnv $(abspath $(f)) $(HOME)/$(f);)
	@$(foreach f, $(BINFILES), ln -sfnv $(abspath $(f)) $(BINFILES_DIR)/$(notdir $(f));)
ifeq ($(shell uname), Darwin)
	@$(foreach f, $(MACOS_FILES), ln -sfnv $(abspath $(f)) $(HOME)/$(f);)
endif

uninstall:
	@$(foreach f, $(DOTFILES), rm -rfv $(HOME)/$(f);)
	@$(foreach f, $(BINFILES), rm -rfv $(BINFILES_DIR)/$(notdir $(f));)
ifeq ($(shell uname), Darwin)
	@$(foreach f, $(MACOS_FILES), rm -rfv $(HOME)/$(f);)
endif

update:
	@git pull --rebase origin master
	@git submodule update --init --recursive

backup:
	@apm list --installed --bare > .atom/packages.txt

atom:
	@apm install --packages-file .atom/packages.txt

neovim:
	@bash $(DOTFILES_DIR)/etc/init/setup_neovim.sh

list:
	@echo "--- dotfiles ---"
	@$(foreach f, $(DOTFILES), ls -dF $(f);)
	@echo "--- macOS ---"
	@$(foreach f, $(MACOS_FILES), ls -dF $(f);)
	@echo "--- X ---"
	@$(foreach f, $(X_FILES), ls -dF $(f);)
	@echo "--- bin ---"
	@$(foreach f, $(BINFILES), ls -dF $(f);)

# macOS-specific tasks
mac: xcode homebrew

xcode:
	@bash $(DOTFILES_DIR)/etc/init/osx/install_xcode_cli.sh

homebrew:
	@bash $(DOTFILES_DIR)/etc/init/osx/install_homebrew.sh
	@bash $(DOTFILES_DIR)/etc/init/osx/install_packages.sh

# Linux-specific tasks
x:
	@$(foreach f, $(X_FILES), ln -sfnv $(abspath $(f)) $(HOME)/$(f);)

unx:
	@$(foreach f, $(X_FILES), rm -rfv $(HOME)/$(f);)
