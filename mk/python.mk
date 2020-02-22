#!/usr/bin/env make -f

.PHONY: python-targets
python-targets = \
	$(HOME)/.local/bin/pipenv

.PHONY: python
python: core $(python-targets) ## Python development tools

/usr/bin/pip3:
	sudo apt-get install --yes python3-pip

$(HOME)/.local/bin/pipenv: /usr/bin/pip3
	python3 -m pip install pipenv

