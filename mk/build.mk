#!/usr/bin/env make -f

build: /snap/bin/go /snap/bin/docker /snap/bin/microk8s.status /usr/local/bin/tilt

/snap/bin/go:
	sudo snap install go --classic
	vim +GoInstallBinaries +qall

/snap/bin/docker:
	sudo addgroup --system docker
	sudo adduser $(USER) docker
	echo sudo snap install docker | newgrp docker
	gcloud auth print-access-token | docker login -u oauth2accesstoken --password-stdin https://gcr.io

/snap/bin/microk8s.status:
	sudo snap install microk8s --classic
	sudo usermod -aG microk8s $(USER)
	sudo snap install kubectl --classic
	mkdir -p $(HOME)/.kube
	echo "microk8s.config >> $(HOME)/.kube/config" | newgrp microk8s

python: $(HOME)/.local/bin/pipenv

/usr/bin/pip3:
	sudo apt-get install --yes python3-pip

$(HOME)/.local/bin/pipenv: /usr/bin/pip3
	/usr/bin/pip3 install pipenv

/usr/local/bin/tilt:
	curl -fsSL https://raw.githubusercontent.com/windmilleng/tilt/master/scripts/install.sh | bash
