# Bash-Prompt
An informative, simple alternative to the traditional Git-Bash for Windows prompt.
***
## Installation
Copy the contents of `bash.bashrc` and `~.bash_aliases` (create if not yet existing) to your `/Program Files/Git/etc/bash.bashrc` and `~/.bashrc` files. The prompt looks the best in "dracula" theme, set by right-clicking the title bar >> "Options" >> "Theme." Change the terminal to Low/Medium for optimum aesthetic.

## Available Options

### Aliases

Bash-Prompt offers simple, easy-to-remember aliases for:
1. Git
2. Git Flow
3. Virtual Environments
4. Miscellaneous (General Convenience)

Confused? Run `gitaliases`, `venvaliases`, `convenience`, or `symbols` to display more information about the aliases and prompt structure. Feel free to change the alias names of certain git commands.

For example, running `symbols` on an active Git-Bash terminal shows you the prompt structure of:
```bash
   First "[]"          Index status
   Second "[]"         Working tree status
   {}                  Empty repository
   ✗                   No remote
   ≠                   No upstream
   ↑                   Commits ahead
   ↓                   Commits behind
   +                   Added files
   -                   Deleted files
   ~                   Modified files
   ?                   Untracked files
   Ψ                   Unmerged files
   
   Orange indicates index status.
   Grey indicates working tree status.
   White indicates a problem or something you should update.
```



