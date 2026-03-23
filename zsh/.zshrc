# Autoload,setopts and title
autoload -U colors && colors
setopt prompt_subst
setopt correctall
setopt extended_glob
set -o vi
bindkey -v
bindkey '^?' backward-delete-char
bindkey -M viins 'jk' vi-cmd-mode

#bindkey -M viins 'jj' vi-cmd-mode
precmd() { print -Pn "\e]0;%~\a" }
# Export
export EDITOR=nvim
export TERMINAL=alacritty
export VISUAL=nvim
export PATH="$HOME/.local/bin:$PATH"
export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;31:mi=01;05;37;41:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.7z=38;5;172:*.ace=38;5;172:*.alz=38;5;172:*.apk=38;5;172:*.arc=38;5;172:*.arj=38;5;172:*.bz=38;5;172:*.bz2=38;5;172:*.cab=38;5;172:*.cpio=38;5;172:*.crate=38;5;172:*.deb=38;5;172:*.drpm=38;5;172:*.dwm=38;5;172:*.dz=38;5;172:*.ear=38;5;172:*.egg=38;5;172:*.esd=38;5;172:*.gz=38;5;172:*.jar=38;5;172:*.lha=38;5;172:*.lrz=38;5;172:*.lz=38;5;172:*.lz4=38;5;172:*.lzh=38;5;172:*.lzma=38;5;172:*.lzo=38;5;172:*.pyz=38;5;172:*.rar=38;5;172:*.rpm=38;5;172:*.rz=38;5;172:*.sar=38;5;172:*.swm=38;5;172:*.t7z=38;5;172:*.tar=38;5;172:*.taz=38;5;172:*.tbz=38;5;172:*.tbz2=38;5;172:*.tgz=38;5;172:*.tlz=38;5;172:*.txz=38;5;172:*.tz=38;5;172:*.tzo=38;5;172:*.tzst=38;5;172:*.udeb=38;5;172:*.war=38;5;172:*.whl=38;5;172:*.wim=38;5;172:*.xz=38;5;172:*.z=38;5;172:*.zip=38;5;172:*.zoo=38;5;172:*.zst=38;5;172:*.avif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.cfg=00;32:*.conf=00;32:*.diff=00;32:*.doc=00;32:*.ini=00;32:*.log=00;32:*.patch=00;32:*.pdf=00;32:*.ps=00;32:*.tex=00;32:*.txt=00;32:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:*~=00;90:*#=00;90:*.bak=00;90:*.crdownload=00;90:*.dpkg-dist=00;90:*.dpkg-new=00;90:*.dpkg-old=00;90:*.dpkg-tmp=00;90:*.old=00;90:*.orig=00;90:*.part=00;90:*.rej=00;90:*.rpmnew=00;90:*.rpmorig=00;90:*.rpmsave=00;90:*.swp=00;90:*.tmp=00;90:*.ucf-dist=00;90:*.ucf-new=00;90:*.ucf-old=00;90:"

# Herstory
HISTFILE=$HOME/.cache/zsh/history
HISTSIZE=12500
SAVEHIST=12500
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_REDUCE_BLANKS

# Basic Auto complete
autoload -U compinit 
zstyle ':completion:*' menu select
zmodload zsh/complist
if [[ -n $ZSH_COMPDUMP && (! -f $ZSH_COMPDUMP || $ZSH_COMPDUMP -nt ~/.zcompdump) ]]; then
    compinit
else
    compinit -C  
fi
_comp_options+=(globdots)
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Git Branch for Prompt
git_branch_name() {
  local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  [[ -n $branch ]] && echo "%F{magenta}-%F{blue}$branch"
}

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -hNA --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias n='sudo -E nvim'
alias s='sudo'
alias vi='nvim'
alias cls='clear && ls'

# Truncates filepath to first char for directories 3 levels higher
function custom_prompt_dir() {
    local dir="${PWD/#$HOME/~}"               # Replace $HOME with ~
    local -a dirs=("${(s:/:)dir}")            # Split into array using '/'
    local length=${#dirs[@]}

    # Truncate each component except the last two to their first letter
    if [ ${length} -gt 4 ]; then
        for ((i=1; i <= length - 3; i++)); do
            if [[ ${dirs[i]} == .* ]]; then
                dirs[$i]=${dirs[$i]:0:2}
            else
            dirs[$i]=${dirs[$i]:0:1}
            fi
        done
    fi 
    echo "${(j:/:)dirs}"                      # Join components with '/'
}

PS1='%F{magenta}[%F{cyan}%n%F{blue}@%F{magenta}%m %F{cyan}$(custom_prompt_dir)$(git_branch_name)%F{magenta}]%f%F{blue}$ %f'

# Conda Stuff

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#Jj__conda_setup="$('/home/lain/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#Jelse
#    if [ -f "/home/lain/miniconda3/etc/profile.d/conda.sh" ]; then
#        . "/home/lain/miniconda3/etc/profile.d/conda.sh"
#    else
#        export PATH="/home/lain/miniconda3/bin:$PATH"
#    fi
#Jfi
#unset __conda_setup
# <<< conda initialize <<<

# Zsh Substring Search
if [ -f /usr/share/zsh/site-functions/_zsh-history-substring-search ]; then
    source /usr/share/zsh/site-functions/_zsh-history-substring-search
    bindkey '^[[A' history-substring-search-up 
    bindkey '^[[B' history-substring-search-down
    bindkey -M vicmd 'k' history-substring-search-up
    bindkey -M vicmd 'j' history-substring-search-down
fi

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

eval "$(zoxide init zsh)"
