# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/miketvo/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Set default editor
export EDITOR=nvim

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac
force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# Colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# QoL aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias la='ls -CFap'
alias ll='ls -lhap'
alias dr='exa --color=auto --icons=auto'
alias dra='exa -aF --group-directories-first --color=auto --icons=auto'
alias drl='exa -alF --group-directories-first --color=auto --icons=auto'
alias cls='clear'
alias nv='nvim'

# Safety aliases
alias chmod='chmod --preserve-root'
alias chown='chown --preserve-root'
alias chgrp='chgrp --preserve-root'
alias sudo='sudo '

# Load Node Version Manager (nvm)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Load pyenv and pyenv-virtualenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"
eval "$(pyenv virtualenv-init -)"

# Broot integration
source /home/miketvo/.config/broot/launcher/bash/br

# Enable Oh-My-Posh
eval "$(oh-my-posh init zsh --config ~/.oh-my-posh.omp.json)"

# fastfetch greeting
fastfetch --logo arch2
cd $HOME
