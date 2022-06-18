
# The following lines were added by compinstall

# zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select
zstyle :compinstall filename '/home/miketvo/.zshrc'


autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt beep
bindkey -v
# End of lines configured by zsh-newuser-install



########################
# Manual customization #
########################

# Keybinds
bindkey "^[[3~"     delete-char
bindkey "^[3;5~"    delete-char
bindkey "\e[H"      beginning-of-line
bindkey "\e[F"      end-of-line

# Prompt theme
autoload -Uz promptinit
promptinit
prompt walters

# Aliases
alias sudo='sudo '
alias cls='clear'
alias ls='ls --color=auto'
alias ll='ls -lA'
alias la='ls -a'
alias lla='ls -la'
alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Autostarts
eval "$(oh-my-posh init zsh --config ~/.oh-my-posh.omp.json)"
