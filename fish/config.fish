# snap environment setup
set -x PATH $PATH /snap/bin

# go environment setup
set -x GOPATH $HOME/go
set -x PATH $PATH $GOPATH/bin

# pip environment setup
set -x PATH $PATH $HOME/.local/bin
