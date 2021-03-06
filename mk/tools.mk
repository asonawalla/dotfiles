#!/usr/bin/env make -f

.PHONY: tools-targets
tools-targets = \
	/usr/bin/protoc \
	$(HOME)/go/bin/helm \
	/usr/bin/tig \
	$(HOME)/.local/bin/kubectx \
	$(HOME)/.local/bin/kubens

.PHONY: tools
tools: core $(tools-targets) ## misc tools

/usr/bin/protoc:
	sudo apt-get install --yes protobuf-compiler

HELM_VERSION=3.1.1

$(HOME)/go/bin/helm: /snap/bin/go $(HOME)/code/helm
	(cd $(HOME)/code/helm && git checkout v$(HELM_VERSION) && go install -v ./cmd/...)
	$(HOME)/go/bin/helm repo add stable https://kubernetes-charts.storage.googleapis.com/
	$(HOME)/go/bin/helm repo update

$(HOME)/code/helm:
	git clone https://github.com/helm/helm $(HOME)/code/helm

/usr/bin/tig:
	sudo apt-get install --yes tig

$(HOME)/.local/bin/kubectx:
	mkdir -p $(HOME)/.local/bin
	wget -O $(HOME)/.local/bin/kubectx https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx
	chmod +x $(HOME)/.local/bin/kubectx

$(HOME)/.local/bin/kubens:
	mkdir -p $(HOME)/.local/bin
	wget -O $(HOME)/.local/bin/kubens https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens
	chmod +x $(HOME)/.local/bin/kubens

.PHONY: bazel
bazel: /usr/bin/bazel

/usr/bin/bazel:
	curl https://bazel.build/bazel-release.pub.gpg | sudo apt-key add -
	echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
	sudo apt-get update && sudo apt-get install --yes bazel
