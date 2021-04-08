export EDITOR="emacs"
export VISUAL="emacs"

PATH=$HOME/local/bin:$HOME/code/scripts:$PATH

export SAGE_PATH=$HOME/code/python:$HOME/mat

# This plays with an ssh-agent systemd-service,
# in .config/systemd/user/ssh-agent.service
# See` https://wiki.archlinux.org/index.php?title=SSH_keys&oldid=398148
# export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Workaround some weird GTK bus error (seen when launching zathura from term)
export NO_AT_BRIDGE=1

# Set Pager
export PAGER="most"
export LEDGER_PAGER="most"
