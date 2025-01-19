# my dotfiles

Ever-evolving set of configuration files.

This set is quite stripped-back to the set I am actually using on my Mac
these days.

## Install

To perform initial setup, use `setup-mac.sh` (only Mac at the moment).

Then, use `just` to process and link all the dotfiles:

```sh
just link
```


## Uninstall

To remove the bin symlinks for example, run (in zsh)

```
rm ~/bin/*(@e{'[[ $REPLY:A = ~/dotfiles/bin/* ]]'})
```
