# Created by newuser for 4.3.10
# Lines configured by zsh-newuser-install
fpath=(~/.zsh/Completion $fpath)
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
setopt histignoredups histfindnodups sharehistory autocd extendedglob notify
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/yeban/.zshrc'

# intialize zsh's autocompletion
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select

autoload -Uz promptinit
promptinit
prompt adam2
# End of lines added by compinstall

#PS1="%~$ "

#export MOZ_NO_REMOTE=1

alias df='df -h'
alias du='du -hs'

alias la='ls -aG --color'
alias ll='ls -lhG --color'
alias ls='ls -G --color'
alias l='ls -G --color'

alias info='info --vi-keys'

alias pi='sudo aptitude install'
alias pr='sudo aptitude remove'
alias pp='sudo aptitude purge'
alias pud='sudo aptitude update'
alias pug='sudo aptitude safe-upgrade'
alias pufg='sudo aptitude full-upgrade'
alias pse='aptitude search'
alias psh='aptitude show'

alias halt='sudo shutdown -h now'
alias reboot='sudo reboot'

alias e='gvim --remote-tab-silent'
s() { find . -iname "*$@*" }

alias sshr="ssh -p $srp $sr"

alias iv="gpicview"
alias entertain='mplayer "$(find "." -type f -regextype posix-egrep -regex ".*\.(avi|mkv|flv|mpg|mpeg)" | shuf -n1)"'

export PKG_CONFIG_PATH=/home/yeban/opt/lib/pkgconfig/:${PKG_CONFIG_PATH}

export PYTHONSTARTUP=$HOME/.pythonrc
export RSENSE_HOME=/home/yeban/opt/rsense-0.3
export PATH=$PATH:/$HOME/opt/ncbi-blast/bin

export _JAVA_AWT_WM_NONREPARENTING=1

case $TERM in
    xterm|rxvt|rxvt-unicode)
        precmd() {
            # notify the window manager on some activity
            echo -ne '\a'

            print -Pn "\e]2;%d\a"
        }
        preexec () {
            local command=${(V)1//\%\%\%}
            command=$(print -Pn "%40>...>$command" | tr -d "\n")
            print -Pn "\e]2;$command\a"
        }
        ;;
esac

# ---[ Simple calculator ]---------------------------------------------
function calc () {
    awk "BEGIN { print $@ }"
}

alias rand='tr -c "[:digit:]" " " < /dev/urandom | dd cbs=$COLUMNS conv=unblock | GREP_COLOR="1;32" grep --color "[^ ]"'

if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then source "$HOME/.rvm/scripts/rvm" ; fi
