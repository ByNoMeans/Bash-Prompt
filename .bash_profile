test -f ~/.bash_aliases && . ~/.bash_aliases
test -f ~/.git-completion.bash && . ~/.git-completion.bash
test -f ~/gitstatus/gitstatus.prompt.sh && . ~/gitstatus/gitstatus.prompt.sh
eval "$(uru_rt admin install)"
export HISTCONTROL=ignoreboth:erasedups
