EXCLUDED_FILES := .DS_Store .git .gitignore .gitmodules
MACOS_FILES := .mackup .mackup.cfg .brewfile
X_FILES := $(filter-out $(EXCLUDED_FILES), $(wildcard .x?*) $(wildcard .X?*))
DOTFILES := $(filter-out $(EXCLUDED_FILES) $(MACOS_FILES) $(X_FILES), $(wildcard .??*))
DOTFILES_DIR := $(HOME)/.dotfiles
BINFILES := $(filter-out $(EXCLUDED_FILES), $(wildcard ./bin/*))
BINFILES_DIR := /usr/local/bin

help:
	@echo "make list       #=> List dotfiles/bin"
	@echo "make init       #=> Setup environment"
	@echo "make xcode      #=> Install Xcode Command Line Tools"
	@echo "make homebrew   #=> Install Homebrew"
	@echo "make install    #=> Create symlinks"
	@echo "make uninstall  #=> Delete symlinks"
	@echo "make x  #=> Create symlinks for X"
	@echo "make unx  #=> Delete symlinks for X"
	@echo "make update     #=> Update repositories"

list:
	@echo "--- dotfiles ---"
	@$(foreach f, $(DOTFILES), ls -dF $(f);)
	@echo "--- macOS ---"
	@$(foreach f, $(MACOS_FILES), ls -dF $(f);)
	@echo "--- X ---"
	@$(foreach f, $(X_FILES), ls -dF $(f);)
	@echo "--- bin ---"
	@$(foreach f, $(BINFILES), ls -dF $(f);)

init:
	@$(foreach f, $(wildcard ./etc/init/*.sh), bash $(f);)
	@git submodule update --init --recursive
ifeq ($(shell uname), Darwin)
	@$(foreach f, $(wildcard ./etc/init/osx/*.sh), bash $(f);)

xcode:
	@bash $(DOTFILES_DIR)/etc/init/osx/install_xcode_cli.sh

homebrew:
	@bash $(DOTFILES_DIR)/etc/init/osx/install_homebrew.sh
endif

install:
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

x:
	@$(foreach f, $(X_FILES), ln -sfnv $(abspath $(f)) $(HOME)/$(f);)

unx:
	@$(foreach f, $(X_FILES), rm -rfv $(HOME)/$(f);)

update:
	@git pull --rebase origin master
	@git submodule foreach git pull origin master
	@git submodule update --init --recursive
