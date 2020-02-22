#!/usr/bin/env make -f

.PHONY: core-targets
core-targets = \
	$(HOME)/.tmux.conf \
	$(HOME)/.gitconfig \
	/usr/bin/cmake \
	/usr/bin/python3-config \
	/usr/bin/fish

.PHONY: core
core: $(core-targets) ## Core development environment tools

$(HOME)/.tmux.conf:
	@ln -s $(CURDIR)/tmux.conf $(HOME)/.tmux.conf || echo "WARNING: .tmux.conf link failed"

$(HOME)/.gitconfig:
	ln -s $(CURDIR)/.gitconfig $(HOME)/.gitconfig

/usr/bin/cmake:
	sudo apt-get install --yes cmake

/usr/bin/python3-config:
	sudo apt-get install --yes python3-dev

/usr/bin/fish:
	sudo apt-get install --yes fish
	sudo chsh -s /usr/bin/fish "$(USER)"
	mkdir -p ~/.config/fish
	cp ./fish/config.fish  ~/.config/fish/
