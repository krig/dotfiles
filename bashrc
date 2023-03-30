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

if [[ -f ~/.fzf.bash ]]; then
  # shellcheck source=/dev/null
  source $HOME/.fzf.bash
fi

ssh-add -l &>/dev/null

export PATH="$HOME/bin:$HOME/.cargo/bin:$HOME/go/bin:$HOME/Idea/bin:$HOME/.local/bin:$PATH"

if [[ -f /usr/share/bash-completion/completions/git ]]; then
  # shellcheck source=/dev/null
  source /usr/share/bash-completion/completions/git
fi

# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

if [[ -d $HOME/.asdf ]]; then
  # shellcheck source=/dev/null
  . $HOME/.asdf/asdf.sh
  # shellcheck source=/dev/null
  . $HOME/.asdf/completions/asdf.bash
fi

if program_exists starship; then
  eval "$(starship init bash)"
fi

if [[ -f $HOME/.config/broot/launcher/bash/br ]]; then
  # shellcheck source=/dev/null
  source $HOME/.config/broot/launcher/bash/br
fi

