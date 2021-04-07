git clone https://github.com/barrettruth/pure-zsh-prompt.git ~/

mv ~/.zshrc ~/.zshrc.pre-pure-zsh-prompt 2>/dev/null
mv ~/pure-zsh-prompt/.zshrc ~/

mv ~/.zprofile ~/.zprofile.pre-pure-zsh-prompt 2>/dev/null
mv ~/pure-zsh-prompt/.zprofile ~/

mv ~/.zsh_aliases ~/.zsh_aliases.pre-pure-zsh-prompt 2>/dev/null
mv ~/pure-zsh-prompt/.zsh_aliases ~/

mv ~/_git ~/_git.pre-pure-zsh-prompt 2>/dev/null
mv ~/pure-zsh-prompt/_git ~/

mv ~/git-completion.bash ~/git-completion.bash.pre-pure-zsh-prompt 2>/dev/null
mv ~/pure-zsh-prompt/git-completion.bash ~/
