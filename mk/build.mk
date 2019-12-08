#!/usr/bin/env make -f

build: /snap/bin/go /usr/bin/docker /snap/bin/microk8s.status

/snap/bin/go:
	sudo snap install go --classic
	vim +GoInstallBinaries +qall

/usr/bin/docker:
	sudo apt-get install --yes docker.io
	sudo usermod -aG docker $(USER)

/snap/bin/microk8s.status:
	sudo snap install microk8s --classic
	sudo usermod -aG microk8s $(USER)