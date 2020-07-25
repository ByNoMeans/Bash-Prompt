# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide. This software is distributed without any warranty.
# You should have received a copy of the CC0 Public Domain Dedication along
# with this software.
# If not, see <https://creativecommons.org/publicdomain/zero/1.0/>.

# /etc/bash.bashrc: executed by bash(1) for interactive shells.

# System-wide bashrc file

# Check that we haven't already been sourced.
([[ -z ${CYG_SYS_BASHRC} ]] && CYG_SYS_BASHRC="1") || return

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# If started from sshd, make sure profile is sourced
if [[ -n "$SSH_CONNECTION" ]] && [[ "$PATH" != *:/usr/bin* ]]; then
	source /etc/profile
fi

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# Warnings
unset _warning_found
for _warning_prefix in '' ${MINGW_PREFIX}; do
	for _warning_file in "${_warning_prefix}"/etc/profile.d/*.warning{.once,}; do
		test -f "${_warning_file}" || continue
		_warning="$(command sed 's/^/\t\t/' "${_warning_file}" 2>/dev/null)"
		if test -n "${_warning}"; then
			if test -z "${_warning_found}"; then
				_warning_found='true'
				echo
			fi
			if test -t 1; then
				printf "\t\e[1;33mwarning:\e[0m\n%s\n\n" "${_warning}"
			else
				printf "\twarning:\n%s\n\n" "${_warning}"
			fi
		fi
		[[ "${_warning_file}" == *.once ]] && rm -f "${_warning_file}"
	done
done
unset _warning_found
unset _warning_prefix
unset _warning_file
unset _warning

# If MSYS2_PS1 is set, use that as default PS1;
# if a PS1 is already set and exported, use that;
# otherwise set a default prompt
# of user@host, MSYSTEM variable, and current_directory
[[ -n "${MSYS2_PS1}" ]] && export PS1="${MSYS2_PS1}"
 #if we have the "High Mandatory Level" group, it means we're elevated
if [[ -n "$(command -v getent)" ]] && id -G | grep -q "$(getent -w group 'S-1-16-12288' | cut -d: -f2)"
  then _ps1_symbol='\[\e[1m\]#\[\e[0m\]'
  else _ps1_symbol='\$'
fi

#Colors
#https://unix.stackexchange.com/questions/124407/what-color-codes-can-i-use-in-my-ps1-prompt
# Simple: https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux

#Prompt "\something" customizations
#https://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html

export VIRTUAL_ENV_DISABLE_PROMPT=1

setPrompt() {
	function virtualenv-format() {
		venv=""
		#if [ -n "$VIRTUAL_ENV_DISABLE_PROMPT" ]; then
		VIRT_ENV_TXT=""
		if [ "$VIRTUAL_ENV" != "" ]; then
			VIRT_ENV_TXT=$(basename \""$VIRTUAL_ENV")
		elif [ "$(basename \""$VIRTUAL_ENV"\")" = "__" ]; then
			VIRT_ENV_TXT=[$(basename \`dirname \""$VIRTUAL_ENV"\"\`)]
		fi
		#fi
		if [ "${VIRT_ENV_TXT}" != "" ]; then
			venv='\[\033[1;36m\](\[\033[0;35m\]'"${VIRT_ENV_TXT}"'\[\033[1;36m\]) '
		fi
	}
	function git-format() {
		git_string=""
		if [ -d .git ]; then
			if [[ $(git status) != *"HEAD detached"* ]]; then
				local branch=""			
				branch=$(git symbolic-ref --short HEAD)
				git_string='\[\033[0;35m\]'"$branch"			
				(( $(git rev-list --all --count) == 0 )) && git_string="$git_string"'\[\033[0m\]{}'
				upstream=$(git rev-parse --abbrev-ref "$branch"@{upstream} 2>/dev/null | head -n 1) #$(g for-each-ref --format='%(upstream:short)' $(g symbolic-ref -q HEAD))
				if [ "$upstream" ]; then
					git_string="$git_string"'\[\033[1;36m\]->\[\033[0;35m\]'"${upstream%/*}"'\[\033[1;36m\]/\[\033[0;35m\]'"${upstream##*/}"				
					# git fetch to automatically update commit number here; but slows program
					declare -i numCommitsAhead=0
					declare -i numCommitsBehind=0
					numCommitsAhead=$(git rev-list --count @{u}..HEAD)
					numCommitsBehind=$(git rev-list --count HEAD..@{u})
					((numCommitsAhead > 0)) && git_string="$git_string"'\[\033[0m\]↑'"$numCommitsAhead"
					((numCommitsBehind > 0)) && git_string="$git_string"'\[\033[0m\]↓'"$numCommitsBehind"			
				else
					git_string="$git_string"'\[\033[0m\]\[\033[0m\]≠'
				fi
			elif [ ! "$upstream" ]; then
				git_string="$git_string"'\[\033[0;35m\]'"$(git rev-parse --short HEAD)\[\033[0m\]"'≠'
			else 
				git_string="$git_string"'\[\033[0;35m\]'"$(git rev-parse --short HEAD)"
			fi		
			[[ ! $(git remote) ]] && git_string="$git_string"'\[\033[0m\]✗' 
			declare -i added_index=0; declare -i modified_index=0; declare -i deleted_index=0
			declare -i unmerged_updated_index=0; declare -i untracked_index=0;				
			declare -i added_work_tree=0; declare -i modified_work_tree=0; declare -i deleted_work_tree=0
			declare -i unmerged_updated_work_tree=0; declare -i untracked_work_tree=0;
			while IFS= read -r line; do
				status_index="${line::1}"
				case $status_index in
					"A")
						added_index=$((added_index + 1))
						;;
					"M")
						modified_index=$((modified_index + 1))
						;;
					"D")
						deleted_index=$((deleted_index + 1))
						;;
					"U")
						unmerged_updated_index=$((unmerged_updated_index + 1))
						;;
					"?")
						untracked_index=$((untracked_index + 1))
						;;
				esac
				status_work_tree="${line:1:1}"
				case $status_work_tree in
					"A")
						added_work_tree=$((added_work_tree + 1))
						;;
					"M")
						modified_work_tree=$((modified_work_tree + 1))
						;;
					"D")
						deleted_work_tree=$((deleted_work_tree + 1))
						;;
					"U")
						unmerged_updated_work_tree=$((unmerged_updated_work_tree + 1))
						;;
					"?")
						untracked_work_tree=$((untracked_work_tree + 1))
						;;
				esac
			done < <(gs -s)
			local index=""
			local worktree=""
			index='\033[38;5;214m\]['
			((added_index > 0)) && index="$index"'+'"$added_index"
			((modified_index > 0)) && index="$index"'~'"$modified_index"
			((deleted_index > 0)) && index="$index"'-'"$deleted_index"
			((unmerged_updated_index > 0)) && index="$git_string"'Ψ'"$unmerged_updated_index"
			((untracked_index > 0)) && index="$index"'?'"$untracked_index"
			index="$index"']'
			worktree='\[\033[0;37m\]['
			((added_work_tree > 0)) && worktree="$worktree"'+'"$added_work_tree"
			((modified_work_tree > 0)) && worktree="$worktree"'~'"$modified_work_tree"
			((deleted_work_tree > 0)) && worktree="$worktree"'-'"$deleted_work_tree"
			((unmerged_updated_work_tree > 0)) && worktree="$worktree"'Ψ'"$unmerged_updated_work_tree"
			((untracked_work_tree > 0)) && worktree="$worktree"'?'"$untracked_work_tree"
			worktree="$worktree]"
			[ "${index: -18}" == "\033[38;5;214m\][]" ] && index=""
			[ "${worktree: -16}" == "\[\033[0;37m\][]" ] && worktree=""
			git_string=' \[\033[1;36m\]('"$git_string$index$worktree"'\[\033[1;36m\])'
		fi
	}
	\virtualenv-format
	\git-format
	PS1='\[\033]0;'"$TITLEPREFIX\007\]"'\n\[\033[33m\]\w\n\[\033[38;5;202m\]\u\[\033[32m\] in \[\033[1;34m\]\h\[\033[32m\] at \[\033[0;31m\][\A]'"$git_string\n$venv\[\033[0m\]$ "
}


export PROMPT_COMMAND='setPrompt'

[[ $(declare -p PS1 2>/dev/null | cut -c 1-11) == 'declare -x ' ]] ||
export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[35m\]$MSYSTEM\[\e[0m\] \[\e[33m\]\w\[\e[0m\]\n'"${_ps1_symbol}"' '
unset _ps1_symbol

# Uncomment to use the terminal colours set in DIR_COLORS
# eval "$(dircolors -b /etc/DIR_COLORS)"

# Fixup git-bash in non login env
shopt -q login_shell
