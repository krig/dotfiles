#!/bin/bash

PS3='Please enter your choice: '
options=("Install homebrew" "Install deps" "Install rustup" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Install homebrew")
          /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
          ;;
        "Install deps")
          brew install git fd tig neovim zsh just uv ghostty starship lsd
          echo "As root: echo '/opt/homebrew/bin/zsh' >> /etc/shells"
          echo "Then: chsh -s /opt/homebrew/bin/zsh"
          echo "Then: just link"
          ;;
        "Install rustup")
          curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
          ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
