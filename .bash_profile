test -f ~/.profile && . ~/.profile
test -f ~/.bashrc && . ~/.bashrc

test -f ~/.bash_aliases && . ~/.bash_aliases
test -f ~/.git-completion.bash && . ~/.git-completion.bash
test -f ~/.git-completion.bash && . ~/gitstatus/gitstatus.prompt.sh

export HISTCONTROL=ignoreboth:erasedups
