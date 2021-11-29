export EDITOR="emacs"
export VISUAL="emacs"

# In interactive shells, this will be double-sourced.
# Avoid double-adding these paths
PREPEND=$HOME/local/bin:$HOME/code/scripts:
export PATH=$PREPEND$(echo "$PATH" | sed -e "s,$PREPEND,,g" )

# Remove strange artifact
export PATH=$(echo "$PATH" | sed -e "s,:v16.0.0,,g" )

export SAGE_PATH=$HOME/code/python:$HOME/mat

# This plays with an ssh-agent systemd-service,
# in .config/systemd/user/ssh-agent.service
# See` https://wiki.archlinux.org/index.php?title=SSH_keys&oldid=398148
# export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Workaround some weird GTK bus error (seen when launching zathura from term)
export NO_AT_BRIDGE=1

# Set Pager
export PAGER="less -R"
export LEDGER_PAGER="less -R"
