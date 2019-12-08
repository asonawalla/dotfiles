#!/usr/bin/env make -f

shell: fish
clean-shell: #TODO

FISH_CONFIG_ROOT := $(HOME)/.config/fish

fish: $(FISH_CONFIG_ROOT)/config.fish fish-functions fish-completions /usr/bin/fish

/usr/bin/fish:
	sudo apt-get install --yes fish
	chsh -s /usr/bin/fish

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
