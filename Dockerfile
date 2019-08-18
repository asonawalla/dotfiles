FROM golang:1.12
WORKDIR /dotfiles

RUN apt-get update && \
      apt-get install -y \
        build-essential \
        curl \
        git \
        libncurses5-dev \
        sudo

COPY ./ ./

RUN make vim
