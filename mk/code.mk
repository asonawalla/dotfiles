#!/usr/bin/env make -f

code: vim tmux
clean-code: clean-vim-config clean-tmux

vim: install-vim $(HOME)/.vim/autoload/plug.vim

install-vim:
	@which vim || "echo => YOU NEED TO INSTALL VIM && exit 1"

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

clean-vim:
	(cd $(HOME)/vim && sudo make uninstall && make clean)

clean-vim-config:
	sudo rm -r $(HOME)/.vim || true
	rm $(HOME)/.vimrc || true

tmux: $(HOME)/.tmux.conf install-tmux

install-tmux:
	@which tmux || "echo => YOU NEED TO INSTALL TMUX && exit 1"

$(HOME)/tmux:
	mkdir -p $(HOME)/tmux
	git clone https://github.com/tmux/tmux.git $(HOME)/tmux

/usr/local/bin/tmux: $(HOME)/tmux
	(cd $(HOME)/tmux/ && ./autogen.sh && ./configure && make && sudo make install)

$(HOME)/.tmux.conf:
	ln -s $(CURDIR)/tmux.conf $(HOME)/.tmux.conf

clean-tmux:
	sudo rm /usr/local/bin/tmux || true
	rm $(HOME)/.tmux.conf || true
	sudo rm -r $(HOME)/tmux || true
