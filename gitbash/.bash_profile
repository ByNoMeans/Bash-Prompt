# Call with errors in cygwin terminal with '\r$'; usually after changing config files and trying to ssh in

function _remove_carriage_returns() {
	test -f ~/gitstatus/gitstatus.prompt.sh && sed -i 's/\r$//g' ~/gitstatus/gitstatus.prompt.sh
	test -f ~/.bash_aliases && sed -i 's/\r$//g' ~/.bash_aliases
	test -f ~/.bash_profile && sed -i 's/\r$//g' ~/.bash_profile
	test -f ~/.git-completion.bash && sed -i 's/\r$//g' ~/.git-completion.bash
	test -f /c/cygwin/etc/bash.bashrc && sed -i 's/\r$//g' /c/cygwin/etc/bash.bashrc
	test -f /c/Program\ Files/etc/bash.bashrc && sed -i 's/\r$//g' /c/Program\ Files/etc/bash.bashrc
}

test -f ~/.bash_aliases && . ~/.bash_aliases
test -f ~/.git-completion.bash && . ~/.git-completion.bash
test -f ~/gitstatus/gitstatus.prompt.sh && . ~/gitstatus/gitstatus.prompt.sh
export HISTCONTROL=ignoreboth:erasedups
