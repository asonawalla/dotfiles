# go environment setup
set -x GOROOT /usr/local/go
set -x GOPATH $HOME/go
set -x PATH $PATH $GOROOT/bin $GOPATH/bin

# add google cloud sdk bin to the path
set -x PATH $PATH $HOME/google-cloud-sdk/bin

# additional go build flags for mac os x. this works with the
# brew install'd version of rocksdb. presumably.
# set -x CGO_CPPFLAGS "-I/usr/local/include"
# set -x CGO_LDFLAGS "-L'/usr/local/lib'"

# easy way to update submodules
alias gsync='git submodule sync; and git submodule update --init --recursive'

# alias kubectl commands
alias local='kubectl config use-context local'
alias production='kubectl config use-context production'
alias context='kubectl config current-context'
alias cycle-postgres='kubectl get pod -l app=postgresql -o json | jq -r .items[0].metadata.name | xargs -n 1 kubectl delete pod'

# for some reason thefuck isnt working in functions and im too lazy to debug why
# eval (thefuck --alias | tr '\n' ';')

set -g fish_user_paths "/usr/local/opt/bison@2.7/bin" $fish_user_paths

# vg auto setup
command -v vg >/dev/null 2>&1; and vg eval --shell fish | source

# All the conditional os stuff should go here
switch (uname)
    case Linux
            # Nothing to see here
    case Darwin
						# use gnu coreutils by default (os x  only)
						set -x PATH /usr/local/opt/coreutils/libexec/gnubin $PATH

						# these cgo flags point rocksdb to the local installation.
						set rdb '/Users/asonaw/workspace/src/github.com/facebook/rocksdb'
						set -x CGO_CFLAGS '-I'$rdb'/include'
						set -x CGO_LDFLAGS '-L'$rdb' -lrocksdb -lstdc++ -lm -lz -lbz2 -lsnappy'
						set -x CPATH $rdb'/include'
    case '*'
            echo ERROR: OS not detected.
end

# direnv
eval (direnv hook fish)

