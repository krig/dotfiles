eval (/opt/homebrew/bin/brew shellenv)

fish_add_path -p /opt/homebrew/bin
fish_add_path -p $HOME/.cargo/bin
fish_add_path -p $HOME/bin

set -gx LANG en_US.UTF-8
set -gx QMK_HOME $HOME/src/qmk_firmware
set -gx EDITOR nvim
set -gx BAT_THEME base16

if status is-interactive
    function k --wraps=kubectl --description 'alias k kubectl'
      kubectl $argv
    end

    function shu --wraps=ssh --description 'ssh unknown'
      ssh -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" $argv
    end

    function t --wraps=tig --description 'alias t tig'
      tig $argv
    end

    function g --wraps=git --description 'alias g gig'
      git $argv
    end

    function vim --wraps=nvim --description 'alias vim nvim'
      nvim $argv
    end

    function e --wraps=nvim --description 'alias e nvim'
      nvim $argv
    end

    function ls --wraps=lsd --description 'alias ls lsd'
      lsd $argv
    end

    function ll --wraps=lsd --description 'alias ll lsd -l'
      lsd -l $argv
    end

    function la --wraps=lsd --description 'alias la lsd -l'
      lsd -a $argv
    end
end
