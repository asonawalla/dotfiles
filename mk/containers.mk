#!/usr/bin/env make -f

.PHONY: containers-targets
containers-targets = \
	/usr/bin/docker \
	/snap/bin/microk8s.status \
	/snap/bin/kubectl

.PHONY: containers
containers: core $(containers-targets) ## Container development tools (docker, kubernetes)

/usr/bin/docker:
	sudo apt-get install -y docker.io
	sudo usermod -aG docker $(USER)
	echo 'gcloud auth print-access-token | docker login -u oauth2accesstoken --password-stdin https://gcr.io' | newgrp docker

/snap/bin/microk8s.status:
	sudo snap install microk8s --classic --channel 1.15/stable
	sudo usermod -aG microk8s "$(USER)"
	mkdir -p "$(HOME)"/.kube
	echo "microk8s.config >> $(HOME)/.kube/config" | newgrp microk8s

/snap/bin/kubectl:
	sudo snap install kubectl --classic
