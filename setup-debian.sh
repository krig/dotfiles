#!/bin/bash

PS3='Please enter your choice: '
options=("Install uv" "Install deps" "Install rustup" "Quit")
select opt in "${options[@]}"
do
    case $opt in
	"Install uv")
	  /bin/bash -c "$(curl -LsSf https://astral.sh/uv/install.sh | sh)"
	  ;;
        "Install deps")
          sudo apt install \
		  git fd-find tig neovim \
		  zsh just starship lsd \
		  build-essential libsqlite3-dev fzf \
		  ripgrep
	  echo "Then: chsh -s \$(which zsh)"
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
