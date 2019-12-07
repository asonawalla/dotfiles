#!/usr/bin/env make -f

all:
	@echo "Usage: make [ vim | fish | powerline | tmux ]"

## ALL THE VIM STUFF

vim: /usr/local/bin/vim $(HOME)/.vim/autoload/plug.vim

$(HOME)/.vim/autoload/plug.vim: $(HOME)/.vimrc
	curl -fLo $(HOME)/.vim/autoload/plug.vim --create-dirs \
		     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	@vim +PlugInstall +qall

vim-config: $(HOME)/.vim/autoload/plug.vim

$(HOME)/.vimrc: $(CURDIR)/vimrc
	@ln -s $(CURDIR)/vimrc $(HOME)/.vimrc

/usr/local/bin/vim: $(HOME)/vim
	(cd $(HOME)/vim && sudo make uninstall && sudo make clean)
	(cd $(HOME)/vim && ./configure \
		--with-features=huge \
		--enable-multibyte \
		--enable-rubyinterp=yes \
		--enable-pythoninterp=yes \
		--enable-python3interp=yes \
		--enable-perlinterp=yes \
		--enable-luainterp=yes \
		--enable-gui=gtk2 --enable-cscope --prefix=/usr/local)
	(cd $(HOME)/vim && make)
	(cd $(HOME)/vim && sudo make install)

$(HOME)/vim:
	git clone https://github.com/vim/vim $(HOME)/vim

## ALL THE PYTHON STUFF

/usr/local/bin/python3: /usr/local/bin/brew
	#TODO: make this work on linux
	brew install python3 --verbose

/usr/local/bin/python: /usr/local/bin/brew
	#TODO: make this work on linux
	brew install python --verbose

/usr/local/bin/brew:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install | /usr/bin/ruby

## ALL THE TMUX STUFF

tmux: $(HOME)/.tmux.conf /usr/local/bin/tmux

$(HOME)/tmux:
	mkdir -p $(HOME)/tmux
	git clone https://github.com/tmux/tmux.git $(HOME)/tmux

/usr/local/bin/tmux: $(HOME)/tmux
	(cd $(HOME)/tmux/ && ./autogen.sh && ./configure && make && sudo make install)

$(HOME)/.tmux.conf:
	ln -s $(CURDIR)/tmux.conf $(HOME)/.tmux.conf

POWERLINE_DIR=$(HOME)/powerline
POWERLINE_FONTS_DIR=$(HOME)/powerline_fonts

powerline: $(POWERLINE_DIR) $(POWERLINE_FONTS_DIR)

$(POWERLINE_DIR):
	mkdir -p $(POWERLINE_DIR)
	(git clone https://github.com/asonawalla/powerline.git $(POWERLINE_DIR) && cd $(POWERLINE_DIR) && git checkout azim && python setup.py develop)

$(POWERLINE_FONTS_DIR):
	mkdir -p $(POWERLINE_FONTS_DIR)
	git clone https://github.com/powerline/fonts.git $(POWERLINE_FONTS_DIR)
	$(POWERLINE_FONTS_DIR)/install.sh

## ALL THE FISH STUFF

FISH_CONFIG_ROOT := $(HOME)/.config/fish

fish: $(FISH_CONFIG_ROOT)/config.fish fish-functions fish-completions

fish-functions: $(HOME)/.config/fish/functions/fisher.fish

$(HOME)/.config/fish/functions/fisher.fish:
	curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher

fish-completions: $(FISH_CONFIG_ROOT)/completions/kubectl.fish

$(FISH_CONFIG_ROOT)/completions/kubectl.fish:
	mkdir -p $(FISH_CONFIG_ROOT)/completions
	ln -s $(CURDIR)/fish/completions/kubectl.fish $(FISH_CONFIG_ROOT)/completions/kubectl.fish

$(FISH_CONFIG_ROOT)/config.fish:
	mkdir -p $(FISH_CONFIG_ROOT)
	ln -s $(CURDIR)/fish/config.fish $(HOME)/.config/fish/config.fish

## ALL THE CLEAN STUFF

clean: clean-vim clean-vim-config clean-tmux clean-powerline clean-powerline-fonts

clean-vim:
	(cd $(HOME)/vim && sudo make uninstall && make clean)

clean-vim-config:
	sudo rm -r $(HOME)/.vim || true
	rm $(HOME)/.vimrc || true

clean-powerline:
	sudo rm -r $(POWERLINE_DIR) || true
	sudo rm /usr/local/bin/powerline* || true

clean-powerline-fonts:
	sudo $(POWERLINE_FONTS_DIR)/uninstall.sh || true
	sudo rm -r $(POWERLINE_FONTS_DIR) || true

clean-tmux:
	sudo rm /usr/local/bin/tmux || true
	rm $(HOME)/.tmux.conf || true
	sudo rm -r $(HOME)/tmux || true

