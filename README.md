# Bash-Prompt
An informative, clean, and simple alternative to the traditional Git-Bash for Windows prompt.

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

Run `bpgit`, `bpvenv`, `bpfast`, or `bpsymbols` to display more information about the aliases and prompt structure. Change the alias names and corresponding commands to your preference.

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

![Git-Bash Prompt](https://github.com/ByNoMeans/bash-prompt/blob/master/Git-Bash%20Prompt.png)


