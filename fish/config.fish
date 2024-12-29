eval (/opt/homebrew/bin/brew shellenv)

fish_add_path -p /opt/homebrew/bin
fish_add_path -p $HOME/.cargo/bin
fish_add_path -p $HOME/bin

set -gx LANG en_US.UTF-8
set -gx QMK_HOME $HOME/src/qmk_firmware
set -gx EDITOR nvim
set -gx BAT_THEME base16

if status is-interactive
    # Commands to run in interactive sessions can go here
end
