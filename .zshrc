# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must  above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#
# /etc/zshrc is sourced in interactive shells.  It
# should contain commands to set up aliases, functions,
# options, key bindings, etc.
#

umask 022

setopt magic_equal_subst
setopt hist_find_no_dups
setopt hist_ignore_space
setopt inc_append_history
unsetopt promptcr
limit coredumpsize 0

# Set up aliases, this may confuse gurus but well after all gurus now
# how to remove alias.
alias mv='nocorrect mv -i'       # no spelling correction on mv
alias cp='nocorrect cp -i'       # no spelling correction on cp
alias rm='nocorrect rm'       # no spelling correction on rm
alias mkdir='nocorrect mkdir' # no spelling correction on mkdir
alias sizes='du -hs *'

alias ls="exa"
alias la="exa -a"
alias ll="exa -lagh"
lst () {
  # Print the most recently modified files in a directory
  # Usage: lst [-n lines] [folder]
  # Defaults to the current folder and printing 10 lines (in terminal mode).
  # If run in terminal mode, print the files in color and long form.
  # If run in pipe mode, print the full path to the file and default to 1 file.
  if [ -t 1 ]; then
    lines=10
  else
    lines=1
  fi
  folder=""
  while (( $# )); do
    if [[ $1 == '-n' ]]; then
      lines=$2
      shift
    else
      if [[ -z $folder ]]; then
        folder=$1
      else
        echo "Too many arguments: $1"
        return 1
      fi
    fi
    shift
  done
if [[ -z $folder ]]; then
  folder="."
  fi
  if [ -t 1 ]; then
    exa -l --reverse --sort=new --color=always "$folder" | head -n $lines
  else
    exa --reverse --sort=new "$folder" | awk -v folder="$folder" '{print folder "/" $0}' | head -n $lines
  fi
}

export LST=$(gls -t | head -n 1)
alias lsdir="exa -T --level=2"
alias ls-tree="exa --tree -I node_modules"
alias ed="emacsclient -c" #shorthand. And I don't intend to use ed anyway
alias top="htop"
alias df="gdf -h"
alias du="dust"

# alias find="fd"

# GNU aliases of BSD ones (on Mac OS X)
PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"

# Shell functions
setenv() { export $1=$2 }  # csh compatibility

# Set prompt
source /opt/homebrew/Cellar/powerlevel10k/1.19.0/share/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# PROMPTCOL="`cat ~/.promptcol 2>/dev/null`"
# PROMPT=$'%3~ :%(?.%).()%{\e[0m%} '
#PROMPT=$'%{\e['${PROMPTCOL:-0}$'m%}%n@%m %3~ %(!.#.$)%{\e[0m%} '
#PROMPT="[%n@%M %~]$ "    # default prompt
#PROMPT='\[\033]0;\w\007\033[36m\]\u@\h \[\033[33m\w\033[0m\]
#$ '
#PROMPT=$'%{\e[36m%}%n@%m %{\e[33m%}%~%{\e[0m%}
#$ '
#RPROMPT=' %~'     # prompt for right side of screen

# Some environment variables
#path=($path $HOME/bin)
export HISTFILE=${HOME}/.bash_history
export HISTSIZE=1000
export SAVEHIST=1000
export USER=$USERNAME
export HOSTNAME=$HOST

export LESS="-cM"

bindkey -e               # emacs key bindings

# Get keys working
bindkey "^[[2~" yank
bindkey "^[[3~" delete-char
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history
# for rxvt
bindkey "^[[7~" beginning-of-line
bindkey "^[[8~" end-of-line
# CTRL+(left/right)
bindkey "^[Od" backward-word
bindkey "^[Oc" forward-word  
# for gnome-terminal
bindkey "^[OH" beginning-of-line
bindkey "^[OF" end-of-line
# for konsole
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# Color completion.
eval $(gdircolors)
export ZLS_COLORS=$LS_COLORS
zmodload -ui complist

# Completion functions
_compdir=/usr/share/zsh/$ZSH_VERSION/functions/Core
[[ -z $fpath[(r)$_compdir] ]] && fpath=($fpath $_compdir)

autoload -Uz compinit
compinit -ui -d

# fzf-tab
# TODO: Disabled on new Mac due to some issue where completions would
# completely break
# source ~/local/fzf-tab/fzf-tab.plugin.zsh 
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'


chpwd() {
	[[ -t 1 ]] || return
	case $TERM in
		sun-cmd) print -Pn "\e]l%~\e\\"
		;;
		*xterm*|rxvt|screen|(dt|k|E)term) print -Pn "\e]2;%n@%m %~\a"
        	;;
	esac
}

chpwd

###### Some others options you may want to activate

## If you really want the scripts decomment this, but this may slower
## the login shell.
#  for i in /etc/profile.d/*.sh
#  do
#    source $i
#  done

## General alias
  alias -g L="|less"
#  alias -g H="|head"
#  alias -g T="|tail"
  alias -g G="|grep"
#  alias -g N="&>/dev/null&"
#  alias -g O="2>&1"

## Bindkey you may think it's usefull 
#  bindkey ' ' magic-space  # also do history expansino on space
#  bindkey -s "^xs" '\C-e"\C-asu -c "'
#  bindkey -s "^xd" "$(date '+-%d_%b')"
#  bindkey -s "^xf" "$(date '+-%D'|sed 's|/||g')"
#  bindkey -s "^xp" "\$(pwd\)/"
#  bindkey -s "^xw" "\C-a \$(which \C-e\)\C-a"



###### MINE EGNE TILFOJELSER ######

alias untar="tar -xf"
alias bc="bc -l"
# alias o="xdg-open"
alias o="open"
alias git-ls="git ls-tree --full-tree -r HEAD"


#eval "$(fasd --init auto)"
alias s='. sage_shortcuts'
alias j="fasd_cd -d"
alias jo="f -e xdg-open"
alias lj="fasd -d -e 'ls --color=auto -F'"

# Allow Emacs to track zsh
if [ -n "$INSIDE_EMACS" ]; then
  chpwd() { print -P "\033AnSiTc %d" }
  print -P "\033AnSiTu %n"
  print -P "\033AnSiTc %d"
fi


if [[ "$TERM" == "dumb" ]]
then
  unsetopt zle
  unsetopt prompt_cr
  unsetopt prompt_subst
  unfunction precmd
  unfunction preexec
  PS1='$ '
fi

if [ -e $HOME/github ]; then
    source $HOME/github/.openai_key
    source $HOME/github/.github_access_token
fi

# NVM_NEWEST=$(ls ~/.nvm/versions/node/ | sort | tail -1)
# PATH=$PATH:$NVM_NEWEST
load_nvm() {
    export NVM_DIR="$HOME/.nvm"
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh" --no-use # This loads nvm
    # [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
    nvm use node 18 > /dev/null
}

function sgit() {
    say -v trinoids git $@
    git "$@"
}

# Copilot CLI
alias '??'='gh copilot suggest -t shell'
alias 'git?'='gh copilot suggest -t git'
alias 'explain'='gh copilot explain'

#eval "$(github-copilot-cli alias -- "$0")"

# This has already been sourced as .zshenv, but other things are clobbering e.g. $PATH, so we resource it now
source ~/.zshenv

if [ -n "$CONDA" ]; then
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
fi
export PATH="/usr/local/opt/llvm/bin:$PATH"

# opam configuration
[[ ! -r /Users/johanrosenkilde/.opam/opam-init/init.zsh ]] || source /Users/johanrosenkilde/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
