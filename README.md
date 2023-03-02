# my dotfiles

Ever-evolving set of configuration files.

This set is quite stripped-back to the set I am actually using on my Mac
these days.


## Uninstall

To remove the bin symlinks for example, run (in zsh)

```
rm ~/bin/*(@e{'[[ $REPLY:A = ~/dotfiles/bin/* ]]'})
```
