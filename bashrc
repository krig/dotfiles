# parse "<dir>" as "cd <dir>"
#shopt -s autocd

program_exists() {
    which $1 2>&1 1>/dev/null
}

if program_exists nvim; then
  export EDITOR=nvim
  alias vim=nvim
fi
if program_exists exa; then
  alias ls=exa
fi
if program_exists rg; then
    alias ag=rg
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

ssh-add -l &>/dev/null
if [ "$?" == 2 ]; then
  test -r ~/.gnome-keyring && \
    source ~/.gnome-keyring && \
    export DBUS_SESSION_BUS_ADDRESS GNOME_KEYRING_CONTROL SSH_AUTH_SOCK GPG_AGENT_INFO GNOME_KEYRING_PID

  ssh-add -l &>/dev/null
  if [ "$?" == 2 ]; then
    (umask 066; echo `dbus-launch --sh-syntax` > ~/.gnome-keyring; gnome-keyring-daemon >> ~/.gnome-keyring)
    source ~/.gnome-keyring && \
    export DBUS_SESSION_BUS_ADDRESS GNOME_KEYRING_CONTROL SSH_AUTH_SOCK GPG_AGENT_INFO GNOME_KEYRING_PID
  fi
fi

export PATH="$HOME/bin:$HOME/.cargo/bin:$HOME/go/bin:$HOME/Idea/bin:$HOME/.local/bin:$PATH"

source /usr/share/bash-completion/completions/git

# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

eval "$(starship init bash)"

source /Users/krig/.config/broot/launcher/bash/br

source /Users/krigro/.config/broot/launcher/bash/br
