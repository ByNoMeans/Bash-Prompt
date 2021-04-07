# pure-zsh-prompt

An informative, non-overwhelming, clean, easy-to-change and quick alternative to many overwhelming ZSH prompts.

## Installation

1. Backup your files
2. Clone the repo to your home directory:
```
git clone --depth=1 https://github.com/ByNoMeans/pure-zsh-prompt.git ~/
```
3. Drag and drop whichever files you like to your home directory
4. `rm -rf ~/pure-zsh-prompt`

## Features

1. Satisfying color scheme
2. Displaying informative yet minimal information of git repository (including upstream, current branch, etc)
3. Virtual Environment info
4. Current Node Version if in directory with such files

> Note: more features are always in the works!

## Aliases

pure-zsh-prompt offers simple, easy-to-remember aliases for:

1. Git
2. Virtual Environments
3. General Convenience (quick-run cpp files, quick-sourcing, barebones react app, etc.)

all of which are stored in the `.aliases` file.

## Configuration

The prompt is mainly determined by the `zshrc` file alone, separating the prompt into functions that concatenate different things to the prompt. Change any colors or formatting you want in this short < 100 line file.
