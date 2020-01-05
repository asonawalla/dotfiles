#!/bin/bash

set -e
set -o pipefail

bold() {
  printf "\e[1m${1}\e[0m\n"
}

if_absent() {
    bold "=> Checking for ${1}"
    install() {
        bold "==> Installing ${1}"
        "$2"
    }
    which "$1" || install "$@"
}

main() {
    bold "=> Running setup script"
    sudo apt-get update

    install_make() {
        sudo apt-get install --yes build-essential
    }
    if_absent make install_make

    install_fish() {
        sudo apt-get install --yes fish
	    sudo chsh -s /usr/bin/fish "${USER}"
        mkdir -p ~/.config/fish
        cp ./fish/config.fish  ~/.config/fish/
    }
    if_absent fish install_fish

    install_go() {
        sudo snap install go --classic
    }
    if_absent go install_go

    install_docker() {
        sudo apt-get install --yes docker.io
        sudo usermod -aG docker "${USER}"
        # only authenticate docker if we've got a functional gcloud
        which gcloud || return 0
        echo 'gcloud auth print-access-token | docker login -u oauth2accesstoken --password-stdin https://gcr.io' | newgrp docker
    }
    if_absent docker install_docker

    install_kubectl() {
        sudo snap install kubectl --classic
    }
    if_absent kubectl install_kubectl

    install_microk8s() {
        sudo snap install microk8s --classic
        sudo usermod -aG microk8s "${USER}"
        mkdir -p "${HOME}"/.kube
        echo "microk8s.config >> ${HOME}/.kube/config" | newgrp microk8s
    }
    if_absent microk8s.status install_microk8s

    install_pipenv() {
        sudo apt-get install --yes python3-pip
        pip3 install pipenv
    }
    if_absent pipenv install_pipenv

    install_tilt() {
	    curl -fsSL https://raw.githubusercontent.com/windmilleng/tilt/master/scripts/install.sh | bash
    }
    if_absent tilt install_tilt

    install_skaffold() {
        wget -O skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64
        chmod +x skaffold
        sudo mv skaffold /usr/local/bin
    }
    if_absent skaffold install_skaffold

    install_helm() {
        git clone https://github.com/helm/helm ${HOME}/code/helm
        cd ${HOME}/code/helm
        git checkout v3.0.2
        go install -v ./cmd/...
        ${HOME}/go/bin/helm repo add stable https://kubernetes-charts.storage.googleapis.com/
    }
    if_absent helm install_helm
}

main "$@"