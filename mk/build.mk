#!/usr/bin/env make -f

build: /snap/bin/go /usr/bin/docker

/snap/bin/go:
	sudo snap install go --classic
	vim +GoInstallBinaries +qall

/usr/bin/docker:
	sudo apt-get install --yes docker.io
	sudo usermod -aG docker $(USER)
