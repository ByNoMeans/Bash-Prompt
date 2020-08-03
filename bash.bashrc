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
  in_ssh_client="true"
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
#if [[ -n "$(command -v getent)" ]] && id -G | grep -q "$(getent -w group 'S-1-16-12288' | cut -d: -f2)"
#then _ps1_symbol='\[\e[1m\]#\[\e[0m\]'
#else _ps1_symbol='\$'
#fi

#Colors
#https://unix.stackexchange.com/questions/124407/what-color-codes-can-i-use-in-my-ps1-prompt
# Simple: https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux

#Prompt "\something" customizations
#https://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html

export VIRTUAL_ENV_DISABLE_PROMPT=1

setPrompt() {
  function virtualenv-format() {
    venv=""
    VIRT_ENV_TXT=""
    if [ "$VIRTUAL_ENV" != "" ]; then
      VIRT_ENV_TXT=$(basename \""$VIRTUAL_ENV")
    elif [ "$(basename \""$VIRTUAL_ENV"\")" = "__" ]; then
      VIRT_ENV_TXT=[$(basename \`dirname \""$VIRTUAL_ENV"\"\`)]
    fi
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
        [[ $(git stash list) ]] && git_string='\[\033[1;36m\]*'"$git_string"
        # shellcheck disable=SC1083
        upstream=$(git rev-parse --abbrev-ref "$branch"@{upstream} 2>/dev/null | head -n 1)
        if [ "$upstream" ]; then
          git_string+='\[\033[1;36m\] → \[\033[0;35m\]'"${upstream%/*}"'\[\033[1;36m\]/\[\033[0;35m\]'"${upstream##*/}"
          # shellcheck disable=SC2207
          commits=($(git rev-list --left-right --count "$branch"..."$upstream"))
          # shellcheck disable=SC2086
          [ "${commits[0]}" != "0" ] && git_string+='\[\033[0m\] ↑'
          if [ "${commits[1]}" != "0" ]; then
            if [ "${commits[0]}" == "0" ]; then
              git_string+='\[\033[0m\] ↓'
            else
              git_string+='\[\033[0m\]↓'
            fi
          fi
        fi
      else
        git_string="$git_string"'\[\033[0;35m\]'"$(git rev-parse --short HEAD)"
      fi
      #change
      # REMOTE SHIT GOING
      # FUNCTIONING? doesn't look correctly highlighted
      # Double check this and order, and adding spaces so separate
      [[ ! $(git remote) ]] && git_string="$git_string"'\[\033[0m\] ✗'
      declare -a index_array=()
      declare -a working_array=()
      local index=""
      index='\033[38;5;214m\]'
      local working=""
      working='\[\033[0;37m\]'

      while IFS= read -r line; do
        local index_status=""
        index_status="${line::1}"
        # shellcheck disable=SC2076
        # shellcheck disable=SC2199
        if [[ ! " ${index_array[@]} " =~ " ${index_status} " ]] && [ "$index_status" != "0" ]; then
          index_array+=("$index_status")
          case $index_status in
          "A")
            index+='+'
            ;;
          "M")
            index+='~'
            ;;
          "D")
            index+='-'
            ;;
          "U")
            index+='Ψ'
            ;;
          esac
        fi
        [ "$index" != "\033[38;5;214m\]" ] && index=" $index"
        local working_status=""
        working_status="${line:1:1}"
        # shellcheck disable=SC2199
        # shellcheck disable=SC2076
        if [[ ! " ${working_array[@]} " =~ " ${working_status} " ]] && [ "$working_status" != "0" ]; then
          working_array+=("$working_status")
          case $working_status in
          "A")
            working=+='+'
            ;;
          "M")
            working+='~'
            ;;
          "D")
            working+='-'
            ;;
          "U")
            working+='Ψ'
            ;;
          esac
        fi
      done < <(git status -s)
      [ "$(git status --porcelain 2>/dev/null | grep -c "^??")" != "0" ] && working+='\[\033[0m\]?'
      [ "$working" != "\[\033[0;37m\]" ] && working=" $working"
      git_string=" $git_string$index$working"
    fi
  }
  \virtualenv-format
  \git-format
  TITLEPREFIX=""
  PS1='\[\033]0;'"\007\]"'\n\[\033[33m\]\w'
  # fix up
  [ "$in_ssh_client" == "true" ] && PS1+='\[\033[32m\]\uin \[033\[38;5;202m\]\h'
  PS1+="$git_string\n$venv"
  local prompt=""
  prompt="\$(if [ \$? = 0 ]; then echo \[\033[32m\]❯; else echo \[\033[31m\]❯; fi) "
  PS1+="$prompt"'\[\033[0m\]'
}

export PROMPT_COMMAND=setPrompt

#[[ $(declare -p PS1 2>/dev/null | cut -c 1-11) == 'declare -x ' ]] ||
#  export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[35m\]$MSYSTEM\[\e[0m\] \[\e[33m\]\w\[\e[0m\]\n'"${_ps1_symbol}"' '
#unset _ps1_symbol

# Uncomment to use the terminal colours set in DIR_COLORS
# eval "$(dircolors -b /etc/DIR_COLORS)"

# Fixup git-bash in non login env
shopt -q login_shell