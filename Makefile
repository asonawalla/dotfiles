#!/usr/bin/env make -f

all:

vim: /usr/local/bin/vim $(HOME)/.vim/autoload/plug.vim
	@vim +PlugInstall +qall

$(HOME)/.vim/autoload/plug.vim: $(HOME)/.vimrc
	curl -fLo $(HOME)/.vim/autoload/plug.vim --create-dirs \
		     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

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
	brew install python3 --verbose

/usr/local/bin/python: /usr/local/bin/brew
	brew install python --verbose

/usr/local/bin/brew:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install | /usr/bin/ruby

clean: clean-vim

clean-vim:
	sudo rm -r $(HOME)/.vim || true
	rm $(HOME)/.vimrc || true

