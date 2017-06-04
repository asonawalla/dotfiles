#!/usr/bin/env make -f

all:

clean: clean-vim

clean-vim:
	sudo rm -r $(HOME)/.vim || true
	rm $(HOME)/.vimrc || true

vim-plug:
	@echo "Installing vim-plug"
	curl -fLo $(HOME)/.vim/autoload/plug.vim --create-dirs \
		     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim: vim-plug
	@cp vimrc $(HOME)/.vimrc
	@vim +PlugInstall +qall
