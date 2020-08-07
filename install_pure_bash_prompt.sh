if [ -e ~/pure_bash_prompt ]; then
  if [ -e ~/gitstatus ]; then
    if [ -e /c/Program\ Files/Git/ ]; then
      cp -i ~/pure_bash_prompt/bash.bashrc '/c/Program Files/Git/etc'
      cp -i ~/pure_bash_prompt/minttyrc ~
      cp -i ~/pure_bash_prompt/bash_profile ~
      cp -i ~/pure_bash_prompt/git-completion.bash ~
      cp -i ~/pure_bash_prompt/bash_aliases ~
      echo "Install git before installing pure-bash-prompt"
    else 
      echo "Install git before installing pure-bash-prompt"
    fi
  else 
    echo "Install gitstatus before installing pure-bash-prompt"
  fi
else
  echo "Clone the repository before installing pure-bash-prompt"
fi
