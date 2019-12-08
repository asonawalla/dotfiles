#!/usr/bin/env make -f

/usr/local/bin/python3: /usr/local/bin/brew
	#TODO: make this work on linux
	brew install python3 --verbose

/usr/local/bin/python: /usr/local/bin/brew
	#TODO: make this work on linux
	brew install python --verbose

/usr/local/bin/brew:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install | /usr/bin/ruby

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

clean-powerline:
	sudo rm -r $(POWERLINE_DIR) || true
	sudo rm /usr/local/bin/powerline* || true

clean-powerline-fonts:
	sudo $(POWERLINE_FONTS_DIR)/uninstall.sh || true
	sudo rm -r $(POWERLINE_FONTS_DIR) || true
