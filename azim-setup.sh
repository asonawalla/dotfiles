#!/bin/bash

set -x
trap 'set +x' EXIT

# Azim's personal setup script.
if [[ `whoami` != "azim" ]]; then
  echo "stop tryina jack my script"
  exit 1
fi

sudo apt-get update && \
sudo apt-get install -y wget tmux vim-nox git python-pip cmake

# Setup tmux from github
wget -O $HOME/.tmux.conf https://gist.githubusercontent.com/asonawalla/6b079a9b0a7085c6d55006758b8c199e/raw/.tmux.conf

# Setup .vimrc from github
wget -O $HOME/.vimrc https://gist.githubusercontent.com/asonawalla/ed49540398a02a4fac97/raw/.vimrc

# Install vim plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# Compile YouCompleteMe
(cd $HOME/.vim/bundle/YouCompleteMe/ && python install.py --gocode-completer)

# Clone, install, and setup powerline
sudo pip install setuptools
mkdir -p $HOME/Projects
git clone git@github.com:asonawalla/powerline.git $HOME/Projects/powerline
(cd $HOME/Projects/powerline/ && git checkout azim && sudo python setup.py develop)

# Powerline fonts
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
mkdir -p $HOME/.fonts/
mv PowerlineSymbols.otf ~/.fonts/
fc-cache -vf ~/.fonts/
mkdir -p $HOME/.config/fontconfig/conf.d/
mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/

# Powerline > tmux statusline
echo "run-shell \"powerline-daemon -q\"" >> $HOME/.tmux.conf
echo "source \"$HOME/Projects/powerline/powerline/bindings/tmux/powerline.conf\"" >> $HOME/.tmux.conf

echo "setup complete!"
