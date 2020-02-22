#!/usr/bin/env make -f

.PHONY: tools-targets
tools-targets = \
	/usr/bin/protoc \
	$(HOME)/go/bin/helm \
	/usr/bin/tig

.PHONY: tools
tools: core $(tools-targets) ## misc tools

/usr/bin/protoc: apt-update
	sudo apt-get install --yes protobuf-compiler

$(HOME)/go/bin/helm: /snap/bin/go $(HOME)/code/helm
	(cd $(HOME)/code/helm && git checkout v3.0.2 && go install -v ./cmd/...)
	$(HOME)/go/bin/helm repo add stable https://kubernetes-charts.storage.googleapis.com/
	$(HOME)/go/bin/helm repo update

$(HOME)/code/helm:
	git clone https://github.com/helm/helm $(HOME)/code/helm

/usr/bin/tig: apt-update
	sudo apt-get install --yes tig
