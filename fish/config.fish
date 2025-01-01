set -g fish_greeting "... ><^,⋗"

eval (/opt/homebrew/bin/brew shellenv)

fish_add_path /opt/homebrew/bin

if test -d /opt/homebrew/opt/ruby/bin
  fish_add_path /opt/homebrew/opt/ruby/bin
end

if test -d $HOME/.orbstack/bin
  fish_add_path $HOME/.orbstack/bin
end

fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/bin

set -gx LANG en_US.UTF-8
set -gx QMK_HOME $HOME/src/qmk_firmware
set -gx EDITOR nvim
set -gx BAT_THEME base16

set -gx NAME "Kristoffer Grönlund"
set -gx EMAIL "k@ziran.se"

set -gx AWS_PROFILE mfa

if test -f $HOME/.env
  . (sed 's/^/export /' $HOME/.env | psub)
end

if test -f $HOME/.cargo/env.fish
  source $HOME/.cargo/env.fish
end

if status is-interactive
  abbr --add k kubectl

  abbr --add t tig
  abbr --add g git
  abbr --add gp git pull
  abbr --add gfa git fetch --all
  abbr --add gco git commit
  abbr --add gpf git push --force-with-lease
  abbr --add gau git autosquash
  abbr --add gab git absorb
  abbr --add gch git checkout
  abbr --add ga git add

  abbr --add vim nvim
  abbr --add vi nvim
  abbr --add e nvim


  function shu --wraps=ssh --description 'ssh unknown'
    ssh -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" $argv
  end

  if command -q lsd
    function ls --wraps=lsd --description 'alias ls lsd'
      lsd $argv
    end
  else
    function ls
      command ls --color=auto -p $argv
    end
  end

  abbr --add ll ls -l
  abbr --add la ls -a
end
