eval (/opt/homebrew/bin/brew shellenv)

fish_add_path -p $HOME/.cargo/bin
fish_add_path -p $HOME/bin

if status is-interactive
    # Commands to run in interactive sessions can go here
end
