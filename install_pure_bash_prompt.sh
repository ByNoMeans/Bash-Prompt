if [ -e ~/pure_bash_prompt ]; then
  if [ -e ~/gitstatus ]; then
    if [ -e /c/Program\ Files/Git/ ]; then
      # Copy bash.bashrc or bash-documented.bashrc to /Git/etc/. If you prefer documentation and chose the latter, make sure to rename it to bash.bashrc
      cp -i ~/.pure_bash_prompt/bash.bashrc '/c/Program Files/Git/etc'

      # Copy .minttyrc, .bash_profile, .git-completion.bash and .bash_aliases to ~
      cp -i ~/.pure_bash_prompt/.minttyrc ~
      cp -i ~/.pure_bash_prompt/.bash_profile ~
      cp -i ~/.pure_bash_prompt/.git-completion.bash ~
      cp -i ~/.pure_bash_prompt/.bash_aliases ~
      echo "Install git before installing pure-bash-prompt"
    fi
  else 
    echo "Install gitstatus before installing pure-bash-prompt"
  fi
else
  echo "Clone the repository before installing pure-bash-prompt"
fi
