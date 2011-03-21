fpath=(~/.zsh/Completion $fpath)

HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000

# zsh options; man zshoptions
setopt sharehistory
setopt histignoredups
setopt histfindnodups
setopt histignorespace

setopt extendedglob
setopt notify
setopt correct
setopt interactivecomments
setopt multios

setopt autocd
setopt autopushd
setopt pushdignoredups
setopt pushdsilent

setopt autolist
setopt recexact
setopt completeinword

unsetopt flowcontrol
unsetopt beep

bindkey -e

# configure zsh's autocompletion system; man zshcompsys
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*' matcher-list '+' '+m:{[:lower:]}={[:upper:]}' '+l:|=* r:|=*' '+r:|[._-]=** r:|=**'
zstyle ':completion:*:match:*' original only
zstyle -e ':completion:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*' list-suffixes true

zstyle ':completion:*' group-name ''
zstyle ':completion:*' format '%B%d:%b'
zstyle ':completion:*' verbose true
zstyle ':completion:*' file-sort access
zstyle ':completion:*' list-colors no=00 fi=00 di=01\;34 pi=33 so=01\;35 bd=00\;35 cd=00\;34 or=00\;41 mi=00\;45 ex=01\;32
zstyle ':completion:*' menu 'select=0'
zstyle ':completion:*' list-prompt ''
zstyle ':completion:*' select-prompt ''

zstyle ':completion:*' insert-tab false
zstyle ':completion:*' prompt ''\''%e'\'''
zstyle ':completion:*:manuals' separate-sections true

autoload -Uz compinit
compinit

autoload -Uz promptinit
promptinit
prompt adam2

autoload -U zsh-mime-setup
zsh-mime-setup

#PS1="%~$ "
#export MOZ_NO_REMOTE=1

### Aliases
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

alias sshr="ssh -p $srp $sr"

alias entertain='mplayer "$(find "." -type f -regextype posix-egrep -regex ".*\.(avi|mkv|flv|mpg|mpeg|mp4|wmv|3gp|mov|divx)" | shuf -n1)"'
alias rand='tr -c "[:digit:]" " " < /dev/urandom | dd cbs=$COLUMNS conv=unblock | GREP_COLOR="1;32" grep --color "[^ ]"'

### Exports
export PKG_CONFIG_PATH=/home/yeban/opt/lib/pkgconfig/:${PKG_CONFIG_PATH}

export PYTHONSTARTUP=$HOME/.pythonrc
export RSENSE_HOME=/home/yeban/opt/rsense-0.3
export PATH=$PATH:/$HOME/opt/ncbi-blast/bin

export _JAVA_AWT_WM_NONREPARENTING=1

s() { find . -iname "*$@*" }

precmd() {
    # reset LD_PRELOAD that might have been set in preexec()
    export LD_PRELOAD=''

    # send a visual bell to awesome
    echo -ne '\a'

    # set cwd in terminals
    case $TERM in
        xterm|rxvt|rxvt-unicode|screen)
            print -Pn "\e]2;%d\a"
            ;;
    esac

    # for autojump
    z --add "$(pwd -P)"
}

preexec () {
    local command=${(V)1//\%\%\%}
    local first=${command%% *}

    # set terminal's title to the currently executing command
    case $TERM in
        xterm|rxvt|rxvt-unicode|screen)
            command=$(print -Pn "%40>...>$command" | tr -d "\n")
            print -Pn "\e]2;$command\a"
            ;;
    esac

    # automatically use proxychains for git, and ssh
    case $first in
        git|ssh)
            export LD_PRELOAD=libproxychains.so.3
            ;;
    esac
}

# Set default working directory of tmux to the given directory; use the current
# working directory if none given.
#
# TODO: this does not honour .rvmrc
tcd(){
    [[ -n "$1" ]] && dir="$1" || dir="${PWD}"
    if [[ -d "$dir" ]]; then
        tmux "set-option" "default-path" "${dir}"
        return 0
    else
        echo "tcd: no such directory: ${dir}"
        return 1
    fi
}

# Load RVM; http://rvm.beginrescueend.com/
if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then source "$HOME/.rvm/scripts/rvm" ; fi

# Auto jump; https://github.com/sjl/z-zsh
. $HOME/.zsh/z.sh
