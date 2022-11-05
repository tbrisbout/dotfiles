#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#
# Misc aliases
#
alias ls='ls --color=auto'
alias la='ls -halrt'
alias wl='wc -l'
alias ..='cd ..'
alias ...='cd ../..'
alias src='source $HOME/.bashrc'
alias bashrc='vim $HOME/.bashrc'
alias vimrc='vim $HOME/.vimrc'
alias nvim="$HOME/bin/nvim.appimage"
alias vim=nvim
alias v=nvim
alias e=exit
alias tnew='tmux new -s $(basename $(pwd) | cut -d"." -f1)'
alias open='xdg-open 2>/dev/null'
alias ag='ag --ignore node_modules'

alias fd=fdfind

function getcol() { awk "{print \$${1:-1}}"; }
alias c1='getcol 1'
alias c2='getcol 2'
alias c3='getcol 3'

# git
alias g='_f() { if [[ $# == 0 ]]; then git status --branch; else git "$@"; fi }; _f'
alias gd='git diff'
alias gap='git add -p'
alias gc='git ci'
alias br='git br | fzf | xargs git co'
alias gbr='git br -r | fzf | xargs git co --track' # Checkout remote branch locally

# pandoc to create pdf from markdown
alias pandock='docker run --rm -v "$(pwd):/data" -u $(id -u):$(id -g) pandoc/latex'

# fuzzy
alias fgl='fzf_git_log'
alias fcd='fzf_change_directory'
alias f=fcd
alias fkill='fzf_kill'
alias fenv='env | fzf'

alias fnpm='npm run $(cat package.json | jq -r ".scripts | keys[]" | fzf)'

# Enable the useful Bash features:
#  - autocd, no need to type 'cd' when changing directory
#  - cdspell, automatically fix directory typos when changing directory
#  - direxpand, automatically expand directory globs when completing
#  - dirspell, automatically fix directory typos when completing
#  - globstar, ** recursive glob
#  - histappend, append to history, don't overwrite
#  - histverify, expand, but don't automatically execute, history expansions (!!)
#  - nocaseglob, case-insensitive globbing
#  - no_empty_cmd_completion, don't TAB expand empty lines
shopt -s autocd cdspell direxpand dirspell globstar histappend histverify \
    nocaseglob no_empty_cmd_completion

#
# Cleaner history (ignore short commands...)
#
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE=?:??
HISTFILESIZE=50000
HISTSIZE=50000
PROMPT_COMMAND='history -a'

#
# Simple prompt
#
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\] \[\033[33;1m\]\w\[\033[m\]\$(parse_git_branch) ➜ "

if [ -e ~/.bashrc.aliases ] ; then
   source ~/.bashrc.aliases
fi

BROWSER=/usr/bin/chromium
export EDITOR="$HOME/bin/nvim.appimage"

export PATH="$VOLTA_HOME/bin:$PATH"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export GOPATH="$HOME/dev/go"
export GOBIN="$GOPATH/bin"
export PATH="$HOME/.cargo/bin:$HOME/bin:$HOME/bin/go/bin:$GOBIN:$PATH"

#
# Keyboard:
# - Caps Lock as Ctrl
# - Right Alt as compose key
#
setxkbmap -option ctrl:nocaps -option compose:ralt

#
# fzf config and goodies
#
export FZF_DEFAULT_COMMAND='fd --type f --color=never'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d . --color=never'
export FZF_DEFAULT_OPTS='--height 75% --multi --reverse --bind ctrl-f:page-down,ctrl-b:page-up'

# Open a git log browser with diff preview
fzf_git_log() {
  local commits=$(
    git lg --color=always "$@" |
      fzf --ansi --no-sort --height 100% \
          --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
                     xargs -I@ sh -c 'git show --color=always @'"
    )
  if [[ -n $commits ]]; then
      local hashes=$(printf "$commits" | cut -d' ' -f2 | tr '\n' ' ')
      git show $hashes
  fi
}

# fuzzy find a directory and cd to it
fzf_change_directory() {
    local directory=$(
      fd --type d | \
      fzf --query="$1" --no-multi --select-1 --exit-0 \
          --preview 'tree -C {} | head -100'
      )
    if [[ -n $directory ]]; then
        cd "$directory"
    fi
}

# Fuzzy find a process and send SIGKILL
fzf_kill() {
    local pid_col=2
    local pids=$(
      ps -f -u $USER | sed 1d | fzf --multi | tr -s [:blank:] | cut -d' ' -f"$pid_col"
      )
    if [[ -n $pids ]]; then
        echo "$pids" | xargs kill -9 "$@"
    fi
}
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
