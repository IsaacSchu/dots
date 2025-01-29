# Autoload and setopts
autoload -U colors && colors
setopt prompt_subst
setopt correctall
setopt extended_glob
set -o vi
bindkey -v '^?' backward-delete-char

# Export
export EDITOR=nvim
export VISUAL=nvim
export PAGER=
export PATH="$HOME/.local/bin:$PATH"

# Herstory
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
HIST_IGNORE_DUPS=true
HIST_APPEND=true
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_EXPIRE_DUPS_FIRST

# Basic Auto complete
autoload -U compinit 
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Git Branch for Prompt
function git_branch_name()
{
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]];
  then
    :
  else
    echo '%F{magenta}-%F{blue}'$branch''
  fi
}

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval $(dbus-launch --sh-syntax)
    export DBUS_SESSION_BUS_ADDRESS
fi

alias ls='ls -hN --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias n='sudo -E nvim'
alias s='sudo'
alias vi='nvim'


# Prompt
PS1='%F{magenta}[%F{cyan}%n%F{blue}@%F{magenta}%m %F{cyan}%~$(git_branch_name)%F{magenta}]%f%F{blue}$ %f'

# Conda Stuff

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!


#__conda_setup="$('~/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "~/anaconda3/etc/profile.d/conda.sh" ]; then
#        . "~/anaconda3/etc/profile.d/conda.sh"
#    else
#        export PATH="~/anaconda3/bin:$PATH"
#    fi
#fi
#unset __conda_setup


# <<< conda initialize <<<


# Zsh Autosuggestions
if [ -f /usr/share/zsh/site-functions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh/site-functions/zsh-autosuggestions.zsh
    bindkey '^[ ' autosuggest-accept  # Automatically accept suggestions with a space
fi

# Zsh Syntax Highlighting
if [ -f /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh
    ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=blue,underline
    ZSH_HIGHLIGHT_STYLES[precommand]=fg=magenta,underline
    ZSH_HIGHLIGHT_STYLES[arg0]=fg=magenta
    ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=#bf285d
    ZSH_HIGHLIGHT_STYLES[path]=fg=None
fi

