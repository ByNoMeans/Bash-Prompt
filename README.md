# pure-zsh-prompt

An informative, non-overwhelming, clean, easy-to-change and quick alternative to many ZSH prompts.

![pure-zsh image](https://github.com/barrettruth/pure-zsh-prompt/blob/master/pure-zsh-graphic.png)

## Installation

1. Backup your files (installation will do if you don't)
2. Clone the repo to your home directory:
```
git clone --depth=1 https://github.com/barrettruth/pure-zsh-prompt.git ~/
```
3. Run the installation script (will delete the cloned directory for you)
```
sh .~/pure-zsh-prompt/pure-zsh-prompt-setup.sh
```

## Features

1. Satisfying color scheme
2. Displaying informative yet minimal information of git repository (including upstream, current branch, etc)
3. Virtual Environment info
4. Current Language Versions (node, python, java so far)

## Aliases

pure-zsh-prompt offers simple, easy-to-remember aliases for:

1. Git
2. Virtual Environments
3. General Convenience (better git, docker, and pyvenv commands, barebones react app etc.)

all of which are stored in the `.zsh_aliases` file.

## Configuration

The prompt is mainly determined by the `.zshrc` file alone, separating the prompt into functions that concatenate different things to the prompt. Extremely easy to read, you can customize this however you want immediately.
