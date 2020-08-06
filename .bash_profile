test -f ~/.profile && . ~/.profile
test -f ~/.bashrc && . ~/.bashrc

[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases
[[ -f ~/.git-completion.bash ]] && source ~/.git-completion.bash

export HISTCONTROL=ignoreboth:erasedups
