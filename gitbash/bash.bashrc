# System-wide bashrc file

# Check that we haven't already been sourced.
([[ -z ${CYG_SYS_BASHRC} ]] && CYG_SYS_BASHRC="1") || return

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# If started from sshd, make sure profile is sourced
[[ -n "$SSH_CONNECTION" ]] && in_ssh_client="true"

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

[[ -n "${MSYS2_PS1}" ]] && export PS1="${MSYS2_PS1}"

function _parse_git_status() {
  git_status=""
  up_down=""
  local count="0"
  declare -a index_array=()
  declare -a working_array=()
  local index=""
  local working=""
  while IFS= read -r line; do
    if [ "$count" == "0" ]; then
		count="1"
		[[ $line == *"ahead"* ]] && up_down+="↑"
		[[ $line == *"behind"* ]] && up_down+="↓"
		[ "${#up_down}" == "2" ] && up_down='↕'
	fi
    local index_status="${line::1}"
    if [[ ! " ${index_array[@]} " =~ " ${index_status} " ]] && [ "$index_status" != "0" ]; then
      index_array+=("$index_status")
      case $index_status in
      "A")
        index+='+'
        ;;
      "M")
        index+='~'
        ;;
	  "?")
        index+='%'
        ;;
      "D")
        index+='-'
        ;;
      "R")
        index+='≇'
	;;
      "U")
        index+='Ψ'
        ;;
      "C")
        index+='#'
        ;;
      esac
    fi
    local working_status="${line:1:1}"
    if [[ ! " ${working_array[@]} " =~ " ${working_status} " ]] && [ "$working_status" != "0" ]; then
      working_array+=("$working_status")
      case $working_status in
      "A")
        working=+='+'
        ;;
      "M")
        working+='~'
        ;;
	  "?")
        working+='%'
        ;;
      "D")
        working+='-'
        ;;
      "R")
	    working+='≇'
	    ;;
      "U")
        working+='Ψ'
        ;;
      "C")
	working+='#'
	;;
      esac
    fi
  done < <(git status --porcelain -b)
  if [ "$index" ]; then 
    index='\[\033[1;31m\][\033[38;5;212m\]'"$index"
    [ "$working" ] && working='\[\033[1;31m\]/\033[38;5;255m\]'"$working"'\[\033[1;31m\]] ' || index+='\[\033[1;31m\]] '
  else 
	[ "$working" ] && working='\[\033[1;31m\][\033[38;5;255m\]'"$working"'\[\033[1;31m\]] '
  fi
  git_status+="$index$working"
}

function _parse_git_info() {
  git_info=""
  is_upstream=""
  local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  git_info='\[\033[95;38;5;209m\]'"$branch "
  [[ $(git stash list) ]] && git_info='\[\033[95;38;5;247m\]^'"$git_info"
  upstream=$(git rev-parse --abbrev-ref "$branch"@{upstream} 2>/dev/null | head -n 1)
  if [ "$upstream" ]; then
    git_info+='\[\033[95;38;5;247m\]→ \[\033[95;38;5;215m\]'"${upstream%/*}"'\[\033[95;38;5;247m\]/\[\033[95;38;5;209m\]'"${upstream##*/} "
    [ "$up_down" ] && git_info+='\[\033[95;38;5;63m\]'"$up_down"
  elif [ "$branch" != "support/support" ] && [ "$branch" != "hotfix/hotfix" ] && [ "$branch" != "bugfix/bugfix" ] && [ "$branch" != "release/release" ] && [ "$branch" != "feature/feature" ]; then
    git_info+='\[\033[95;38;5;63m\]≠'
  fi
  [[ ! $(git remote) ]] && git_info+='\[\033[95;38;5;63m\]✗'
  [ "${git_info: -1}" == "≠" ] || [ "${git_info: -1}" == "✗" ] || [ "$up_down" ] && git_info+=' '
}

function _git_format() {
  git_string=""
  if [ -d .git ]; then
    _parse_git_status
    _parse_git_info
    git_string+="$git_info$git_status"
  fi
}

function _set_ssh() {
  ssh_prompt=""
  [ "$in_ssh_client" == "true" ] && ssh_prompt='\[\033[95;38;5;131m\]\u\[\033[95;38;5;237m\]@\[\033[95;38;5;095m\]\h '
}

function _set_venv() {
  export VIRTUAL_ENV_DISABLE_PROMPT=1
  venv=""
  python_version=""
  VIRT_ENV_TXT=""
  if [ "$VIRTUAL_ENV" != "" ]; then
    VIRT_ENV_TXT=$(basename \""$VIRTUAL_ENV")
  elif [ "$(basename \""$VIRTUAL_ENV"\")" = "__" ]; then
    VIRT_ENV_TXT=[$(basename \`dirname \""$VIRTUAL_ENV"\"\`)]
  fi
  if [ "${VIRT_ENV_TXT}" != "" ]; then
	venv='\[\033[95;38;5;247m\](\[\033[95;38;5;209m\]'"$VIRT_ENV_TXT"'\[\033[95;38;5;247m\]) '
	python_version="$(python -V 2>/dev/null)"
	[ "$python_version" ] && python_version='\[\033[95;38;5;227m\]🐍'"${python_version##* } "
  fi 
}

function _set_node() {
  node_version=""
  if [[ $(type nodist 2>/dev/null) ]] && [ -d node_modules ]; then
	node_version=$(command node -v 2>/dev/null)
	[ "$node_version" ] && node_version='\[\033[95;38;5;121m\]⬢'"${node_version/v} "
  fi
}

function _set_prompt_symbol() {
  prompt_symbol=""
  prompt_symbol="\$(if [ \$? = 0 ]; then echo \[\033[35m\]❯; else echo \[\033[31m\]❯; fi) "'\[\033[0m\]'
}

function _set_prompt() {
  PS1=""
  PS1+='\[\033]0;'"\007\]"'\n\[\033[95;38;5;123m\]\w '
  git_string=""
  _git_format
  _set_venv
  _set_node
  _set_ssh
  _set_prompt_symbol
  PS1+="$git_string$python_version$node_version\n$ssh_prompt$venv$prompt_symbol"
}

export PROMPT_COMMAND=_set_prompt

[[ $(declare -p PS1 2>/dev/null | cut -c 1-11) == 'declare -x ' ]] ||
  export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[35m\]$MSYSTEM\[\e[0m\] \[\e[33m\]\w\[\e[0m\]\n'"${_ps1_symbol}"' '
unset _ps1_symbol

# Uncomment to use the terminal colours set in DIR_COLORS
# eval "$(dircolors -b /etc/DIR_COLORS)"

shopt -q login_shell
