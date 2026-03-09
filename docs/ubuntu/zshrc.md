# .zshrc

```bash
# Add colors to bash
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Allow zsh to read variables dynamically
setopt PROMPT_SUBST
# Stop Miniconda from breaking the prompt format
export CONDA_CHANGEPS1=false
# The fixed Two-Liner with Conda integrated on the inside
PROMPT="%F{cyan}╭─%F{yellow}\${CONDA_DEFAULT_ENV:+(\$CONDA_DEFAULT_ENV) }%f%F{cyan}%n %F{blue}%~%f
%F{cyan}╰─%f %# "
```