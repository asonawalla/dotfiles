#!/usr/bin/env make -f

.PHONY: editor-targets
editor-targets = \
	$(HOME)/.vim/autoload/plug.vim

.PHONY: editor
editor: core $(editor-targets) ## ViM configuration and plugins

$(HOME)/.vim/autoload/plug.vim: $(HOME)/.vimrc
	curl -fLo $(HOME)/.vim/autoload/plug.vim --create-dirs \
		     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	@vim +PlugInstall +qall

$(HOME)/.vimrc: $(CURDIR)/vimrc $(CURDIR)/snippets
	@ln -s $(CURDIR)/vimrc $(HOME)/.vimrc || echo "WARNING: .vimrc link failed"
	@mkdir -p $(HOME)/.vim
	@ln -s $(CURDIR)/snippets $(HOME)/.vim/snippets || echo "WARNING: snippets link failed"

