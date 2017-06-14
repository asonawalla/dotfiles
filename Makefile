#!/usr/bin/env make -f

all: vim fish

vim: /usr/local/bin/vim $(HOME)/.vim/autoload/plug.vim

$(HOME)/.vim/autoload/plug.vim: $(HOME)/.vimrc
	curl -fLo $(HOME)/.vim/autoload/plug.vim --create-dirs \
		     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	@vim +PlugInstall +qall

$(HOME)/.vimrc:
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

/usr/local/bin/python3: /usr/local/bin/brew
	#TODO: make this work on linux
	brew install python3 --verbose

/usr/local/bin/python: /usr/local/bin/brew
	#TODO: make this work on linux
	brew install python --verbose

/usr/local/bin/brew:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install | /usr/bin/ruby

FISH_CONFIG_ROOT := $(HOME)/.config/fish

fish: $(FISH_CONFIG_ROOT)/config.fish fish-functions fish-completions

fish-functions:
	#TODO: all of these

fish-completions: $(FISH_CONFIG_ROOT)/completions/kubectl.fish

$(FISH_CONFIG_ROOT)/completions/kubectl.fish:
	mkdir -p $(FISH_CONFIG_ROOT)/completions
	ln -s $(CURDIR)/fish/completions/kubectl.fish $(FISH_CONFIG_ROOT)/completions/kubectl.fish

$(FISH_CONFIG_ROOT)/config.fish:
	ln -s $(CURDIR)/fish $(HOME)/.config/fish/config.fish

clean: clean-vim clean-vim-config

clean-vim:
	(cd $(HOME)/vim && sudo make uninstall && make clean)

clean-vim-config:
	sudo rm -r $(HOME)/.vim || true
	rm $(HOME)/.vimrc || true

