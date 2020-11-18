([[ -z ${CYG_SYS_BASHRC} ]] && CYG_SYS_BASHRC="1") || return

[[ "$-" != *i* ]] && return

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
        printf "\t\033[1;33mwarning:\033[0m\n%s\n\n" "${_warning}"
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
  declare -a index_array=()
  declare -a working_array=()
  local index=""
  local working=""
  local count="0"
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
      "?")
        index+='%'
        ;;
	  "A")
        index+='+'
        ;;
      "M")
        index+='~'
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
      "?")
        working+='%'
        ;;
	  "A")
        working=+='+'
        ;;
      "M")
        working+='~'
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
  [ "$index" ] && index='\[\033[95;38;5;63m\]'"$index "
  [ "$working" ] && working='\[\033[38;5;206m\]'"$working "
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
    [ "$up_down" ] && git_info+='\[\033[31m\]'"$up_down"
  elif [ "$branch" != "support/support" ] && [ "$branch" != "hotfix/hotfix" ] && [ "$branch" != "bugfix/bugfix" ] && [ "$branch" != "release/release" ] && [ "$branch" != "feature/feature" ]; then
    git_info+='\[\033[31m\]≠'
  fi
  [[ ! $(git remote) ]] && git_info+='\[\033[31m\]✗'
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
  [ "$in_ssh_client" == "true" ] && ssh_prompt='\[\033[95;38;5;131m\]\u\[\033[95;38;5;247m\]@\[\033[95;38;5;095m\]\h '
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
	[ "$python_version" ] && python_version='\[\033[33m\]🐍'"${python_version##* } "
  fi 
}

function _set_node() {
  node_version=""
  [ -f package.json ] || [ -d node_modules ] || [ -f *.js ] || return;
  [[ $(type nodist 2>/dev/null) ]] && node_version=$(command node -v 2>/dev/null)
  [ "$node_version" ] && node_version='\[\033[95;38;5;121m\]⬢'"${node_version/v} "
}

function _set_ruby() {
	ruby_version=""
	[ -f Gemfile ] || [ -f Rakefile ] || [ -f *.rb ] || return;
	if [[ $(type uru 2>/dev/null) ]]; then
		ruby_version=$(uru ls | grep -m 1 "=>" | tr -s ' ' | cut -d ' ' -f 6)
		[ -z "$ruby_version" ] && [[ $(type ruby 2>/dev/null) ]] && ruby_version=$(ruby --version | cut -d ' ' -f 2)
	fi
	[ "$ruby_version" ] && ruby_version='\[\033[95;38;5;197m\]💎'"${ruby_version%p*}"
}

function _set_prompt_symbol() {
  prompt_symbol=""
  prompt_symbol="\$(if [ \$? = 0 ]; then echo \[\033[35m\]❯; else echo \[\033[31m\]❯; fi) "'\[\033[0m\]'
}

function _set_prompt() {
  PS1=""
  PS1="\[\033]0;$PWD\007\]"
  PS1+='\n\[\033[36m\]\w '
  git_string=""
  _git_format
  _set_venv
  # UNCOMMENT TO SEE NODE VERSION IN DIRECTORES WITH NODE FILES
  #_set_node
  # UNCOMMENT TO SEE RUBY VERSION IN DIRECTORES WITH RUBY FILES
  #_set_ruby
  _set_ssh
  _set_prompt_symbol
  PS1+="$git_string$python_version$node_version$ruby_version\n$ssh_prompt$venv$prompt_symbol"
}

export PROMPT_COMMAND=_set_prompt

[[ $(declare -p PS1 2>/dev/null | cut -c 1-11) == 'declare -x ' ]] ||
  export PS1='\[\033]0;\w\a\]\n\[\033[32m\]\u@\h \[\033[35m\]$MSYSTEM\[\033[0m\] \[\033[33m\]\w\[\033[0m\]\n'"${_ps1_symbol}"' '
unset _ps1_symbol


shopt -q login_shell
