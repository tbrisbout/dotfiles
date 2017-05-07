#!/bin/bash

# Warning - Experimental
# Install most dev env and dependencies - kind of works on Ubuntu 16.04
# This script should be repeatable (most script will do nothing if launched again)

# Some operations are still manual (have not looked for a scripted alternative)
# - Map CapsLock to Control
# - Use RightAlt as ComposeKey
# - Set vlc as default video app

# Add docker apt repository
sudo apt-get -y install \
  apt-transport-https \
  ca-certificates \
  curl

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"

# Software install
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y vim git tree curl xclip tmux \
  zsh zsh-antigen silversearcher-ag \
  cmake build-essential python-dev \ # YouCompleteMe compile dependencies
  docker-ce \
  jq \
  vlc gimp \
  gnome-tweak-tool # Used for mapping CapsLock to Control

# install docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/1.13.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
sudo chmod u+x /usr/local/bin/docker-compose


# Create bin dir & scripts
mkdir -p ~/bin/scripts

# Oh My Zsh install
# You may need to manually exit zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Remove default .zshrc config file / will be updated with dotfiles
rm ~/.zshrc

# Install antigen
curl https://cdn.rawgit.com/zsh-users/antigen/v1.3.4/bin/antigen.zsh > ~/bin/scripts/antigen.zsh

# Dotfiles
git clone https://github.com/tbrisbout/dotfiles
mkdir -p dotfiles/.vim

ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.vim ~/.vim
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.gitconfig ~/.gitconfig

# Install node via nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
nvm install --lts
nvm use --lts

# Install ruby via rbenv
sudo apt-get install -y rbenv ruby-build
rbenv install 2.2.3

# Install tmuxinator
gem install tmuxinator

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install vim plugins
vim +PlugInstall +qall

# Docker Group (use docker without sudo)
sudo groupadd docker
sudo usermod -aG docker $USER
