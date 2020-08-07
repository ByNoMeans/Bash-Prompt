if [ -e ~/pure_bash_prompt ]; then
  if [ -e ~/gitstatus ]; then
    if [ -e /c/Program\ Files/Git/ ]; then
      if [ -e /c/cygwin/etc/bash.bashrc ]; then
        cp -i ~/pure_bash_prompt/gitbash/bash.bashrc '/c/Program Files/Git/etc'
        cp -i ~/pure_bash_prompt/gitbash/minttyrc ~
        cp -i ~/pure_bash_prompt/gitbash/bash_profile ~
        cp -i ~/pure_bash_prompt/git-completion.bash ~
        cp -i ~/pure_bash_prompt/gitbash/.bash_aliases ~
        cp -i ~/pure_bash_prompt/cygwin/bash.bashrc '/c/cygwin/etc'
      else
        echo "Install cygwin before installing pure-bash-prompt, or make sure it is located in /c/cygwin"
      fi
    else 
      echo "Install git before installing pure-bash-prompt, or make sure it is located in /c/Program Files"
    fi
  else 
    echo "Install gitstatus before installing pure-bash-prompt, or make sure it is located in ~"
  fi
else
  echo "Clone the repository before installing pure-bash-prompt, or make sure it is located in ~"
fi
