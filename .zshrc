export ZSH=$HOME/.oh-my-zsh

source $HOME/bin/scripts/antigen.zsh
local b="antigen-bundle"

antigen use oh-my-zsh
antigen theme "robbyrussell"

$b git
$b tmuxinator
$b zsh-users/zsh-autosuggestions
$b zsh-users/zsh-syntax-highlighting
$b lukechilds/zsh-better-npm-completion
$b greymd/docker-zsh-completion

antigen apply

alias mux=tmuxinator

# User configuration

export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"
export TERM="screen-256color"
export EDITOR='nvim'

# Proxy setting
[ -f ~/.proxy ] && source ~/.proxy

# Use Ctrl-z to switch between vim and cli
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# Avoid changing window name in tmux
DISABLE_AUTO_TITLE="true"

# use node executable without installing them global
if echo $PATH | grep node_modules/.bin >/dev/null 2>/dev/null; then
     true
else
    export PATH="$PATH:node_modules/.bin:$HOME/bin"
fi

# add rbenv to path
export PATH="$HOME/.rbenv/shims:$PATH"
rbenv global 2.2.3

# load nvm and use lts node version
export NVM_DIR="/home/thomas/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
nvm use --silent --lts

# Configure keyboard in console (CapsLock as Ctrl and RightAlt as Compose)
setxkbmap -option ctrl:nocaps -option compose:ralt
