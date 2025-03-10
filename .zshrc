#
# ~/.zshrc
#
# Add these lines to the top of your .zshrc file
# Run compinit before compdef is used.
autoload -Uz compinit
compinit

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# PS1='[\u@\h \W]\$ '

# Set to superior editing mode
bindkey -v

# keybinds
function clear-screen() { clear }
zle -N clear-screen
bindkey '^L' clear-screen

# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~

export VISUAL=nvim
export EDITOR=nvim

# config
export BROWSER="firefox"

# directories
export REPOS="$HOME/Repos"
export GITUSER="bshea5"
export GHREPOS="$REPOS/github.com/$GITUSER"
export DOTFILES="$GHREPOS/dotfiles"
export LAB="$GHREPOS/lab"
export SCRIPTS="$DOTFILES/scripts"

# Go related. In general all executables and scripts go in .local/bin
export GOBIN="$HOME/.local/bin"
export GOPRIVATE="github.com/$GITUSER/*,gitlab.com/$GITUSER/*"
# export GOPATH="$HOME/.local/share/go"
export GOPATH="$HOME/go/"

# dotnet
export DOTNET_ROOT="/opt/homebrew/opt/dotnet/libexec"

# ~~~~~~~~~~~~~~~ Path configuration ~~~~~~~~~~~~~~~~~~~~~~~~
# function from Arch Wiki, to prevent adding directories multiple times

# set_path(){
#
#     # Check if user id is 1000 or higher
#     [ "$(id -u)" -ge 1000 ] || return
#
#     for i in "$@";
#     do
#         # Check if the directory exists
#         [ -d "$i" ] || continue
#
#         # Check if it is not already in your $PATH.
#         echo "$PATH" | grep -Eq "(^|:)$i(:|$)" && continue
#
#         # Then append it to $PATH and export it
#         export PATH="${PATH}:$i"
#     done
# }
#
# set_path "$HOME"/git/lab/bash "$HOME"/.local/bin

# https://unix.stackexchange.com/questions/26047/how-to-correctly-add-a-path-to-path
# PATH="${PATH:+${PATH}:}~/opt/bin"   # appending
# PATH="~/opt/bin${PATH:+:${PATH}}"   # prepending

# Commands also provided by macOS and the commands dir, dircolors, vdir have been installed with the prefix "g".
# If you need to use these commands with their normal names, you can add a "gnubin" directory to your PATH with:
#  PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

PATH="${PATH:+${PATH}:}"$SCRIPTS":/opt/homebrew/opt/dotnet@6/bin:/opt/homebrew/opt/dotnet/bin:"$HOME"/.local/bin:"$HOME"/.dotnet/tools" # appending

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~

export HISTFILE=~/.histfile
export HISTSIZE=25000
export SAVEHIST=25000
export HISTCONTROL=ignorespace

# ~~~~~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~~~~~~~~~~~


# ~~~~~~~~~~~~~~~ SSH ~~~~~~~~~~~~~~~~~~~~~~~~
# SSH Script from arch wiki

if ! pgrep -u "$USER" ssh-agent >/dev/null; then
    ssh-agent >"$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

# Only run on Ubuntu

if [[ $(grep -E "^(ID|NAME)=" /etc/os-release | grep -q "ubuntu")$? == 0 ]]; then
    eval "$(ssh-agent -s)" >/dev/null
fi

# adding keys was buggy, add them outside of the script for now
# ssh-add -q ~/.ssh/bshea5
#{
ssh-add -q ~/.ssh/id_ed25519
#} &>/dev/null


# Moved to starship 20-03-2024 for all my prompt needs.
eval "$(starship init zsh)"

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~

# alias v=nvim
# alias vim=nvim

# cd
alias ..="cd .."
alias scripts='cd $SCRIPTS'
alias lab='cd $LAB'
alias alab='cd $GHREPOS/azure-lab'
alias dot='cd $GHREPOS/dotfiles'
alias repos='cd $REPOS'
alias cdgo='cd $GHREPOS/go/'
alias rwdot='cd $REPOS/github.com/rwxrob/dot'
alias c="clear"

# ls
alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -lathr'

# finds all files recursively and sorts by last modification, ignore hidden files
alias last='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'

# python
alias python=python3
alias pip=pip3


# fun
alias fishies=asciiquarium

# kubectl
alias k='kubectl'
source <(kubectl completion zsh)
# complete -o default -F __start_kubectl k

# sourcing
# source "$HOME/.privaterc"

if [[ "$OSTYPE" == "darwin"* ]]; then
    source "$HOME/.fzf.zsh"
    # echo "I'm on Mac!"

    # brew bash completion
    [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
else
    #	source /usr/share/fzf/key-bindings.bash
    #	source /usr/share/fzf/completion.bash
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi


# Only needed for npm install on WSL
#export NVM_DIR="$HOME/.config/nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

. "$HOME/.cargo/env"

. "$HOME/.local/bin/env"
