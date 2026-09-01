# Supress macos related logging
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# BREW
eval "$(/opt/homebrew/bin/brew shellenv)"
# FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
FPATH="/opt/homebrew/share/zsh/site-functions:$FPATH"

# Own methods
#source ~/dotfiles/zsh_functions/.ff_zsh # ctrl + f
source "$ZDOTDIR/zsh_functions/aliases"
source "$ZDOTDIR/zsh_functions/prompt_function"
source "$ZDOTDIR/zsh_functions/mcdir" # creates and enters new directory
source "$ZDOTDIR/zsh_functions/edit_line" # ctrl + e edits command line in vim

#Plugins
source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"
source "$ZDOTDIR/plugins/zsh-completions/zsh-completions.plugin.zsh"
#source $ZDOTDIR~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
#
# Tab completion
autoload -Uz compinit && compinit

# Enable colors
autoload -U colors && colors
setopt PROMPT_SUBST

# Print a tilde-shortened PWD, capped at 25 chars, with "..." at the start if trimmed
short_pwd() {
  local max=50
  local marker="..."
  local p="${PWD/#$HOME/~}"   # turn $HOME prefix into ~
  if (( ${#p} > max )); then
    print -r -- "${marker}${p: -$((max - ${#marker}))}"
  else
    print -r -- "$p"
  fi
}

# Use the trimmed path in your prompt
PROMPT='%{$fg_bold[green]%}$(short_pwd)%{$reset_color%} $(git_prompt_info) %{$fg[magenta]%}➜%{$reset_color%} '


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<



