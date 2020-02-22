#!/usr/bin/env make -f

code: vim tmux $(HOME)/.gitconfig
clean-code: clean-vim-config clean-tmux clean-gitconfig
VIM_VERSION = 8.2.0
VIMDIR := "$(HOME)/vim-$(VIM_VERSION)"

.PHONY: vim
vim: $(HOME)/.vim/autoload/plug.vim

$(HOME)/.vim/autoload/plug.vim: $(HOME)/.vimrc
	curl -fLo $(HOME)/.vim/autoload/plug.vim --create-dirs \
		     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	@vim +PlugInstall +qall

$(HOME)/.vimrc: $(CURDIR)/vimrc $(CURDIR)/snippets
	@ln -s $(CURDIR)/vimrc $(HOME)/.vimrc || echo "WARNING: .vimrc link failed"
	@mkdir -p $(HOME)/.vim
	@ln -s $(CURDIR)/snippets $(HOME)/.vim/snippets || echo "WARNING: snippets link failed"

.PHONY: compile-vim
compile-vim: /usr/local/bin/vim

/usr/local/bin/vim: $(VIMDIR)
	(cd $(VIMDIR) && sudo make uninstall && sudo make clean)
	(cd $(VIMDIR) && ./configure \
		--with-features=huge \
		--enable-multibyte \
		--enable-rubyinterp=yes \
		--enable-python3interp=yes \
		--with-python3-config-dir=$(python3-config --configdir) \
		--enable-perlinterp=yes \
		--enable-luainterp=yes \
		--enable-gui=gtk2 --enable-cscope --prefix=/usr/local)
	(cd $(VIMDIR) && sudo make VIMRUNTIMEDIR=/usr/local/share/vim/vim82 )

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
	ln -s $(CURDIR)/tmux.conf $(HOME)/.tmux.conf || echo "WARNING: .tmux.conf link failed"

clean-tmux:
	sudo rm /usr/local/bin/tmux || true
	rm $(HOME)/.tmux.conf || true
	sudo rm -r $(HOME)/tmux || true

$(HOME)/.gitconfig:
	ln -s $(CURDIR)/.gitconfig $(HOME)/.gitconfig

clean-gitconfig:
	rm $(HOME)/.gitconfig || true
