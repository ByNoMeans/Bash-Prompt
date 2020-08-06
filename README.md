# Bash-Prompt

An informative, non-overwhelming, clean, and simple alternative to the traditional Git-Bash for Windows prompt.

## Installation

No code was explicitly taken from any of the following repos, but their prompts provided heavy inspiration to `pure-bash-prompt`'s themeing, symbols, and general format.

1. [Posh-Git](https://github.com/dahlbyk/posh-git/)
2. [Pure](https://github.com/sindresorhus/pure)
3. 

## Installation
Copy the contents of `bash.bashrc` and `~.bash_aliases` (create if not yet existing) to your `/Program Files/Git/etc/bash.bashrc` and `~/.bash_aliases` files. The prompt looks the best in "dracula" theme, set by "Terminal Title Bar" >> "Options" >> "Theme." Change the terminal transparency to Low/Medium for optimum aesthetic in this tab as well.

## Aliases

Bash-Prompt offers simple, easy-to-remember aliases for:
1. Git
2. Git Flow
3. Virtual Environments
4. Miscellaneous (general convenience)

## Tips
 
### Colors

View [here](https://unix.stackexchange.com/questions/124407/what-color-codes-can-i-use-in-my-ps1-prompt) to get a complete description and explanation of ANSI colors, along with a complete graphic depicting all colors and their corresponding ANSI codes.

View [here](https://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html) to see all backslash-escaped characters. For example, `\W` provides the absolute current working directory, and `\A` provides the time (to the minute) expressed in military time.

Run `pgit`, `pvenv`, `phelp`, or `psymbols` to display more information about the aliases and prompt structure. Change the alias names and corresponding commands to your preference.

For example, running `psypmbols` on an active Git-Bash terminal shows you the prompt structure of:
```
Prompt Symbols:

   ≠                   No upstream
   ✗                   No remote
   ↑                   Commits ahead
   ↓                   Commits behind
   +                   Added
   -                   Deleted
   ~                   Modified
   %                   Untracked
   Ψ                   Unmerged

   Yellow: index status.
   Grey: working tree status.
   Blue indicates a problem or something you should update.
```

## Example

An example session would look as follows. 

![GitBash.PNG](https://github.com/ByNoMeans/pure-bash-prompt/blob/master/GitBash.PNG)


