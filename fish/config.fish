# pippio go setup
set -x GOROOT /usr/local/go
set -x GOPATH $HOME/workspace
set -x PATH $PATH $GOROOT/bin $GOPATH/bin

# add gcloud sdk stuff to the path
set -x PATH $PATH $HOME/google-cloud-sdk/bin

# Testing keys for pippio-testing s3 bucket
set -x AWS_ACCESS_KEY_ID ***REMOVED***
set -x AWS_SECRET_ACCESS_KEY ***REMOVED***

# legacy pippio stuff
set -x PIPPIO_DEV 1
set -x PIPPIO_ASSET_DIRECTORY $HOME/workspace/src/assets/

# android studio
set -x ANDROID_STUDIO /opt/android-studio
set -x PATH $PATH $ANDROID_PATH/bin

# easy way to update submodules
alias gsync='git submodule sync; and git submodule update --init --recursive'

# alias kubectl commands
alias local='kubectl config use-context local'
alias production='kubectl config use-context production'
alias context='kubectl config current-context'
alias cycle-postgres='kubectl get pod -l app=postgresql -o json | jq -r .items[0].metadata.name | xargs -n 1 kubectl delete pod'

# node version manager
# set -x NVM_DIR "/home/azim/.nvm"
# bass source "$NVM_DIR/nvm.sh"  # This loads nvm

