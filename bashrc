# parse "<dir>" as "cd <dir>"
#shopt -s autocd

program_exists() {
    which "$1" 1>/dev/null 2>&1 
}

if program_exists nvim; then
  export EDITOR=nvim
  alias vim=nvim
fi
if program_exists eza; then
  alias ls=eza
fi
if program_exists rg; then
    alias ag=rg
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

ssh-add -l &>/dev/null

export PATH="$HOME/bin:$HOME/.cargo/bin:$HOME/go/bin:$HOME/Idea/bin:$HOME/.local/bin:$PATH"

# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

if [ -f ~/.config/broot/launcher/bash/br ]; then
  source $HOME/.config/broot/launcher/bash/br
fi

eval "$(starship init bash)"

. "$HOME/.cargo/env"
