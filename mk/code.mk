#!/usr/bin/env make -f

code: vim tmux $(HOME)/.gitconfig
clean-code: clean-vim-config clean-tmux clean-gitconfig
VIM_VERSION = 8.2.0
VIMDIR := "$(HOME)/vim-$(VIM_VERSION)"

vim: /usr/local/bin/vim $(HOME)/.vim/autoload/plug.vim

$(HOME)/.vim/autoload/plug.vim: $(HOME)/.vimrc
	curl -fLo $(HOME)/.vim/autoload/plug.vim --create-dirs \
		     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	@vim +PlugInstall +qall

vim-config: $(HOME)/.vim/autoload/plug.vim

$(HOME)/.vimrc: $(CURDIR)/vimrc
	@ln -s $(CURDIR)/vimrc $(HOME)/.vimrc

/usr/local/bin/vim: $(VIMDIR)
	(cd $(VIMDIR) && sudo make uninstall && sudo make clean)
	(cd $(VIMDIR) && ./configure \
		--with-features=huge \
		--enable-multibyte \
		--enable-rubyinterp=yes \
		--enable-pythoninterp=no \
		--enable-python3interp=yes \
		--enable-perlinterp=yes \
		--enable-luainterp=yes \
		--enable-gui=gtk2 --enable-cscope --prefix=/usr/local)
	(cd $(VIMDIR) && make)
	(cd $(VIMDIR) && sudo make install)

$(VIMDIR):
	(cd $(HOME) && wget -O vim.tar.gz https://github.com/vim/vim/archive/v$(VIM_VERSION).tar.gz)
	(cd $(HOME) && tar -xvzf vim.tar.gz)

clean-vim:
	(cd $(VIMDIR) && sudo make uninstall && make clean)

clean-vim-config:
	sudo rm -r $(HOME)/.vim || true
	rm $(HOME)/.vimrc || true

tmux: $(HOME)/.tmux.conf install-tmux

install-tmux:
	@which tmux || echo "==> YOU NEED TO INSTALL TMUX"
	@which tmux || exit 1

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

$(HOME)/.gitconfig:
	ln -s $(CURDIR)/.gitconfig $(HOME)/.gitconfig

clean-gitconfig:
	rm $(HOME)/.gitconfig || true
